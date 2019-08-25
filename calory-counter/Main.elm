module Main exposing (..)

import Browser exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


type alias Model =
    { calories : Int
    , input : Int
    , error : Maybe String
    }


initialModel : Model
initialModel =
    Model 0 0 Nothing


type Msg
    = AddCalorie
    | Input String
    | Clear


update : Msg -> Model -> Model
update msg model =
    case msg of
        AddCalorie ->
            { model
                | calories = model.calories + model.input
                , input = 0
            }

        Input value ->
            case String.toInt value of
                Ok Result ->
                    { model | input = Result, error = Nothing }

                Err err ->
                    { model | input = 0, error = Just err }

        Clear ->
            initialModel



-- viewForm : Form


view : Model -> Html Msg
view model =
    div []
        [ h3 []
            [ text ("Total Calories: " ++ Debug.toString model.calories) ]
        , span [] [ text (Debug.toString model) ]
        , div []
            [ input
                [ type_ "text"
                , onInput Input
                , value
                    (if model.input == 0 then
                        ""

                     else
                        String.fromInt model.input
                    )
                ]
                []

            -- , button
            --     [ type_ "submit"
            --     , onClick AddCalorie
            --     ]
            --     [ text "Add" ]
            -- , button
            --     [ type_ "button"
            --     , onClick Clear
            --     ]
            --     [ text "Clear" ]
            ]
        ]


main : Program () Model Msg
main =
    Browser.sandbox
        { init = initialModel
        , update = update
        , view = view
        }
