@react.component
let make = (~spotifyClient: SpotifyService.spotifyClient) => {
  let (items, setItems) = React.useState(() => [])
  let (searchTerm, setSearchTerm) = React.useState(() => "")

  let (_, setSelected) = Recoil.useRecoilState(SelectionState.selectionState)

  let changeSearchTerm = (event: ReactEvent.Form.t) => {
    setSearchTerm((event->ReactEvent.Form.target)["value"])
  }

  let selectItem = item => {
    setSelected(currentSelection => Array.concat(currentSelection, [item]))
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
    {items
    ->Array.map(item => {
      let id = switch item {
      | Track({id}) => id
      | Artist({id}) => id
      | Genre({id}) => id
      }
      (item, id)
    })
    ->Array.keep(((_, id)) => {
      searchTerm !== "" && id->Js.String2.includes(searchTerm)
    })
    ->Array.map(((item, id)) => {
      <SearchItem item onSelect={selectItem} key={id} />
    })
    ->React.array}
  </div>
}
