port module Main exposing (..)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)

main =
  Browser.element
    { init = init
    , update = update
    , subscriptions = subscriptions
    , view = view
    }

type alias Post =
  { posted_at : String
  , item : String
  }

type alias Model =
  { field : String
  , posts : List Post
  }

init : () -> (Model, Cmd Msg)
init _ =
  ( Model "" [Post "" "Hello Chatoid!"]
  , Cmd.none
  )

port postItem : String -> Cmd msg
port received : (Post -> msg) -> Sub msg

type Msg
  = Submit
  | Input String
  | Receive Post

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
        [ text post.posted_at
        ]
    , text post.item
    ]
