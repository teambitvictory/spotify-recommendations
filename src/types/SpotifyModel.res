type image = {
  url: string,
  height: int
}

type artistItem = {
  id: string,
  name: string,
  images: option<array<image>>,
}

type artistList = {
  items: array<artistItem>,
}

type album = {
  images: option<array<image>>,
}

type trackItem = {
  id: string,
  name: string,
  artists: array<artistItem>,
  album: album,
  uri: string
}

type trackList = {
  items: array<trackItem>,
}
