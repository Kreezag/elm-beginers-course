module Main exposing (main)

import Bool.Extra exposing (..)
import Html exposing (..)


calcNameLength text =
    String.length (String.trim text)


textMoreThanTenLength text =
    calcNameLength text > 10


updateName text =
    ifElse (String.toUpper text) text (textMoreThanTenLength text)


result text =
    updateName text ++ " - name length: " ++ String.fromInt (calcNameLength text)


main : Html msg
main =
    text (result "John doeeeeee")
