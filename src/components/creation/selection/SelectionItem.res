@react.component
let make = (~item, ~id, ~onRemove) => {
  let removeItem = _ => {
    onRemove(id)
  }

  open MaterialUi
  <Item item control={<Button onClick={removeItem}> {"Remove"->React.string} </Button>} />
}
