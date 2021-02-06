@react.component
let make = (~spotifyClient: SpotifyService.spotifyClient, ~onSeedTooSmall) => {
  let (selectedTab, setSelectedTab) = React.useState(_ => 0)
  let (genres, setGenres) = React.useState(_ => [])
  let (topTracks, setTopTracks) = React.useState(_ => [])
  let (topArtists, setTopArtists) = React.useState(_ => [])
  let selected = Recoil.useRecoilValue(SelectionState.selectionState)
  let (_, setRecommendations) = Recoil.useRecoilState(RecommendationsState.recommendationsState)

  React.useEffect1(() => {
    spotifyClient.getGenres()->Future.get(response => {
      switch response {
      | Ok(results) => setGenres(_ => results)
      | Error(_e) => Js.log(_e)
      }
    })
    spotifyClient.getTopTracks()->Future.get(response => {
      switch response {
      | Ok(results) => setTopTracks(_ => results)
      | Error(_e) => Js.log(_e)
      }
    })
    spotifyClient.getTopArtists()->Future.get(response => {
      switch response {
      | Ok(results) => setTopArtists(_ => results)
      | Error(_e) => Js.log(_e)
      }
    })
    None
  }, [])

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
      variant=#Scrollable
      scrollButtons=#On
      value={selectedTab->MaterialUi_Types.Any}
      onChange={selectTab}
      indicatorColor=#Primary
      textColor=#Primary>
      <Tab label={"Search"->React.string} />
      <Tab label={"Top tracks"->React.string} />
      <Tab label={"Top artists"->React.string} />
      <Tab label={"Genres"->React.string} />
    </Tabs>
    {switch selectedTab {
    | 0 => <Search spotifyClient={spotifyClient} />
    | 1 => <Top items={topTracks} />
    | 2 => <Top items={topArtists} />
    | 3 => <Genres items={genres} />
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
