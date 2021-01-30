@react.component
let make = () => {
  let (selectedTab, setSelectedTab) = React.useState(_ => 0)

  open MaterialUi
  let selectTab = (_, newTab: MaterialUi_Types.any) => {
    setSelectedTab(_ => newTab->anyUnpack)
  }

  <div>
    <Typography>
      {"Choose tracks, genres and artists as a base for your recommendations"->React.string}
    </Typography>
    <Tabs
      variant=#FullWidth
      value={selectedTab->MaterialUi_Types.Any}
      onChange={selectTab}
      indicatorColor=#Primary
      textColor=#Primary
      centered={true}>
      <Tab label={"Search"->React.string} />
      // <Tab label={"Top tracks"->React.string} />
      // <Tab label={"Top artists"->React.string} />
      <Tab label={"Genres"->React.string} />
    </Tabs>
    {switch selectedTab {
    | 0 => <Search />
    | 1 => <Genres />
    | _ => React.null
    }}
    <Typography> {"Your selection"->React.string} </Typography>
    <Selection />
  </div>
}
