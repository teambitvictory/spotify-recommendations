%%raw(`import './App.css';`)

@bs.module("../../res/logo.png") external logo: string = "default"

@react.component
let make = () => {
  let imageClick = (event) => {
    //AuthorizationService.authorize()
    let spotifyApi = SpotifyService.init("BQCMh8vxwsnhOQhNFjQl4uZR9PH9KV89DQeZi1SYEkDXe5EeTqsXpsLGUASqDOeG-0fYWEqBES91_sgMSGiRExB9qnHrhkPp16QXEPIzzCU_l2GTEofAYMWtBmbxxbXHZ8FiDA83j-Y7B8jJJFiWhOZKV64vmDw0AXDp1kNCkqalj4Q")
    spotifyApi.search("Kontra K")->Future.get(response => {
      switch response {
      | Ok(_i) => {
        let search = _i->Array.shuffle->Array.slice(~offset=0, ~len=5)
        Js.log(search)
        let recommendationApi = RecommendationService.init("BQCMh8vxwsnhOQhNFjQl4uZR9PH9KV89DQeZi1SYEkDXe5EeTqsXpsLGUASqDOeG-0fYWEqBES91_sgMSGiRExB9qnHrhkPp16QXEPIzzCU_l2GTEofAYMWtBmbxxbXHZ8FiDA83j-Y7B8jJJFiWhOZKV64vmDw0AXDp1kNCkqalj4Q")
        let recc = recommendationApi(search)
        //Js.log(recc)
      }
      | Error(_e) => Js.log(_e)
      }
    })
  }

  <div className="App"> <img src={logo} onClick={imageClick} className="App-logo" alt="logo" /> </div>
}