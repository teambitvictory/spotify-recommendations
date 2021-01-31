open UrlType;

type responseArtist = {
  items: SpotifyModel.artistItem,
}

type responseTrack = {
  items: SpotifyModel.trackItem,
}

let mapTrackResponseToItem = (response) => {
  let status = response.Request.status
  if status !== 200 {
    Error(RequestMapper.ResponseError({message: "Failed request with $status"}))
  } else {
    let responseBody: option<SpotifyModel.trackList> = response.Request.response
    switch responseBody {
    | None => Error(RequestMapper.Empty)
    | Some(value) => Ok(value.items->Array.map(ModelMapper.mapSearchTrackToItemTrack)->Array.map(t => Item.Track(t)))
    }
  }
}

let mapArtistResponseToItem = (response) => {
  let status = response.Request.status
  if status !== 200 {
    Error(RequestMapper.ResponseError({message: "Failed request with $status"}))
  } else {
    let responseBody: option<SpotifyModel.artistList> = response.Request.response
    switch responseBody {
    | None => Error(RequestMapper.Empty)
    | Some(value) => Ok(value.items->Array.map(ModelMapper.mapSearchArtistToItemArtist)->Array.map(a => Item.Artist(a)))
    }
  }
}

let queryParam = {
    "limit": 10
}->createUrlSearchParams->Js.String2.make

let initTopTracks = (token: string) => {

    let authHeader = Js.Dict.fromArray([("Authorization", "Bearer "++token)])

    () => {
        Request.make(~url=SpotifyEnv.topUrl ++ SpotifyEnv.topTracksEndpoint ++ queryParam, ~responseType=JsonAsAny: Request.responseType<SpotifyModel.trackList>, ~headers=authHeader, ())   
            -> Future.mapError(~propagateCancel=true, RequestMapper.mapError)
            -> Future.mapResult(~propagateCancel=true, mapTrackResponseToItem)
    }
}

let initTopArtist = (token: string) => {

    let authHeader = Js.Dict.fromArray([("Authorization", "Bearer "++token)])

    () => {
        Request.make(~url=SpotifyEnv.topUrl ++ SpotifyEnv.topTracksEndpoint ++ queryParam, ~responseType=JsonAsAny: Request.responseType<SpotifyModel.artistList>, ~headers=authHeader, ())   
            -> Future.mapError(~propagateCancel=true, RequestMapper.mapError)
            -> Future.mapResult(~propagateCancel=true, mapArtistResponseToItem)
    }
}