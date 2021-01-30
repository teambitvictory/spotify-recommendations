let getSmallestImage = (images: option<array<SpotifyModel.image>>) => {
  let startImg: SpotifyModel.image = {height: 999999, url: ""} 
  switch images {
  | None => startImg
  | Some(a_) => a_->Array.reduce(startImg, (a, b) => a.height < b.height? a:b )
  }
}

let mapSearchArtistToItemArtist = (artist: SpotifyModel.artistItem) => {
  let item: Item.artist = {
    id: artist.id,
    name: artist.name,
    image: (artist.images->getSmallestImage).url,
  }
  item
}

let mapSearchTrackToItemTrack = (track: SpotifyModel.trackItem) => {
  let item: Item.track = {
    id: track.id,
    artists: track.artists->Array.map(mapSearchArtistToItemArtist),
    name: track.name,
    image: (track.album.images->getSmallestImage).url,
  }
  item
}