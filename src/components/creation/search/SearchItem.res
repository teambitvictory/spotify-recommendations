@react.component
let make = (~item, ~onSelect) => {
  let addItem = _ => {
    onSelect(item)
  }

  open MaterialUi
  <ItemComponent
    item showGenreLabel={false} control={<Button onClick={addItem}> {"Add"->React.string} </Button>}
  />
}
