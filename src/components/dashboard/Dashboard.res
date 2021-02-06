@react.component
let make = () => {
  let token = Recoil.useRecoilValue(TokenState.tokenState)
  let recommendations = Recoil.useRecoilValue(RecommendationsState.recommendationsState)
  let (_, setUser) = Recoil.useRecoilState(UserState.userState)
  let (snackbarMessage, setSnackbarMessage) = React.useState(_ => "")
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
    setSnackbarMessage(_ => "")
  }

  let handleClose = (_, _) => handleAlertClose(None)

  let onPlaylistCreated = () => {
    setSnackbarMessage(_ => "PLAYLIST_CREATED")
  }

  let onSeedTooSmall = () => {
    setSnackbarMessage(_ => "NO_CONTENT")
  }

  let (severity, message) = switch snackbarMessage {
  | "PLAYLIST_CREATED" => (#Success, "Playlist created")
  | "NO_CONTENT" => (#Error, "More seed items required")
  | _ => (#Error, "Unknown error")
  }
  open MaterialUi
  open MaterialUi_Lab
  <div>
    {switch recommendations->Array.length > 0 {
    | true => <Recommendations spotifyClient onPlaylistCreated />
    | false => <Creation spotifyClient onSeedTooSmall />
    }}
    <Snackbar
      _open={snackbarMessage->String.length > 0}
      autoHideDuration={6000->MaterialUi_Types.Number.int}
      onClose={handleClose}>
      <Alert onClose={handleAlertClose} severity={severity}> {message->React.string} </Alert>
    </Snackbar>
  </div>
}
