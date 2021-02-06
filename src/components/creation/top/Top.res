@react.component
let make = (~items) => {
  let selected = Recoil.useRecoilValue(SelectionState.selectionState)

  <div className={"spacing"}>
    {items
    ->Array.map(ItemUtil.extractItemInfo)
    ->Array.map(((item, id, _)) => {
      let added = selected->Array.some(itemToCheck => {
        let (_, idToCheck, _) = ItemUtil.extractItemInfo(itemToCheck)
        idToCheck === id
      })
      <SearchItem item added key={id} />
    })
    ->React.array}
  </div>
}
