@bs.module("./lpimage.svg") external logo: string = "default"
@react.component
let make = () => {
  let connectSpotify = _ => AuthorizationService.authorize()

  open MaterialUi
  <div className="landing">
    <div className="spacing">
      <img src={logo} alt="logo" style={ReactDOM.Style.make(~maxWidth="70%", ())} />
      <Typography variant=#H4 className="spacing">
        {"Welcome to spotigen"->React.string}
      </Typography>
      <br />
      <Typography className="spacing" style={ReactDOM.Style.make(~marginBottom="64px", ())}>
        {"Create playlists with recommendations based on your favourite tracks, artists and genres."->React.string}
      </Typography>
      <Typography className="spacing" style={ReactDOM.Style.make(~marginBottom="16px", ())}>
        {"By connecting your Spotify account, you agree to our "->React.string}
        <Link href="https://bitvictory.de/spotigen/privacy.md" target={"_blank"}>
          {"privacy policy"->React.string}
        </Link>
      </Typography>
      <Button variant=#Contained color=#Primary onClick={connectSpotify}>
        {"Login with Spotify"->React.string}
      </Button>
    </div>
  </div>
}
