@react.component
let make = () => {
  let token = Recoil.useRecoilValue(TokenState.tokenState)
  let recommendations = Recoil.useRecoilValue(RecommendationsState.recommendationsState)
  let spotifyClient = SpotifyService.init(token)

  <div>
    <Header authenticated={true} />
    {switch recommendations->Array.length > 0 {
    | true => <Recommendations />
    | false => <Creation spotifyClient={spotifyClient} />
    }}
    <About />
  </div>
}
