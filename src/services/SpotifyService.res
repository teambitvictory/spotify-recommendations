type spotifyClient = {
    search: string => Future.t<result<array<Item.item>, RequestMapper.error>>,
    genres: unit => Future.t<result<array<Item.item>, RequestMapper.error>>,
    recommendation: array<Item.item> => Future.t<result<array<Item.item>, RequestMapper.error>>
}

let init = (token: string) => {
    let client: spotifyClient = {
        search: SearchService.init(token),
        genres: GenresService.init(token),
        recommendation: RecommendationService.init(token)
    }
    client
}