@react.component
let make = () => {
  // TODO: Use recoil state here
  let isAuthenticated = true

  switch isAuthenticated {
  | true => <div className="App"> <Dashboard /> </div>
  | false => <Auth />
  }
}
