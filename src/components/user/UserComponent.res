@react.component
let make = () => {
  let (_, setToken) = Recoil.useRecoilState(TokenState.tokenState)
  let user = Recoil.useRecoilValue(UserState.userState)

  let logout = event => {
    ReactEvent.Mouse.preventDefault(event)
    setToken(_ => "")
  }

  open MaterialUi
  <div className={"hbox"}>
    <Person
      name={user.name}
      image={user.image}
      item={<Typography>
        {(user.name ++ " | ")->React.string}
        <Link onClick={logout} href={"#"}> {"Logout"->React.string} </Link>
      </Typography>}
    />
  </div>
}
