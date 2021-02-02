@react.component
let make = (~spotifyClient: SpotifyService.spotifyClient) => {
  let (items, setItems) = React.useState(() => [])
  let (searchTerm, setSearchTerm) = React.useState(() => "")
  let (selected, setSelected) = Recoil.useRecoilState(SelectionState.selectionState)

  let changeSearchTerm = (event: ReactEvent.Form.t) => {
    setSearchTerm((event->ReactEvent.Form.target)["value"])
  }

  React.useEffect1(() => {
    spotifyClient.getGenres()->Future.get(response => {
      switch response {
      | Ok(results) => setItems(_ => results)
      | Error(_e) => Js.log(_e)
      }
    })
    None
  }, [])

  open MaterialUi
  <div>
    <form autoComplete="off">
      <TextField
        className={"input"}
        placeholder={"Search"}
        value={searchTerm->TextField.Value.string}
        onChange={changeSearchTerm}
        variant=#Outlined
      />
    </form>
    <div className={"spacing"}>
      {switch searchTerm->String.length > 0 {
      | true =>
        items
        ->Array.map(ItemUtil.extractItemInfo)
        ->Array.keep(((_, id)) => {
          searchTerm !== "" && id->Js.String2.includes(searchTerm)
        })
        ->Array.map(((item, id)) => {
          let added = selected->Array.some(itemToCheck => {
            let (_, idToCheck) = ItemUtil.extractItemInfo(itemToCheck)
            idToCheck === id
          })
          <SearchItem item added key={id} />
        })
        ->React.array
      | false =>
        <Typography style={ReactDOM.Style.make(~color="grey", ())}>
          {"Enter a search term to select genres"}
        </Typography>
      }}
    </div>
  </div>
}
