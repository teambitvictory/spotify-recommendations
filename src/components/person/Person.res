%%raw(`import './Person.css';`)

@react.component
let make = (~name, ~image=?, ~item=?) => {
  open MaterialUi
  <div className={"person"}>
    {switch image {
    | Some(image) => <Avatar alt={name} src={image} />
    | None => <Avatar> {Js.String2.get(name, 0)->React.string} </Avatar>
    }}
    <div className={"person-name"}>
      {switch item {
      | Some(item) => item
      | None => <Typography> {name->React.string} </Typography>
      }}
    </div>
  </div>
}
