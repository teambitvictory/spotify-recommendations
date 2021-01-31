type spotifyClient = {
    getSearch: string => Future.t<result<array<Item.item>, RequestMapper.error>>,
    getGenres: unit => Future.t<result<array<Item.item>, RequestMapper.error>>,
    getRecommendation: array<Item.item> => Future.t<result<array<Item.item>, RequestMapper.error>>,
    createPlaylist: (string, string, array<Item.item>) => Future.t<string>,
    getUser: unit => Future.t<result<User.user, RequestMapper.error>>
}

let init = (token: string) => {
    let client: spotifyClient = {
        getSearch: SearchService.init(token),
        getGenres: GenresService.init(token),
        getRecommendation: RecommendationService.init(token),
        getUser: UserService.init(token),
        createPlaylist: PlaylistService.init(token)
    }
    client
}