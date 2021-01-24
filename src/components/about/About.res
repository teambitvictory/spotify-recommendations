@react.component
let make = () => {
  <div>
    <p>
      <span> {"Created by "->React.string} </span>
      <a href={"https://twitter.com/damien_jochim"} target={"_blank"}>
        {"Damien Jochim"->React.string}
      </a>
      <span> {" and "->React.string} </span>
      <a href={"https://twitter.com/StefanBlamberg"} target={"_blank"}>
        {"Stefan Blamberg"->React.string}
      </a>
    </p>
  </div>
}
