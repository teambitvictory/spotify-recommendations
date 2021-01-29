let mapGenresKeyToGenresItem = (gKey: string) => {
    SearchItem.Genre({
        id: gKey,
        name: gKey
    })
}

let mapResponseToItem = (response) => {
  let status = response.Request.status
  if status !== 200 {
    Error(RequestMapper.ResponseError({message: "Failed request with $status"}))
  } else {
    let response = response.Request.response
    switch response {
    | None => Error(RequestMapper.Empty)
    | Some(value) => {
        let genres = value.GenresResponse.genres->Array.map(mapGenresKeyToGenresItem)
        Ok(genres)
      }
    }
  }
}