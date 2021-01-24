open Js.String2;

module DOM = Webapi.Dom;

let authorize = () => SpotifyEnv.authorizeUrl->Type.href->DOM.Location.replace(DOM.location)

let getTokenFromCallback = () => {
    let parameter = DOM.location
        ->DOM.Location.hash
        ->sliceToEnd(~from=1)
        ->split("&")
        ->Array.map((s) => s->split("="))
        ->Array.keep(a => a->Array.length == 2)
        ->Array.map((p) => (p->Array.getUnsafe(0), p->Array.getUnsafe(1)))
        ->HashMap.String.fromArray
    
    switch parameter->HashMap.String.get("state") {
    | Some(s) => {
        if s == SpotifyEnv.stateId() {
            switch parameter->HashMap.String.get("access_token") {
            | Some(t) => Some(t)
            | None => None
            }
        } else {
            None
        }
    }
    | None => None
    }
}