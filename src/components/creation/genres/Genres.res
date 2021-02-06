@react.component
let make = (~items) => {
  let (searchTerm, setSearchTerm) = React.useState(() => "")
  let selected = Recoil.useRecoilValue(SelectionState.selectionState)

  let changeSearchTerm = (event: ReactEvent.Form.t) => {
    setSearchTerm((event->ReactEvent.Form.target)["value"])
  }

  open MaterialUi
  <div>
    <form autoComplete="off">
      <TextField
        className={"input"}
        placeholder={"Search"}
        value={searchTerm->TextField.Value.string}
        onChange={changeSearchTerm}
        variant=#Outlined
        _type="search"
      />
    </form>
    <div className={"spacing"}>
      {switch searchTerm->String.length > 0 {
      | true =>
        items
        ->Array.map(ItemUtil.extractItemInfo)
        ->Array.keep(((_, _, name)) => {
          searchTerm !== "" && name->Js.String.toLowerCase->Js.String2.includes(searchTerm)
        })
        ->Array.map(((item, id, _)) => {
          let added = selected->Array.some(itemToCheck => {
            let (_, idToCheck, _) = ItemUtil.extractItemInfo(itemToCheck)
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
