type genre = {
  id: string,
  name: string
}

type artist = {
  id: string,
  name: string,
  image: string,
}

type track = {
  id: string,
  artists: array<artist>,
  name: string,
  image: string,
  uri: string
}

type item =
  | Genre(genre)
  | Artist(artist)
  | Track(track)