let extractItemInfo = (item: Item.item) => {
  let (id, name) = switch item {
  | Track({id, name}) => (id, name)
  | Artist({id, name}) => (id, name)
  | Genre({id, name}) => (id, name)
  }
  (item, id, name)
}
