## Model

TODO: Model's Shape

```
    Model = 
    { playesrs : List Player
    , playerName : String
    , playerId : Maybe Int
    , plays : List Play
    }
```

TODO: Player Shape


```
    Player = 
        { name : String
        , id : Int
        , points : Int
        }   
```

TODO: Play Shape


```
    Play = 
        { playerId : Int
        , id : Int
        }
```


TODO: Initial Model

## Update 


* Edit
* Score
* Input
* Save
* Cancel
* DeletePlay

TODO: Create Message Union Type

## View

* main view
    * player section
        * player list header
        * player list 
            * player
        * point global
    * play section
        * play list header
        * playe list
            * play

TODO: Create function for each of the above