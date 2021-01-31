%%raw(`import './Item.css';`)

@react.component
let make = (~item: Item.item, ~showGenreLabel, ~control) => {
  open MaterialUi
  let (name, image, description) = switch item {
  | Track({name, image, artists}) => (
      name,
      image,
      "Track by " ++ artists->Array.joinWith(", ", artist => artist.name),
    )
  | Artist({name, image}) => (name, image, "Artist")
  | Genre({name}) => (name, "", showGenreLabel ? "Genre" : "")
  }

  <div className={"item"}>
    {switch image {
    | "" =>
      <Avatar className={"cover"} variant=#Square> {Js.String2.get(name, 0)->React.string} </Avatar>
    | _ => <img className={"cover"} src={image} />
    }}
    <div className={"caption"}>
      <Typography> {name->React.string} </Typography>
      {switch description {
      | "" => React.null
      | _ => <Typography className={"description"}> {description->React.string} </Typography>
      }}
    </div>
    {control}
  </div>
}
