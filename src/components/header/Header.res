%%raw(`import './Header.css';`)

@react.component
let make = (~authenticated) => {
  open MaterialUi
  <div className={"header"}>
    <Typography> {"spotigen"->React.string} </Typography>
    {switch authenticated {
    | true => <UserComponent />
    | false => React.null
    }}
  </div>
}
