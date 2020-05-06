port module Chat exposing (..)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Http
import Json.Decode exposing (Decoder, field, string, int, list, map2, at)
import Time

main =
  Browser.element
    { init = init
    , update = update
    , subscriptions = subscriptions
    , view = view
    }

type alias Post =
  { posted_at : Int
  , item : String
  }

type alias Posts =
  List Post

type alias Model =
  { field : String
  , posts : List Post
  }

init : () -> (Model, Cmd Msg)
init _ =
  ( Model "" []
  , Http.get
      { url = "http://localhost:4000/api/posts"
      , expect = Http.expectJson Fetch decodePosts
      }
  )

decodePosts =
  (field "data" (Json.Decode.list (map2 Post (field "posted_at" int) (field "item" string))))

port postItem : String -> Cmd msg
port received : (Post -> msg) -> Sub msg

type Msg
  = Submit
  | Input String
  | Receive Post
  | Fetch (Result Http.Error Posts)

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Submit ->
      case model.field of
        "" ->
          ( model
          , Cmd.none
          )

        _ ->
          ( { model | field = "" }
          , postItem model.field
          )

    Input s ->
      ( { model | field = s }
      , Cmd.none
      )

    Receive p ->
      ( { model | posts = p :: model.posts }
      , Cmd.none
      )

    Fetch result ->
      case result of
        Ok posts ->
          ( { model | posts = posts }
          , Cmd.none
          )

        Err _ ->
          ( model
          , Cmd.none
          )

subscriptions : Model -> Sub Msg
subscriptions model =
  received (\post -> Receive post)

view : Model -> Html Msg
view model =
  div []
    [ Html.form
        [ onSubmit Submit
        ]
        [ input
            [ type_ "text"
            , value model.field
            , onInput Input
            ] []
        ]
    , ul [] (List.map postToText model.posts)
    ]

postToText post =
  li
    [
    ]
    [ span
        [ class "float-right"
        ]
        [ text (formatMillis post.posted_at)
        ]
    , text post.item
    ]

formatMillis : Int -> String
formatMillis m =
  let
    zone = Time.customZone (9 * 60) []
    posix = Time.millisToPosix m
    mon =
      case Time.toMonth zone posix of
        Time.Jan -> "01"
        Time.Feb -> "02"
        Time.Mar -> "03"
        Time.Apr -> "04"
        Time.May -> "05"
        Time.Jun -> "06"
        Time.Jul -> "07"
        Time.Aug -> "08"
        Time.Sep -> "09"
        Time.Oct -> "10"
        Time.Nov -> "11"
        Time.Dec -> "12"
    pad = \f -> f zone posix |> String.fromInt |> String.padLeft 2 '0'
    y = pad Time.toYear
    d = pad Time.toDay
    h = pad Time.toHour
    min = pad Time.toMinute
    s = pad Time.toSecond
  in
    "[ " ++ y ++ "/" ++ mon ++ "/" ++ d ++ " " ++ h ++ ":" ++ min ++ ":" ++ s ++ " ]"
