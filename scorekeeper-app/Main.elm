module Main exposing (..)

import Browser exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


type alias Model =
    { players : List Player
    , name : String
    , playerId : Maybe Int
    , plays : List Play
    }


type alias Player =
    { name : String
    , id : Int
    , points : Int
    }


type alias Play =
    { playerId : Int
    , id : Int
    , name : String
    , points : Int
    }


initModel : Model
initModel =
    { players = []
    , name = ""
    , playerId = Nothing
    , plays = []
    }



-- update


type Msg
    = Edit Player
    | Score Player Int
    | Input String
    | Save
    | Cancel
    | DeletePlay Play


update : Msg -> Model -> Model
update msg model =
    case msg of
        Input name ->
            { model | name = name }

        Save ->
            { model | name = "save" }

        _ ->
            { model | name = "" }


view : Model -> Html Msg
view model =
    div [ class "scoreboard" ]
        [ h1 [] [ text "Score keeper" ]
        , playerForm model
        , span [] [ text (Debug.toString model) ]
        ]


playerForm : Model -> Html Msg
playerForm model =
    Html.form [ onSubmit Save ]
        [ input
            [ type_ "text"
            , placeholder "add"
            , onInput Input
            , value model.name
            ]
            []
        , button [ type_ "submit", onClick Save ] [ text "Save" ]
        , button [ type_ "button", onClick Cancel ] [ text "Cancel" ]
        ]


main : Program () Model Msg
main =
    Browser.sandbox
        { init = initModel
        , update = update
        , view = view
        }
