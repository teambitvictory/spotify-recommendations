@react.component
let make = (~item) => {
  let addItem = _ => {
    Js.log("Added")
  }

  open MaterialUi
  <div> <Item item /> <Button onClick={addItem}> {"Add"->React.string} </Button> </div>
}
