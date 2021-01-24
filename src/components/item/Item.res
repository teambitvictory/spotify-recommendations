@react.component
let make = (~item: SpotifyService.item) => {
  let (name, image, description) = switch item {
  | Track({name, image, artists}) => (
      name,
      image,
      "Track by " ++ artists->Array.joinWith(", ", artist => artist.name),
    )
  | Artist({name, image}) => (name, image, "Artist")
  | Genre({name, image}) => (name, image, "Genre")
  }

  <div>
    <img src={image} /> <p> {name->React.string} </p> <p> {description->React.string} </p>
  </div>
}
