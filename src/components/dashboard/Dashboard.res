@react.component
let make = () => {
  let token = Recoil.useRecoilValue(TokenState.tokenState)
  let recommendations = Recoil.useRecoilValue(RecommendationsState.recommendationsState)
  let (_, setUser) = Recoil.useRecoilState(UserState.userState)
  let (snackbarOpen, setSnackbarOpen) = React.useState(_ => false)
  let spotifyClient = SpotifyService.init(token)

  React.useEffect1(() => {
    spotifyClient.getUser()->Future.get(response => {
      switch response {
      | Ok(user) => setUser(_ => user)
      | Error(_e) => Js.log(_e)
      }
    })
    None
  }, [])

  let handleAlertClose = _ => {
    setSnackbarOpen(_ => false)
  }

  let handleClose = (_, _) => handleAlertClose(None)

  let onPlaylistCreated = () => {
    setSnackbarOpen(_ => true)
  }

  open MaterialUi
  open MaterialUi_Lab
  <div>
    <Header authenticated={true} />
    {switch recommendations->Array.length > 0 {
    | true => <Recommendations spotifyClient onPlaylistCreated />
    | false => <Creation spotifyClient />
    }}
    <About />
    <Snackbar
      _open={snackbarOpen}
      autoHideDuration={6000->MaterialUi_Types.Number.int}
      onClose={handleClose}>
      <Alert onClose={handleAlertClose} severity=#Success> {"Playlist saved"->React.string} </Alert>
    </Snackbar>
  </div>
}
