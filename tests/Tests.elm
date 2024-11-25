module Tests exposing (suite)

import Bellroy exposing (..)
import Expect
import Test exposing (Test, describe, test)


suite : Test
suite =
    describe "Bellroy"
        [ describe "isBlocked"
            (let
                isBlocked =
                    Bellroy.isBlocked { width = 5, height = 5 }
             in
             [ test "forward, north edge" (\_ -> Expect.equal (isBlocked ( 4, 0 ) North Forward) True)
             , test "forward, east edge" (\_ -> Expect.equal (isBlocked ( 4, 0 ) East Forward) True)
             , test "forward, south edge" (\_ -> Expect.equal (isBlocked ( 0, 4 ) South Forward) True)
             , test "forward, west edge" (\_ -> Expect.equal (isBlocked ( 0, 0 ) West Forward) True)
             , test "backward, north edge" (\_ -> Expect.equal (isBlocked ( 0, 0 ) South Backward) True)
             , test "backward, east edge" (\_ -> Expect.equal (isBlocked ( 4, 0 ) West Backward) True)
             , test "backward, south edge" (\_ -> Expect.equal (isBlocked ( 0, 4 ) North Backward) True)
             , test "backward, west edge" (\_ -> Expect.equal (isBlocked ( 0, 0 ) East Backward) True)
             ]
            )
        , describe "turn"
            [ test "left, north" (\_ -> Expect.equal (turn Left North) West)
            , test "right, north" (\_ -> Expect.equal (turn Right North) East)
            ]
        ]
