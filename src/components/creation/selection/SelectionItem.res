@react.component
let make = (~item, ~id, ~onRemove) => {
  let removeItem = _ => {
    onRemove(id)
  }

  open MaterialUi
  <ItemComponent
    item
    showGenreLabel={true}
    control={<IconButton onClick={removeItem}> <RemoveIcon /> </IconButton>}
  />
}
