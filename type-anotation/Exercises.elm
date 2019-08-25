module Main exposing (main)

import Bool.Extra exposing (..)
import Html exposing (..)


type alias Card =
    { name : String, qty : Int, freeQty : Int }


card : List Card
card =
    [ { name = "Lemon", qty = 1, freeQty = 0 }
    , { name = "Apple", qty = 5, freeQty = 0 }
    , { name = "Pear", qty = 10, freeQty = 0 }
    ]


makeFreeQty : Int -> Int -> Card -> Card
makeFreeQty sampleQty sampleFreeQty item =
    if item.qty >= sampleQty then
        { item
            | freeQty = sampleFreeQty
        }

    else
        item


newCard : List Card
newCard =
    List.map (makeFreeQty 5 1 >> makeFreeQty 10 3) card


main : Html msg
main =
    Html.div []
        [ Html.div []
            [ text (Debug.toString newCard)
            ]
        , Html.div []
            [ text (Debug.toString card)
            ]
        ]
