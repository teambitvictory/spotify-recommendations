@react.component
let make = (~spotifyClient: SpotifyService.spotifyClient) => {
  let (searchTerm, setSearchTerm) = React.useState(() => "")
  let debouncedSearchTerm = Hooks.useDebounce(searchTerm, 400)
  let (items, setItems) = React.useState(() => [])
  let (selected, setSelected) = Recoil.useRecoilState(SelectionState.selectionState)

  let changeSearchTerm = (event: ReactEvent.Form.t) => {
    setSearchTerm((event->ReactEvent.Form.target)["value"])
  }

  React.useEffect1(() => {
    switch debouncedSearchTerm {
    | "" => setItems(_ => [])
    | _ =>
      spotifyClient.getSearch(debouncedSearchTerm)->Future.get(response => {
        switch response {
        | Ok(results) => setItems(_ => results)
        | Error(_e) => Js.log(_e)
        }
      })
    }
    None
  }, [debouncedSearchTerm])

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
      {switch items->Array.length > 0 {
      | true =>
        items
        ->Array.map(item => {
          let (_, id) = ItemUtil.extractItemInfo(item)
          let added = selected->Array.some(itemToCheck => {
            let (_, idToCheck) = ItemUtil.extractItemInfo(itemToCheck)
            idToCheck === id
          })
          <SearchItem item added key={id} />
        })
        ->React.array
      | false =>
        <Typography style={ReactDOM.Style.make(~color="grey", ())}>
          {"Enter a search term to select items"}
        </Typography>
      }}
    </div>
  </div>
}
