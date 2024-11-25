module Bellroy exposing (Dimensions, Direction(..), Movement(..), Turn(..), backward, forward, isBlocked, turn)


type alias Dimensions =
    { width : Int
    , height : Int
    }


type Direction
    = North
    | East
    | South
    | West


type Movement
    = Forward
    | Backward


type Turn
    = Left
    | Right


isEdge : Direction -> Dimensions -> ( Int, Int ) -> Bool
isEdge direction { width, height } ( x, y ) =
    case direction of
        North ->
            y == 0

        East ->
            x == width - 1

        South ->
            y == height - 1

        West ->
            x == 0


isBlocked : Dimensions -> ( Int, Int ) -> Direction -> Movement -> Bool
isBlocked dimensions position direction movement =
    case ( direction, movement ) of
        ( North, Forward ) ->
            isEdge North dimensions position

        ( East, Forward ) ->
            isEdge East dimensions position

        ( South, Forward ) ->
            isEdge South dimensions position

        ( West, Forward ) ->
            isEdge West dimensions position

        ( North, Backward ) ->
            isEdge South dimensions position

        ( East, Backward ) ->
            isEdge West dimensions position

        ( South, Backward ) ->
            isEdge North dimensions position

        ( West, Backward ) ->
            isEdge East dimensions position


forward : ( Int, Int ) -> Direction -> ( Int, Int )
forward position direction =
    case direction of
        North ->
            ( Tuple.first position, Tuple.second position - 1 )

        East ->
            ( Tuple.first position + 1, Tuple.second position )

        South ->
            ( Tuple.first position, Tuple.second position + 1 )

        West ->
            ( Tuple.first position - 1, Tuple.second position )


backward : ( Int, Int ) -> Direction -> ( Int, Int )
backward ( x, y ) direction =
    case direction of
        North ->
            ( x, y + 1 )

        East ->
            ( x - 1, y )

        South ->
            ( x, y - 1 )

        West ->
            ( x + 1, y )


turn : Turn -> Direction -> Direction
turn t direction =
    case ( direction, t ) of
        ( North, Left ) ->
            West

        ( East, Left ) ->
            North

        ( South, Left ) ->
            East

        ( West, Left ) ->
            South

        ( North, Right ) ->
            East

        ( East, Right ) ->
            South

        ( South, Right ) ->
            West

        ( West, Right ) ->
            North
