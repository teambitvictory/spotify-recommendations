type response = {
  genres: array<string>
}

let mapGenresKeyToGenresItem = (gKey: string) => {
    Item.Genre({
        id: gKey,
        name: gKey
    })
}

let mapResponseToItem = (response) => {
  let status = response.Request.status
  if status !== 200 {
    Error(RequestMapper.ResponseError({message: "Failed request with $status"}))
  } else {
    let response = response.Request.response
    switch response {
    | None => Error(RequestMapper.Empty)
    | Some(value) => {
        let genres = value.genres->Array.map(mapGenresKeyToGenresItem)
        Ok(genres)
      }
    }
  }
}

let init = (token: string) => {

    let authHeader = Js.Dict.fromArray([("Authorization", "Bearer "++token)])

    () => {
        Request.make(~url=SpotifyEnv.genresUrl, ~responseType=JsonAsAny: Request.responseType<response>, ~headers=authHeader, ())   
            -> Future.mapError(~propagateCancel=true, RequestMapper.mapError)
            -> Future.mapResult(~propagateCancel=true, mapResponseToItem)
    }

}