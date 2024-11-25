module Main exposing (main)

import Bellroy
import Browser
import Browser.Events
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Json.Decode
import Svg
import Svg.Attributes


type alias Model =
    { dimensions : Bellroy.Dimensions
    , position : ( Int, Int )
    , direction : Bellroy.Direction
    }


main : Program String Model Msg
main =
    let
        dimensions =
            { width = 5, height = 5 }
    in
    Browser.document
        { init = \_ -> ( { dimensions = dimensions, position = center dimensions, direction = Bellroy.North }, Cmd.none )
        , update = update
        , view = view
        , subscriptions = \_ -> Browser.Events.onKeyDown (Json.Decode.map KeyPressed (Json.Decode.field "key" Json.Decode.string))
        }


center : Bellroy.Dimensions -> ( Int, Int )
center { width, height } =
    ( width // 2, height // 2 )


type Msg
    = KeyPressed String
    | DimensionsChanged Int


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        KeyPressed key ->
            case key of
                "j" ->
                    if Bellroy.isBlocked model.dimensions model.position model.direction Bellroy.Forward then
                        ( model, Cmd.none )

                    else
                        ( { model | position = Bellroy.forward model.position model.direction }, Cmd.none )

                "k" ->
                    if Bellroy.isBlocked model.dimensions model.position model.direction Bellroy.Backward then
                        ( model, Cmd.none )

                    else
                        ( { model | position = Bellroy.backward model.position model.direction }, Cmd.none )

                "h" ->
                    ( { model | direction = Bellroy.turn Bellroy.Left model.direction }, Cmd.none )

                "l" ->
                    ( { model | direction = Bellroy.turn Bellroy.Right model.direction }, Cmd.none )

                _ ->
                    ( model, Cmd.none )

        DimensionsChanged i ->
            let
                dimensions =
                    (\d -> { d | width = d.width + i, height = d.height + i }) model.dimensions
            in
            ( { model | dimensions = dimensions, position = center dimensions }, Cmd.none )


view : Model -> Browser.Document Msg
view model =
    { title = "Bellroy"
    , body =
        [ div [ class "h-full mx-auto max-w-8xl lg:flex lg:justify-between xl:justify-end lg:overflow-hidden" ]
            [ div [ class "lg:flex lg:w-1/2 lg:shrink lg:grow-0 xl:absolute xl:inset-y-0 xl:right-1/2 xl:w-1/2" ] [ div [ class "relative h-80 lg:-ml-8 lg:h-auto lg:w-full lg:grow xl:ml-0" ] [ img [ class "absolute inset-0 size-full bg-gray-50 object-cover", src "splash.jpg" ] [] ] ]
            , div [ class "w-full lg:w-1/2 p-8 bg-gray-50 overflow-y-scroll" ]
                [ div [ class "h-full flex flex-col items-center" ]
                    [ div [ class "flex items-center space-x-5" ]
                        [ div [ class "w-20" ] [ Svg.svg [ Svg.Attributes.viewBox "0 0 99 58" ] [ Svg.path [ Svg.Attributes.d "M11.9 49.6c-2.1 0-4.2-.7-5.8-2.2A8.2 8.2 0 0 1 3 41.6c0-.2 0-.4-.1-.6V24.7s4.1 0 4.1 3.7v4.7l.6-.3c.1 0 .1-.1.1-.1.1 0 .2-.1.2-.1a8.2 8.2 0 0 1 4.2-1.1h.4c1.9.1 3.5.6 5 1.7 2.1 1.6 3.3 3.6 3.7 6 .3 2.1 0 4.1-1 5.8-1.5 2.5-3.5 4-6.2 4.5-.8 0-1.5.1-2.1.1zm.2-14.3c-.3 0-.6 0-.9.1-2.6.3-4.2 2.4-4.2 5v.4c0 1.5.6 2.7 1.7 3.6.9.8 2.2 1.3 3.4 1.3.9 0 1.9-.3 2.7-.7 1.9-1.1 2.7-2.9 2.4-5.2-.3-2.2-2.1-4.5-5.1-4.5zM69.1 49.6c-2.4 0-4.7-.9-6.5-2.7a8.78 8.78 0 0 1-2.7-6c-.1-2.5.7-4.9 2.5-6.7 1.8-1.8 4.1-2.9 6.7-2.9 5 0 9.2 4.1 9.2 9.1 0 2.4-.9 4.6-2.6 6.4a9.13 9.13 0 0 1-6.1 2.8h-.5zm.1-14.3c-.3 0-.6 0-1 .1a5.1 5.1 0 0 0-4.3 5.2v.4c.1 2.8 2.3 4.9 5.1 4.9.9 0 1.9-.3 2.7-.7 1.9-1.1 2.6-2.9 2.3-5.2-.1-2.5-2-4.7-4.8-4.7zM40.2 24.7v24.6h4.3V28.4c-.1-3.6-4.3-3.7-4.3-3.7zM46.4 24.7v24.6h4.3V28.4c0-3.9-4.3-3.7-4.3-3.7z" ] [], Svg.path [ Svg.Attributes.d "M52.6 49.3v-2.7-6.4c0-1.4.1-2.9.7-4.4.9-2.1 2.5-3.3 4.7-4 1.8-.5 3.4-.4 3.4-.4v3.9s-1 0-2 .3c-1.4.4-2.3 1.3-2.5 2.8-.1.6-.2 1.4-.2 2.2v8.7h-4.1zM79.9 51.7c1.8 0 2.3.9 2.7 1.3.6.5 1.4.8 2.1.8 2.3 0 4.1-2.1 4.1-4.1v-.9c-1 .6-2.1.8-3.2.8-4.1 0-7.3-3.4-7.3-7.6V31.6h4.1v10.2c0 1.9 1.5 3.6 3.2 3.6 1.9 0 3.2-1.6 3.2-3.6v-6.5c0-3.7 4.1-3.7 4.1-3.7v18c0 4.2-3.1 8.1-8.2 8.1-3.1 0-5.9-1.8-7.1-4.7-.4-.8-.5-1.4-.5-1.4s1.3.1 2.8.1zM30.3 45.9c-1.7 0-3.1-.8-4-2l13-4.6c-.6-3-1.8-4.9-3.6-6.2a9.3 9.3 0 0 0-7-1.5c-.6.1-1 .2-1.6.4a8.96 8.96 0 0 0-5.8 9.3 9 9 0 0 0 3.2 6.2c1.8 1.5 4 2.2 6.3 2.2 1 0 1.9-.2 2.9-.6 3.7-1.3 5.4-4.1 5.8-6.7h-2.4c-1.5 0-2.1 1-2.5 1.4a5.94 5.94 0 0 1-4.3 2.1zm-1.7-10.3c.1 0 .1 0 .2-.1H29.1c.4-.1.8-.2 1.3-.2.9 0 1.8.3 2.6.7.4.2.7.5 1 .8V37.1l.4.4-9.2 3.2v-.5c.1-2.2 1.4-3.9 3.4-4.6zM75.6 5.5c-.7 0-1.3.6-1.3 1.3 0 .7.7 1.4 1.5 1.2.3 1.1.9 2.1 1.8 2.8l.4.2.4-.3c.7-.6 1.4-1.7 1.7-2.8h.3c.7 0 1.3-.6 1.3-1.3s-.7-1.2-1.4-1.2c-.8 0-1.3.6-1.3 1.3 0 .9-.5 2.1-1.1 2.9-.6-.7-1-1.8-1.1-2.9.1-.6-.5-1.2-1.2-1.2zm16.5 11.6c-2.5-6.2-6.1-8-7.6-8.6.1-.4.1-.7.1-1.2 0-3.6-3-6.5-6.6-6.5-3.5 0-6.3 2.8-6.8 6.4-.7 8.7 5 13.5 7.8 15.7 1.6 1.2 2.4 2.1 1.5 3.6-.6.8-1.2 2-1.8 2.2-1.6.3-2.1 1.3-2.1 1.3H78c1.8 0 2.3-.1 4.1-3 1.7-2.9-1-4.5-2.1-5.4-2.8-2.1-8-6.4-7.3-14.2v-.1c.3-3 2.5-5.2 5.4-5.2a5.16 5.16 0 0 1 3.7 8.8c-.9 1-2.2 1.5-3.6 1.5-.5 0-.9-.1-1.3-.2-1.4-.4-2 .6-2 .6l-.1.1.1.1c.9.6 2.2.9 3.3.9 1.8 0 3.4-.6 4.6-1.9.6-.6 1.1-1.3 1.4-2 1.2.5 4.4 2.1 6.7 7.7.6 1.4 1.1 2.8 1.6 4-1.8 0-8.1-.2-11.2-5.1-.8-1.3-2.1-1-2.1-1 3.2 7.7 12.3 7.5 14 7.6.8 2 1.5 3.6 1.8 4.5-.7 0-2.1-.3-3.7-1.7a7.11 7.11 0 0 0-5.1-1.9l-4 6.3s1.9 0 2.7-1.2l2.2-3.5c1.1.1 2.2.6 3.3 1.5 2.1 1.7 3.4 1.9 4.7 1.9 1.2.1 1.9-.3 1.9-.3s-2.4-5.6-4.9-11.7z" ] [] ] ]
                        , div [ style "color" "#e15a1d" ] [ Svg.svg [ Svg.Attributes.fill "none", Svg.Attributes.viewBox "0 0 24 24", Svg.Attributes.strokeWidth "3", Svg.Attributes.stroke "currentColor", Svg.Attributes.class "size-6" ] [ Svg.path [ Svg.Attributes.strokeLinecap "round", Svg.Attributes.strokeLinejoin "round", Svg.Attributes.d "M6 18 18 6M6 6l12 12" ] [] ] ]
                        , div [ class "w-20 overflow-hidden" ] [ Svg.svg [ Svg.Attributes.class "w-12 rounded-md", Svg.Attributes.version "1.1", Svg.Attributes.id "Layer_1", Svg.Attributes.x "0px", Svg.Attributes.y "0px", Svg.Attributes.viewBox "0 0 323.141 322.95", Svg.Attributes.enableBackground "new 0 0 323.141 322.95", Svg.Attributes.xmlSpace "preserve" ] [ Svg.g [] [ Svg.polygon [ Svg.Attributes.fill "#F0AD00", Svg.Attributes.points "161.649,152.782 231.514,82.916 91.783,82.916" ] [], Svg.polygon [ Svg.Attributes.fill "#7FD13B", Svg.Attributes.points "8.867,0 79.241,70.375 232.213,70.375 161.838,0" ] [], Svg.rect [ Svg.Attributes.fill "#7FD13B", Svg.Attributes.x "192.99", Svg.Attributes.y "107.392", Svg.Attributes.transform "matrix(0.7071 0.7071 -0.7071 0.7071 186.4727 -127.2386)", Svg.Attributes.width "107.676", Svg.Attributes.height "108.167" ] [], Svg.polygon [ Svg.Attributes.fill "#60B5CC", Svg.Attributes.points "323.298,143.724 323.298,0 179.573,0" ] [], Svg.polygon [ Svg.Attributes.fill "#5A6378", Svg.Attributes.points "152.781,161.649 0,8.868 0,314.432" ] [], Svg.polygon [ Svg.Attributes.fill "#F0AD00", Svg.Attributes.points "255.522,246.655 323.298,314.432 323.298,178.879" ] [], Svg.polygon [ Svg.Attributes.fill "#60B5CC", Svg.Attributes.points "161.649,170.517 8.869,323.298 314.43,323.298" ] [] ] ] ]
                        ]
                    , h1 [ class "mt-10 text-center text-pretty text-3xl font-semibold tracking-tight text-indigo-600", style "color" "#e15a1d" ] [ text "Fun in Function", span [ class "opacity-50" ] [ text "al Programming" ] ]
                    , figure [ class "rounded-2xl bg-white p-6 shadow-lg ring-1 ring-gray-900/5 max-w-md mt-10" ]
                        [ blockquote [ class "text-gray-900" ] [ p [] [ text "\"I love Elm. It really is a beautiful programming language in its simplicity and elegance. Even after 5 years of building web applications in Elm, I still find it a breath of fresh air.\"" ] ]
                        , figcaption [ class "mt-6 flex items-center gap-x-4" ]
                            [ img [ class "size-10 border-2 border-gray-400 rounded-full bg-gray-50", src "luis.jpg" ] []
                            , div []
                                [ div [ class "font-semibold" ] [ text "Luis Vega" ]
                                , div [ class "text-gray-600" ] [ text "@luiscvega" ]
                                ]
                            ]
                        ]
                    , div [ class "mt-10 w-full max-w-md text-base/7 text-gray-700 font-mono" ]
                        (List.map
                            (\y ->
                                div [ class "flex justify-center" ]
                                    (List.map
                                        (\x ->
                                            div [ class "aspect-square w-full m-0.5 rounded-md flex items-center justify-center text-3xl", style "background-color" "rgba(225, 90, 29, 0.3)" ]
                                                [ if model.position == ( x, y ) then
                                                    div
                                                        [ class
                                                            (case model.direction of
                                                                Bellroy.North ->
                                                                    "rotate-0"

                                                                Bellroy.East ->
                                                                    "rotate-90"

                                                                Bellroy.South ->
                                                                    "rotate-180"

                                                                Bellroy.West ->
                                                                    "-rotate-90"
                                                            )
                                                        ]
                                                        [ img [ src "bellroy.png" ] [] ]

                                                  else
                                                    text ""
                                                ]
                                        )
                                        (List.range 0 (model.dimensions.width - 1))
                                    )
                            )
                            (List.range 0 (model.dimensions.height - 1))
                        )
                    , div [ class "mt-6 space-x-3" ]
                        [ if model.dimensions == { width = 2, height = 2 } then
                            div [ class "inline-block rounded-md bg-white px-2.5 py-1.5 text-sm font-semibold text-gray-400 shadow-sm ring-1 ring-inset ring-gray-300 bg-gray-200" ] [ text "Size ", Svg.svg [ Svg.Attributes.viewBox "0 0 16 16", Svg.Attributes.fill "currentColor", Svg.Attributes.class "size-4 inline" ] [ Svg.path [ Svg.Attributes.fillRule "evenodd", Svg.Attributes.d "M8 15A7 7 0 1 0 8 1a7 7 0 0 0 0 14Zm4-7a.75.75 0 0 0-.75-.75h-6.5a.75.75 0 0 0 0 1.5h6.5A.75.75 0 0 0 12 8Z", Svg.Attributes.clipRule "evenodd" ] [] ] ]

                          else
                            button [ onClick (DimensionsChanged -1), class "rounded-md bg-white px-2.5 py-1.5 text-sm font-semibold text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 hover:bg-gray-50" ] [ text "Size ", Svg.svg [ Svg.Attributes.viewBox "0 0 16 16", Svg.Attributes.fill "currentColor", Svg.Attributes.class "size-4 inline" ] [ Svg.path [ Svg.Attributes.fillRule "evenodd", Svg.Attributes.d "M8 15A7 7 0 1 0 8 1a7 7 0 0 0 0 14Zm4-7a.75.75 0 0 0-.75-.75h-6.5a.75.75 0 0 0 0 1.5h6.5A.75.75 0 0 0 12 8Z", Svg.Attributes.clipRule "evenodd" ] [] ] ]
                        , button [ onClick (DimensionsChanged 1), class "rounded-md bg-white px-2.5 py-1.5 text-sm font-semibold text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 hover:bg-gray-50" ] [ text "Size ", Svg.svg [ Svg.Attributes.viewBox "0 0 16 16", Svg.Attributes.fill "currentColor", Svg.Attributes.class "size-4 inline" ] [ Svg.path [ Svg.Attributes.fillRule "evenodd", Svg.Attributes.d "M8 15A7 7 0 1 0 8 1a7 7 0 0 0 0 14Zm.75-10.25v2.5h2.5a.75.75 0 0 1 0 1.5h-2.5v2.5a.75.75 0 0 1-1.5 0v-2.5h-2.5a.75.75 0 0 1 0-1.5h2.5v-2.5a.75.75 0 0 1 1.5 0Z", Svg.Attributes.clipRule "evenodd" ] [] ] ]
                        ]
                    , div [ class "mt-6 space-x-3" ]
                        [ button [ onClick (KeyPressed "h"), class "rounded-md bg-white px-3.5 py-2.5 text-xl font-semibold text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 hover:bg-gray-50" ] [ text "H" ]
                        , button [ onClick (KeyPressed "j"), class "rounded-md bg-white px-3.5 py-2.5 text-xl font-semibold text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 hover:bg-gray-50" ] [ text "J" ]
                        , button [ onClick (KeyPressed "k"), class "rounded-md bg-white px-3.5 py-2.5 text-xl font-semibold text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 hover:bg-gray-50" ] [ text "K" ]
                        , button [ onClick (KeyPressed "l"), class "rounded-md bg-white px-3.5 py-2.5 text-xl font-semibold text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 hover:bg-gray-50" ] [ text "L" ]
                        ]
                    , div [ class "mt-6 text-md text-gray-700 text-center space-y-3" ]
                        [ p [] [ text "Press 🄹 to move forward." ]
                        , p [] [ text "Press 🄺 to move backward." ]
                        , p [] [ text "Press 🄷  to turn left." ]
                        , p [] [ text "Press 🄻  to turn right. " ]
                        ]
                    ]
                ]
            ]
        ]
    }
