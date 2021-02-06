@react.component
let make = () => {
  let (items, setItems) = Recoil.useRecoilState(SelectionState.selectionState)

  let removeItem = itemId => {
    setItems(currentSelection =>
      currentSelection->Array.keep(item => {
        let (_, id, _) = ItemUtil.extractItemInfo(item)
        id !== itemId
      })
    )
  }

  open MaterialUi
  <div className={"spacing"}>
    {switch items->Array.length > 0 {
    | true =>
      items
      ->Array.map(item => {
        let (_, id, _) = ItemUtil.extractItemInfo(item)
        <SelectionItem item onRemove={removeItem} id={id} key={id} />
      })
      ->React.array
    | false =>
      <Typography style={ReactDOM.Style.make(~color="grey", ())}>
        {"Select at least one item to generate recommendations"}
      </Typography>
    }}
  </div>
}
