type responseError = {
  message: string
}

type error =
  | Empty
  | NetworkError
  | Timeout
  | ResponseError(responseError)

let mapError = error => {
  switch error {
  | #NetworkRequestFailed => NetworkError
  | #Timeout => Timeout
  }
}

let emptyToError = ({Request.response: response}) => {
  switch response {
  | None => Error(Empty)
  | Some(value) => Ok(value)
  }
}