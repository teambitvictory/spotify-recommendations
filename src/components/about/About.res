@react.component
let make = () => {
  open MaterialUi
  <div style={ReactDOM.Style.make(~marginTop="32px", ())}>
    <Typography> {"Created by"->React.string} </Typography>
    <Person
      name={"Damien Jochim"}
      image={"https://pbs.twimg.com/profile_images/1284521496438874112/LDA9UyiN_400x400.jpg"}
      item={<Link href="https://twitter.com/damien_jochim" target={"_blank"}>
        {"@damien_jochim"->React.string}
      </Link>}
    />
    <Person
      name={"Stefan Blamberg"}
      image={"https://pbs.twimg.com/profile_images/1328445229221949442/1uPmXD13_400x400.jpg"}
      item={<Link href="https://twitter.com/StefanBlamberg" target={"_blank"}>
        {"@StefanBlamberg"->React.string}
      </Link>}
    />
  </div>
}
