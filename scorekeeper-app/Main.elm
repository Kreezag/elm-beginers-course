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
    { id : Int
    , name : String
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
            if String.isEmpty model.name then
                model

            else
                save model

        Cancel ->
            { model | name = "", playerId = Nothing }

        _ ->
            model


save : Model -> Model
save model =
    case model.playerId of
        Just id ->
            edit model id

        Nothing ->
            add model


edit : Model -> Int -> Model
edit model id =
    let
        -- player = Player ()
        newPlayers =
            List.map
                (\player ->
                    if player.id == id then
                        { player | name = model.name }

                    else
                        player
                )
                model.players

        newPlays =
            List.map
                (\play ->
                    if play.playerId == id then
                        { play | name = model.name }

                    else
                        play
                )
                model.plays
    in
    { model
        | players = newPlayers
        , plays = newPlays
        , name = ""
        , playerId = Nothing
    }


add : Model -> Model
add model =
    let
        player =
            Player (List.length model.players) model.name 0

        newPlayers =
            player :: model.players
    in
    { model | players = newPlayers, name = "" }



--     input
--     [ type_ "text"
--     , placeholder "add"
--     , onInput Input
--     , value model.name
--     ]
--     []
-- , button [ type_ "submit" ] [ text "Save" ]
-- , button [ type_ "button", onClick Cancel ] [ text "Cancel" ]
-- ]


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
        , button [ type_ "submit" ] [ text "Save" ]
        , button [ type_ "button", onClick Cancel ] [ text "Cancel" ]
        ]


players : Model -> Html Msg
players model =
    div []
        [ h4 []
            [ span [] [ text "Name" ]
            , span [] [ text "Points" ]
            ]
        , ul []
            (List.map (\name -> li [] [ text name ]) (List.map .name model.players))
        ]


view : Model -> Html Msg
view model =
    div [ class "scoreboard" ]
        [ h1 [] [ text "Score keeper" ]
        , players model
        , playerForm model
        , span [] [ text (Debug.toString model) ]
        ]


main : Program () Model Msg
main =
    Browser.sandbox
        { init = initModel
        , update = update
        , view = view
        }
