@react.component
let make = (~spotifyClient: SpotifyService.spotifyClient, ~onPlaylistCreated) => {
  let (playlistName, setPlaylistName) = React.useState(() => "")
  let (items, setItems) = Recoil.useRecoilState(RecommendationsState.recommendationsState)
  let user = Recoil.useRecoilValue(UserState.userState)

  let changePlaylistName = (event: ReactEvent.Form.t) => {
    setPlaylistName((event->ReactEvent.Form.target)["value"])
  }

  let goBack = _ => {
    setItems(_ => [])
  }

  let createPlaylist = _ => {
    spotifyClient.createPlaylist(user.id, playlistName, items)->Future.get(response => {
      switch response {
      | _ => {
          goBack()
          onPlaylistCreated()
        }
      }
    })
  }

  open MaterialUi
  <div>
    <Button onClick={goBack} startIcon={<BackIcon />}> {"Back to selection"->React.string} </Button>
    <Typography variant=#H4> {"Recommendations"->React.string} </Typography>
    <div className={"hbox"} style={ReactDOM.Style.make(~margin="16px auto", ())}>
      <TextField
        style={ReactDOM.Style.make(~flex="1", ~marginRight="8px", ())}
        value={playlistName->TextField.Value.string}
        onChange={changePlaylistName}
        placeholder={"Playlist Name"}
        variant=#Outlined
      />
      <Button
        onClick={createPlaylist}
        variant=#Contained
        color=#Primary
        disabled={playlistName->String.length === 0}>
        {"Save in Spotify"->React.string}
      </Button>
    </div>
    {items
    ->Array.map(item => {
      let (_, id, _) = ItemUtil.extractItemInfo(item)
      <ItemComponent item showGenreLabel={false} control={React.null} key={id} />
    })
    ->React.array}
  </div>
}
