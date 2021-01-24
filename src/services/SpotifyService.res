type genre = {
  id: string,
  name: string,
  image: string,
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
}

type item =
  | Genre(genre)
  | Artist(artist)
  | Track(track)

let getSearchResults = (searchTerm): array<item> => {
  let sampleArtist = {
    id: "testArtist",
    name: "Eminem",
    image: "",
  }

  [
    Track({
      id: "testTrack",
      artists: [sampleArtist],
      name: "Lose Yourself",
      image: "https://i.scdn.co/image/ab67616d00004851b6ef2ebd34efb08cb76f6eec",
    }),
    Artist(sampleArtist),
  ]
}
