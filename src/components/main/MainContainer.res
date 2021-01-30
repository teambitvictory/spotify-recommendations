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

  open MaterialUi
  <Container maxWidth={Container.MaxWidth.sm}>
    {switch token->String.length > 0 {
    | true => <Dashboard />
    | false => <Auth />
    }}
  </Container>
}
