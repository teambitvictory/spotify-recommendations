open UrlType

type response = {
  artists: SpotifyModel.artistList,
  tracks: SpotifyModel.trackList,
}

let mapResponseToItem = response => {
  let status = response.Request.status
  if status !== 200 {
    Error(RequestMapper.ResponseError({message: "Failed request with $status"}))
  } else {
    let response = response.Request.response
    switch response {
    | None => Error(RequestMapper.Empty)
    | Some(value) => {
        let artists =
          value.artists.items
          ->Array.map(ModelMapper.mapSearchArtistToItemArtist)
          ->Array.map(a => Item.Artist(a))
        let tracks =
          value.tracks.items
          ->Array.map(ModelMapper.mapSearchTrackToItemTrack)
          ->Array.map(t => Item.Track(t))
        // Often only the first artist is relevant for the search
        let searchResults = switch artists[0] {
        | Some(firstArtist) =>
          [[firstArtist], tracks, artists->Array.sliceToEnd(1)]->Array.concatMany
        | None => tracks
        }
        Ok(searchResults)
      }
    }
  }
}

let init = (token: string) => {
  let authHeader = Js.Dict.fromArray([("Authorization", "Bearer " ++ token)])

  (query: string) => {
    let queryParam =
      {
        "q": query,
        "type": "artist,track",
        "limit": 5,
      }
      ->createUrlSearchParams
      ->Js.String2.make
    Request.make(
      ~url=SpotifyEnv.searchUrl ++ queryParam,
      ~responseType=(JsonAsAny: Request.responseType<response>),
      ~headers=authHeader,
      (),
    )
    ->Future.mapError(~propagateCancel=true, RequestMapper.mapError)
    ->Future.mapResult(~propagateCancel=true, mapResponseToItem)
  }
}
