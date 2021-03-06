open Js.String2
open Webapi.Dom

let authorize = () => SpotifyEnv.authorizeUrl->Location.replace(location)

let getTokenFromCallback = () => {
  let parameter =
    location
    ->Location.hash
    ->sliceToEnd(~from=1)
    ->split("&")
    ->Array.map(s => s->split("="))
    ->Array.keep(a => a->Array.length == 2)
    ->Array.map(p => (p->Array.getUnsafe(0), p->Array.getUnsafe(1)->make))
    ->HashMap.String.fromArray

  switch parameter->HashMap.String.get("state") {
  | Some(s) =>
    if s == SpotifyEnv.stateId() {
      UrlType.removeUrlAnchor();
      switch parameter->HashMap.String.get("access_token") {
      | Some(t) => Some(t)
      | None => None
      }
    } else {
      None
    }
  | None => None
  }
}
