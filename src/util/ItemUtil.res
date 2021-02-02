let extractItemInfo = (item: Item.item) => {
  let id = switch item {
  | Track({id}) => id
  | Artist({id}) => id
  | Genre({id}) => id
  }
  (item, id)
}
