
let mapSearchArtistToItemArtist = (artist: SearchResponse.artistItem) => {
  let startImg: SearchResponse.image = {height: 999999, url: ""} 
  let image = switch artist.images {
  | None => startImg
  | Some(a_) => a_->Array.reduce(startImg, (a, b) => a.height < b.height? a:b )
  }
  let item: SearchItem.artist = {
    id: artist.id,
    name: artist.name,
    image: image.url,
  }
  item
}

let mapSearchTrackToItemTrack = (track: SearchResponse.trackItem) => {
  let startImg: SearchResponse.image = {height: 999999, url: ""} 
  let image = switch track.album.images {
  | None => startImg
  | Some(a_) => a_->Array.reduce(startImg, (a, b) => a.height < b.height? a:b )
  }
  let item: SearchItem.track = {
    id: track.id,
    artists: track.artists->Array.map(mapSearchArtistToItemArtist),
    name: track.name,
    image: image.url,
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
        Js.log(artists)
        Js.log(tracks)
        Ok(artists->Array.concat(tracks))
      }
    }
  }
}