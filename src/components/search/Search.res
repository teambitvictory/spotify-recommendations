@react.component
let make = () => {
  let (searchTerm, setSearchTerm) = React.useState(() => "")
  let debouncedSearchTerm = Hooks.useDebounce(searchTerm, 400)
  let (items, setItems) = React.useState(() => [])

  let changeSearchTerm = (event: ReactEvent.Form.t) => {
    setSearchTerm((event->ReactEvent.Form.target)["value"])
  }

  React.useEffect1(() => {
    setItems(_ => SpotifyService.getSearchResults(debouncedSearchTerm))
    None
  }, [debouncedSearchTerm])

  open MaterialUi
  <div>
    <form autoComplete="off">
      <TextField
        label={"Search"->React.string}
        value={searchTerm->TextField.Value.string}
        onChange={changeSearchTerm}
        variant=#Outlined
      />
    </form>
    <p> {debouncedSearchTerm->React.string} </p>
    {items
    ->Array.map(item => {
      let id = switch item {
      | Track({id}) => id
      | Artist({id}) => id
      | Genre({id}) => id
      }
      <SearchItem item key={id} />
    })
    ->React.array}
  </div>
}
