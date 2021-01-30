%%raw(`import './Item.css';`)

@react.component
let make = (~item: SpotifyService.item, ~control) => {
  open MaterialUi
  let (name, image, description) = switch item {
  | Track({name, image, artists}) => (
      name,
      image,
      "Track by " ++ artists->Array.joinWith(", ", artist => artist.name),
    )
  | Artist({name, image}) => (name, image, "Artist")
  | Genre({name, image}) => (name, image, "Genre")
  }

  <div className={"item"}>
    <img src={image} />
    <div className={"caption"}>
      <Typography> {name->React.string} </Typography>
      <Typography className={"description"}> {description->React.string} </Typography>
    </div>
    {control}
  </div>
}
