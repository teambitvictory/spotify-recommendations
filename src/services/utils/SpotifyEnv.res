@bs.val external localStorage: Dom.Storage2.t = "localStorage"
open UrlType;
open UUIDType;

let baseUrl = "https://api.spotify.com/v1"
let clientId = "2e53e2a82ee64c4dbf48f4936ae1bb02";
let responseType = "token";
let redirectUrl = "http://localhost:3000/";
let scopes = "playlist-modify-private";
let stateIdKey = "sessionId"
let tokenKey = "accessToken"

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

let authorizeUrl = createUrl("https://accounts.spotify.com/authorize?");
authorizeUrl->searchParams->set_("client_id", clientId);
authorizeUrl->searchParams->set_("response_type", "token");
authorizeUrl->searchParams->set_("redirect_uri", redirectUrl);
authorizeUrl->searchParams->set_("scope", scopes);
authorizeUrl->searchParams->set_("state", stateId());