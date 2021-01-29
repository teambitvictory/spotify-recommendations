let getSmallestImage = (images: option<array<SearchResponse.image>>) => {
  let startImg: SearchResponse.image = {height: 999999, url: ""} 
  switch images {
  | None => startImg
  | Some(a_) => a_->Array.reduce(startImg, (a, b) => a.height < b.height? a:b )
  }
}

let mapSearchArtistToItemArtist = (artist: SearchResponse.artistItem) => {
  let item: SearchItem.artist = {
    id: artist.id,
    name: artist.name,
    image: (artist.images->getSmallestImage).url,
  }
  item
}

let mapSearchTrackToItemTrack = (track: SearchResponse.trackItem) => {
  let item: SearchItem.track = {
    id: track.id,
    artists: track.artists->Array.map(mapSearchArtistToItemArtist),
    name: track.name,
    image: (track.album.images->getSmallestImage).url,
  }
  item
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
        let artists = value.SearchResponse.artists.items->Array.map(mapSearchArtistToItemArtist)->Array.map(a => SearchItem.Artist(a))
        let tracks = value.SearchResponse.tracks.items->Array.map(mapSearchTrackToItemTrack)->Array.map(t => SearchItem.Track(t))
        Ok(artists->Array.concat(tracks))
      }
    }
  }
}