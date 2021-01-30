@react.component
let make = () => {
  let (playlistName, setPlaylistName) = React.useState(() => "")
  let items = Recoil.useRecoilValue(RecommendationsState.recommendationsState)

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
    {items
    ->Array.map(item => {
      let id = switch item {
      | Track({id}) => id
      | Artist({id}) => id
      | Genre({id}) => id
      }
      <ItemComponent item showGenreLabel={false} control={React.null} key={id} />
    })
    ->React.array}
  </div>
}
