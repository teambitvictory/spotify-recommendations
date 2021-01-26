open UrlType;

let make = (token: string) => {

    let authHeader = Js.Dict.fromArray([("Authorization", "Bearer "++token)])

    (query: string) => {
        let queryParam = {
            "q": query,
            "type": "artist,track",
        }->createUrlSearchParams->Js.String2.make
        Request.make(~url=SpotifyEnv.searchUrl ++ queryParam, ~responseType=JsonAsAny: Request.responseType<SearchResponse.response>, ~headers=authHeader, ())   
            -> Future.mapError(~propagateCancel=true, RequestMapper.mapError)
            -> Future.mapResult(~propagateCancel=true, SearchResponseMapper.mapResponseToItem)
    }

}