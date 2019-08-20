module Main exposing (main)

import Html exposing (..)


add a b =
    a ++ b


addNum a b =
    a + b


testResult =
    addNum 1 2 |> addNum 3


result =
    add "Hello " "world!"


main : Html msg
main =
    text (String.fromInt testResult)
