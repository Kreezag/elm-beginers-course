module Main exposing (main)

import Bool.Extra exposing (..)
import Html exposing (..)


add a b =
    a ++ b


addNum a b =
    a + b


testResult =
    addNum 2 2 |> (\a -> remainderBy 2 a == 0)


result =
    add "Hello " "world!"


counter =
    0


increment cmt amt =
    cmt + amt


main : Html msg
main =
    text (Bool.Extra.toString testResult)
