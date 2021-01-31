@react.component
let make = () => {
  let (playlistName, setPlaylistName) = React.useState(() => "")
  let (items, setItems) = Recoil.useRecoilState(RecommendationsState.recommendationsState)

  let changePlaylistName = (event: ReactEvent.Form.t) => {
    setPlaylistName((event->ReactEvent.Form.target)["value"])
  }

  let goBack = _ => {
    setItems(_ => [])
  }

  open MaterialUi
  <div>
    <Button onClick={goBack}> {"<- Back to selection"->React.string} </Button>
    <Typography variant=#H4> {"Recommendations"->React.string} </Typography>
    <div className={"hbox"} style={ReactDOM.Style.make(~margin="16px auto", ())}>
      <TextField
        style={ReactDOM.Style.make(~flex="1", ~marginRight="8px", ())}
        value={playlistName->TextField.Value.string}
        onChange={changePlaylistName}
        placeholder={"Playlist Name"}
        variant=#Outlined
      />
      <Button variant=#Contained color=#Primary disabled={playlistName->String.length === 0}>
        {"Save in Spotify"->React.string}
      </Button>
    </div>
    {items
    ->Array.map(item => {
      let (_, id) = ItemUtil.extractItemInfo(item)
      <ItemComponent item showGenreLabel={false} control={React.null} key={id} />
    })
    ->React.array}
  </div>
}
