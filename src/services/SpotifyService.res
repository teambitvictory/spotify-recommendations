type spotifyClient = {
    search: string => Future.t<result<array<MyRescriptApp.SearchItem.item>, MyRescriptApp.RequestMapper.error>>,
    genres: unit => Future.t<result<array<MyRescriptApp.SearchItem.item>, MyRescriptApp.RequestMapper.error>>
}

let make = (token: string) => {
    let client: spotifyClient = {
        search: SearchService.make(token),
        genres: GenresService.make(token)
    }
    client
}