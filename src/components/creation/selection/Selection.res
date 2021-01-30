@react.component
let make = () => {
  let (items, setItems) = Recoil.useRecoilState(SelectionState.selectionState)

  let removeItem = itemId => {
    setItems(currentSelection =>
      currentSelection->Array.keep(item => {
        let id = switch item {
        | Track({id}) => id
        | Artist({id}) => id
        | Genre({id}) => id
        }
        id !== itemId
      })
    )
  }

  open MaterialUi
  <div>
    {items
    ->Array.map(item => {
      let id = switch item {
      | Track({id}) => id
      | Artist({id}) => id
      | Genre({id}) => id
      }
      <SelectionItem item onRemove={removeItem} id={id} key={id} />
    })
    ->React.array}
    <Button variant=#Contained color=#Primary> {"Generate recommendations"->React.string} </Button>
  </div>
}
