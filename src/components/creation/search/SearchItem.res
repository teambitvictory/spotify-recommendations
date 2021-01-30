@react.component
let make = (~item, ~onSelect) => {
  let addItem = _ => {
    onSelect(item)
  }

  open MaterialUi
  <Item item control={<Button onClick={addItem}> {"Add"->React.string} </Button>} />
}
