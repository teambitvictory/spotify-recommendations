@react.component
let make = () => {
  open MaterialUi
  <div className="footer">
    <Typography>
      {`Created with ❤️ in Mannheim`->Js.String.normalize->React.string}
    </Typography>
    <Typography>
      <Link href="https://github.com/teambitvictory/spotigen" target={"_blank"}>
        {"Github"->React.string}
      </Link>
      {" | "->React.string}
      <Link href="https://bitvictory.de/spotigen/privacy.md" target={"_blank"}>
        {"Privacy Policy"->React.string}
      </Link>
      {" | "->React.string}
      <Link href="https://bitvictory.de/spotigen/imprint.md" target={"_blank"}>
        {"Imprint"->React.string}
      </Link>
    </Typography>
    <div style={ReactDOM.Style.make(~width="180px", ~margin="auto", ())}>
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
  </div>
}
