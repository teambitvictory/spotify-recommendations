@bs.val external localStorage: Dom.Storage2.t = "localStorage"
open UrlType;
open UUIDType;

let clientId = "2e53e2a82ee64c4dbf48f4936ae1bb02";
let stateIdKey = "sessionId"
let tokenKey = "accessToken"

let baseUrl = "https://api.spotify.com/v1"
let searchUrl = baseUrl ++ "/search?"
let genresUrl = baseUrl ++ "/recommendations/available-genre-seeds"
let recommendationUrl = baseUrl ++ "/recommendations?"
let userUrl = baseUrl ++ "/me"
let usersUrl = baseUrl ++ "/users/"
let playlistsEndpoint = "/playlists"
let playlistsUrl = baseUrl ++ "/playlists/"
let tracksEndpoint = "/tracks?"

let stateId = () => {
    let sessionId = localStorage->Dom.Storage2.getItem(stateIdKey)
    switch sessionId {
    | None => {
            let uuid = uuidv4()
            localStorage->Dom.Storage2.setItem(stateIdKey, uuid)
            uuid
        }
    | Some(s_) => s_
    }
}

let authParams = {
    "client_id": clientId,
    "response_type": "token",
    "redirect_uri": "http://localhost:3000/",
    "scope": "playlist-modify-private",
    "state": stateId() 
}->createUrlSearchParams->Js.String2.make

let authorizeUrl = "https://accounts.spotify.com/authorize?" ++ authParams