type image = {
    url: string
}

type response = {
    id: string,
    display_name: string,
    images: array<image>
}

let mapToUser = (responseUser: response) => {
    let user: User.user = {
        id: responseUser.id,
        name: responseUser.display_name,
        image: switch Array.get(responseUser.images, 0) {
            | None => ""
            | Some(value) => value.url
        }
    }
    user
}

let mapResponseToItem = (response) => {
  let status = response.Request.status
  if status !== 200 {
    Error(RequestMapper.ResponseError({message: "Failed request with $status"}))
  } else {
    let response = response.Request.response
    switch response {
    | None => Error(RequestMapper.Empty)
    | Some(value) => Ok(value->mapToUser)
    }
  }
}

let init = (token: string) => {

    let authHeader = Js.Dict.fromArray([("Authorization", "Bearer "++token)])

    () => {
        Request.make(~url=SpotifyEnv.userUrl, ~responseType=JsonAsAny: Request.responseType<response>, ~headers=authHeader, ())   
            -> Future.mapError(~propagateCancel=true, RequestMapper.mapError)
            -> Future.mapResult(~propagateCancel=true, mapResponseToItem)
    }

}