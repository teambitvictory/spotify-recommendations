open UrlType

type response = {tracks: array<SpotifyModel.trackItem>, seeds: array<Item.item>}

let mapResponseToItem = (response, totalSeedSize) => {
  let status = response.Request.status
  if status !== 200 {
    Error(RequestMapper.ResponseError({message: "Failed request with $status"}))
  } else {
    let response = response.Request.response
    switch response {
    | None => Error(RequestMapper.Empty)
    | Some(value) => {
        // If there are multiple requests, only select a subset of items
        let numberOfTracksToSelect =
          (value.seeds->Array.length->Int.toFloat /.
          totalSeedSize->Int.toFloat *.
          value.tracks->Array.length->Int.toFloat)->Js.Math.ceil_int

        let tracks =
          value.tracks
          ->Array.map(ModelMapper.mapSearchTrackToItemTrack)
          ->Array.map(t => Item.Track(t))
          ->Array.shuffle
          ->Array.slice(~offset=0, ~len=numberOfTracksToSelect)
        Ok(tracks)
      }
    }
  }
}

let getSeedItems = (items: array<Item.item>, itemType: string) => {
  items
  ->Array.map(item =>
    switch (itemType, item) {
    | ("track", Item.Track(item)) => item.id
    | ("artist", Item.Artist(item)) => item.id
    | ("genre", Item.Genre(item)) => item.id
    | _ => ""
    }
  )
  ->Array.keep(id => id->String.length > 0)
  ->Js.Array2.joinWith(",")
}

let generateQueryParam = (items: array<Item.item>, amount) => {
  let queryParam = HashMap.String.fromArray([])
  queryParam->HashMap.String.set("limit", amount->Int.toString)
  let seedArtists = getSeedItems(items, "artist")
  if seedArtists->String.length > 0 {
    queryParam->HashMap.String.set("seed_artists", seedArtists)
  }
  let seedTracks = getSeedItems(items, "track")
  if seedTracks->String.length > 0 {
    queryParam->HashMap.String.set("seed_tracks", seedTracks)
  }
  let seedGenres = getSeedItems(items, "genre")
  if seedGenres->String.length > 0 {
    queryParam->HashMap.String.set("seed_genres", seedGenres)
  }
  queryParam->HashMap.String.toArray->createUrlSearchParams->Js.String2.make
}

let init = (token: string) => {
  let authHeader = Js.Dict.fromArray([("Authorization", "Bearer " ++ token)])

  (items: array<Item.item>) => {
    // Split items into subsets to make sure to send max 5 items to API at once
    let shuffledItems = items->Array.shuffle
    let maxSize = 5

    let requests = Array.makeBy(
      Js.Math.ceil_int(shuffledItems->Array.length->Int.toFloat /. maxSize->Int.toFloat),
      idx => {
        let offset = idx * maxSize
        let numberOfRemainingItems = shuffledItems->Array.length - offset
        let n = numberOfRemainingItems > maxSize ? maxSize : numberOfRemainingItems
        let subset = shuffledItems->Array.slice(~offset, ~len=n)

        // Generate 20 items for each subset
        let queryParam = generateQueryParam(subset, 20)
        Request.make(
          ~url=SpotifyEnv.recommendationUrl ++ queryParam,
          ~responseType=(JsonAsAny: Request.responseType<response>),
          ~headers=authHeader,
          (),
        )
      },
    )

    Future.all(requests)->Future.map(results => {
      let resultMap = results->Array.map(result => {
        switch result {
        | Ok(response) => mapResponseToItem(response, items->Array.length)
        | Error(err) => Error(RequestMapper.mapError(err))
        }
      })

      // If there is an error, reject the whole batch
      let err = resultMap->Js.Array2.find(result => {
        switch result {
        | Error(_) => true
        | _ => false
        }
      })

      switch err {
      | Some(err) => err
      | None =>
        Ok(
          Array.concatMany(
            resultMap->Array.map(result => {
              switch result {
              | Ok(result) => result
              | _ => []
              }
            }),
          ),
        )
      }
    })
  }
}
