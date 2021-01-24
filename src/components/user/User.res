@react.component
let make = () => {
  open MaterialUi
  let username = "Guest"
  <div>
    <p> {username->React.string} </p> <Avatar> {Js.String2.get(username, 0)->React.string} </Avatar>
  </div>
}
