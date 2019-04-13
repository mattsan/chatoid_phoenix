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

type alias Model =
  { field : String
  , items : List String
  }

init : () -> (Model, Cmd Msg)
init _ =
  ( Model "" ["Hello Chatoid!"]
  , Cmd.none
  )

type Msg
  = Submit
  | Input String

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Submit ->
      ( { model | field = "", items = model.field :: model.items }
      , Cmd.none
      )

    Input s ->
      ( { model | field = s }
      , Cmd.none
      )

subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none

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
    , ul [] (List.map (\item -> li [] [ text item ]) model.items)
    ]
