@react.component
let make = () => {
  let connectSpotify = _ => AuthorizationService.authorize()

  open MaterialUi
  <div>
    <p> {"By connecting your Spotify account, you agree to our Privacy Policy"->React.string} </p>
    <Button onClick={connectSpotify}> {"Connect Spotify"->React.string} </Button>
  </div>
}
