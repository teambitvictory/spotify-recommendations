@react.component
let make = (~item, ~added) => {
  let (_, setSelected) = Recoil.useRecoilState(SelectionState.selectionState)

  let addItem = _ => {
    setSelected(currentSelection => Array.concat(currentSelection, [item]))
  }

  let removeItem = _ => {
    let (_, itemId) = ItemUtil.extractItemInfo(item)
    setSelected(currentSelection =>
      currentSelection->Array.keep(item => {
        let (_, id) = ItemUtil.extractItemInfo(item)
        id !== itemId
      })
    )
  }

  open MaterialUi
  let control = switch added {
  | false => <IconButton onClick={addItem}> <AddIcon /> </IconButton>
  | true => <IconButton onClick={removeItem}> <AddedIcon /> </IconButton>
  }

  <ItemComponent item showGenreLabel={false} control />
}
