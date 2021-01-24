@react.component
let make = () => {
  let (playlistName, setPlaylistName) = React.useState(() => "")
  let items: array<SpotifyService.item> = []

  let changePlaylistName = (event: ReactEvent.Form.t) => {
    setPlaylistName((event->ReactEvent.Form.target)["value"])
  }

  open MaterialUi
  <div>
    <form autoComplete="off">
      <TextField
        value={playlistName->TextField.Value.string}
        onChange={changePlaylistName}
        placeholder={"Playlist Name"}
        variant=#Outlined
      />
    </form>
    <Button> {"Save in Spotify"->React.string} </Button>
  </div>
}
