@react.component
let make = (~spotifyClient: SpotifyService.spotifyClient, ~onSeedTooSmall) => {
  let (selectedTab, setSelectedTab) = React.useState(_ => 0)
  let selected = Recoil.useRecoilValue(SelectionState.selectionState)
  let (_, setRecommendations) = Recoil.useRecoilState(RecommendationsState.recommendationsState)

  let generate = _ => {
    spotifyClient.getRecommendation(selected)->Future.get(response => {
      switch response {
      | Ok(results) =>
        if results->Array.length > 0 {
          setRecommendations(_ => results)
        } else {
          onSeedTooSmall()
        }
      | Error(_e) => Js.log(_e)
      }
    })
  }

  open MaterialUi
  let selectTab = (_, newTab: MaterialUi_Types.any) => {
    setSelectedTab(_ => newTab->anyUnpack)
  }

  <div>
    <Typography className={"spacing"} variant=#H4> {"Get started"->React.string} </Typography>
    <Typography>
      {"Choose tracks, genres and artists as a base for your recommendations"->React.string}
    </Typography>
    <Tabs
      className={"spacing"}
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
    | 0 => <Search spotifyClient={spotifyClient} />
    | 1 => <Genres spotifyClient={spotifyClient} />
    | _ => React.null
    }}
    <Typography variant=#H4> {"Your selection"->React.string} </Typography>
    <Selection />
    <Button
      variant=#Contained color=#Primary disabled={selected->Array.length === 0} onClick={generate}>
      {"Generate recommendations"->React.string}
    </Button>
  </div>
}
