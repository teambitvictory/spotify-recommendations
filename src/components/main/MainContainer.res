@react.component
let make = () => {
  let (token, setToken) = Recoil.useRecoilState(TokenState.tokenState)

  React.useEffect1(() => {
    switch AuthorizationService.getTokenFromCallback() {
    | Some(token) => setToken(_ => token)
    | None => setToken(_ => "")
    }
    None
  }, [])

  switch token->String.length > 0 {
  | true => <div className="App"> <Dashboard /> </div>
  | false => <Auth />
  }
}
