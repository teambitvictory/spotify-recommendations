open UrlType;

let make = (token: string) => {

    let authHeader = Js.Dict.fromArray([("Authorization", "Bearer "++token)])

    () => {
        Request.make(~url=SpotifyEnv.genresUrl, ~responseType=JsonAsAny: Request.responseType<GenresResponse.response>, ~headers=authHeader, ())   
            -> Future.mapError(~propagateCancel=true, RequestMapper.mapError)
            -> Future.mapResult(~propagateCancel=true, GenresResponseMapper.mapResponseToItem)
    }

}