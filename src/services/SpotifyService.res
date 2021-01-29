type spotifyClient = {
    search: string => Future.t<result<array<MyRescriptApp.SearchItem.item>, MyRescriptApp.RequestMapper.error>>,
    genres: unit => Future.t<result<array<MyRescriptApp.SearchItem.item>, MyRescriptApp.RequestMapper.error>>
}

let init = (token: string) => {
    let client: spotifyClient = {
        search: SearchService.init(token),
        genres: GenresService.init(token)
    }
    client
}