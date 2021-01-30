@react.component
let make = () => {
  let (_, setToken) = Recoil.useRecoilState(TokenState.tokenState)
  let username = "Guest"

  let logout = event => {
    ReactEvent.Mouse.preventDefault(event)
    setToken(_ => "")
  }

  open MaterialUi
  <div className={"hbox"}>
    <Person
      name={username}
      item={<Typography>
        {(username ++ " | ")->React.string}
        <Link
        // style={ReactDOM.Style.make(~marginLeft="8px", ())}
          onClick={logout} href={"#"}>
          {"Logout"->React.string}
        </Link>
      </Typography>}
    />
  </div>
}
