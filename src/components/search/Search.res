@react.component
let make = () => {
  let (searchTerm, setSearchTerm) = React.useState(() => "")
  let items = SpotifyService.getSearchResults(searchTerm)

  let changeSearchTerm = (event: ReactEvent.Form.t) => {
    setSearchTerm((event->ReactEvent.Form.target)["value"])
  }

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
