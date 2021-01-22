%%raw(`import './App.css';`)

@bs.module("../../res/logo.png") external logo: string = "default"

@react.component
let make = () => {
  <div className="App"> <img src={logo} className="App-logo" alt="logo" /> </div>
}
