open UrlType;

type createResponse = {
    id: string,
    name: string,
    uri: string
}

type addResponse = {
    snapshot_id: string
}

let createPlaylistMapping = (response) => {
  let status = response.Request.status
  if status !== 201 {
    Js.log(response)
    Error(RequestMapper.ResponseError({message: "Failed request to create Playlist"}))
  } else {
    let response = response.Request.response
    switch response {
    | None => Error(RequestMapper.Empty)
    | Some(value) => Ok(value)
    }
  }
}

let createPlaylist = (userId: string, playlistName: string, authHeader: Js.Dict.t<string>) => {
    let dict = Js.Dict.empty()
    Js.Dict.set(dict, "name", Js.Json.string(playlistName))
    Js.Dict.set(dict, "public", Js.Json.boolean(false))

    let body = dict->Js.Json.object_->Js.Json.stringify
    Js.log(body)
    Request.make(~url=SpotifyEnv.usersUrl ++ userId ++ SpotifyEnv.playlistsEndpoint, ~method=#POST, ~body=body, ~responseType=JsonAsAny: Request.responseType<createResponse>, ~headers=authHeader, ())   
            -> Future.mapError(~propagateCancel=true, RequestMapper.mapError)
            -> Future.mapResult(~propagateCancel=true, createPlaylistMapping)
}

let getTrackUris = (items: array<Item.item>) => {
    items->Array.map(item=> switch item {
    | Item.Track(_i) => Some(_i.uri)
    | _ => None
    })->Array.keep(artist => switch artist {
    | Some(_a) => true
    | None => false
    })->Js.Array2.joinWith(",")
}
let generateTrackQueryParam = (items: array<Item.item>) => {
    let queryParam = HashMap.String.fromArray([])
    let seedTracks = getTrackUris(items)
    if seedTracks->String.length > 0 {
        queryParam->HashMap.String.set("uris", seedTracks)
    }
    queryParam->HashMap.String.toArray->createUrlSearchParams->Js.String2.make
}


let addTracksMapping = (response) => {
  let status = response.Request.status
  if status !== 200 {
    Error(RequestMapper.ResponseError({message: "Failed request to add tracks to playlist"}))
  } else {
    let response = response.Request.response
    switch response {
    | None => Error(RequestMapper.Empty)
    | Some(value) => Ok(value)
    }
  }
}

let addTracks = (playlistId: string, items: array<Item.item>, authHeader: Js.Dict.t<string>) => {
    let query = items->generateTrackQueryParam
    Request.make(~url=SpotifyEnv.playlistsUrl ++ playlistId ++ SpotifyEnv.tracksEndpoint ++ query, ~method=#POST, ~responseType=JsonAsAny: Request.responseType<addResponse>, ~headers=authHeader, ())   
            -> Future.mapError(~propagateCancel=true, RequestMapper.mapError)
            -> Future.mapResult(~propagateCancel=true, addTracksMapping)
}

let init = (token: string) => {

    let authHeader = Js.Dict.fromArray([("Authorization", "Bearer "++token)])

    (userId: string, playlistName: string, items: array<Item.item>) => {
        //let queryParam = generateQueryParam(items)
        createPlaylist(userId, playlistName, authHeader)
            ->Future.mapOk(~propagateCancel=true, createdPlaylist => addTracks(createdPlaylist.id, items, authHeader))
            ->Future.map(~propagateCancel=true, _ => "")
    }
}