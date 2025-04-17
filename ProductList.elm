port module ProductList exposing (main)

import Array
import Browser
import Browser.Events
import Dict
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Http
import Json.Decode
import Url.Builder


port filtersChanged : (String -> msg) -> Sub msg


type alias Product =
    { id : String
    , name : String
    , colors : List String
    , price : Int
    }


type alias Model =
    { products : List (List Product)
    , actives : Array.Array Int
    , filter : Bool
    }


init : String -> ( Model, Cmd Msg )
init category =
    ( { products = [], actives = Array.empty, filter = False }
    , Http.request
        { method = "GET"
        , url = Url.Builder.absolute [ category ++ ".json" ] []
        , body = Http.emptyBody
        , expect =
            Http.expectJson ProductsReceived
                (Json.Decode.list
                    (Json.Decode.map2 Tuple.pair
                        (Json.Decode.andThen
                            (\s ->
                                Json.Decode.succeed (Maybe.withDefault "" (List.head (String.split "-" s)))
                            )
                            (Json.Decode.at [ "id" ] Json.Decode.string)
                        )
                        (Json.Decode.map4 Product
                            (Json.Decode.at [ "id" ] Json.Decode.string)
                            (Json.Decode.at [ "attributes", "name" ] Json.Decode.string)
                            (Json.Decode.at [ "attributes", "dimensions", "color" ] (Json.Decode.list Json.Decode.string))
                            (Json.Decode.at [ "attributes", "price", "price_in_cents" ] Json.Decode.int)
                        )
                    )
                )
        , headers = []
        , timeout = Nothing
        , tracker = Nothing
        }
    )


type Msg
    = ProductsReceived (Result Http.Error (List ( String, Product )))
    | VariantClicked Int Int
    | FiltersChanged String


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ProductsReceived result ->
            case result of
                Ok products ->
                    let
                        x =
                            Dict.values
                                (List.foldl
                                    (\( key, value ) acc ->
                                        Dict.update key
                                            (\maybeList ->
                                                Just (value :: Maybe.withDefault [] maybeList)
                                            )
                                            acc
                                    )
                                    Dict.empty
                                    products
                                )
                    in
                    ( { model | products = x, actives = Array.repeat (List.length x) 0 }, Cmd.none )

                Err e ->
                    ( model, Cmd.none )

        VariantClicked i j ->
            ( { model | actives = Array.set i j model.actives }, Cmd.none )

        FiltersChanged s ->
            ( { model | filter = not model.filter }, Cmd.none )


view : Model -> Html.Html Msg
view model =
    div [ class "grid gap-1 grid-cols-1 sm:grid-cols-2 lg:grid-cols-6" ]
        (List.indexedMap
            (\i products ->
                let
                    filtered =
                        if model.filter then
                            List.filter (\p -> Maybe.withDefault "" (List.head p.colors) == "black") products

                        else
                            products

                    j =
                        Maybe.withDefault -1 (Array.get i model.actives)

                    maybeProduct =
                        Array.get j (Array.fromList filtered)
                in
                case maybeProduct of
                    Nothing ->
                        text ""

                    Just product ->
                        div [ class "group relative flex flex-col overflow-hidden", style "background-color" "#f7f7f7" ]
                            [ img [ src ("https://bellroy-product-images.imgix.net/bellroy_dot_com_range_page_image/USD/" ++ product.id ++ "/0"), class "aspect-3/4 w-full object-contain group-hover:opacity-75 sm:aspect-auto sm:h-48" ] []
                            , div [ class "flex flex-1 flex-col space-y-2 p-4" ]
                                [ h3 [ class "text-sm font-medium text-gray-900" ] [ text product.name ]
                                , p [ class "text-sm text-gray-500" ] [ text "Some description" ]
                                , div [ class "flex flex-1 flex-col justify-end" ]
                                    [ p [ class "text-sm text-gray-500 italic" ] [ text "some options" ]
                                    , p [ class "text-base font-medium text-gray-900" ] [ text (String.fromInt product.price) ]
                                    ]
                                , ul [ class "mt-auto grid grid-cols-6 gap-3" ]
                                    (List.indexedMap
                                        (\k v ->
                                            li [ onClick (VariantClicked i k), class "cursor-pointer size-4 rounded-full border border-black/10", style "background-color" (hex (Maybe.withDefault "" (List.head v.colors))) ] [ span [ class "sr-only" ] [ text "Black" ] ]
                                        )
                                        products
                                    )
                                ]
                            ]
            )
            model.products
        )


subscriptions : Model -> Sub Msg
subscriptions _ =
    filtersChanged FiltersChanged


main : Program String Model Msg
main =
    Browser.element
        { init = init
        , update = update
        , view = view
        , subscriptions = subscriptions
        }


hex : String -> String
hex color =
    Maybe.withDefault "#000000"
        (Dict.get color
            (Dict.fromList
                [ ( "everglade", "#1E4D2B" )
                , ( "ink", "#101820" )
                , ( "ocean", "#0077BE" )
                , ( "navy", "#000080" )
                , ( "deep_plum", "#673147" )
                , ( "charcoal", "#36454F" )
                , ( "mustard", "#FFDB58" )
                , ( "aragon", "#D40000" )
                , ( "cocoa-java", "#4F321A" )
                , ( "bronze", "#CD7F32" )
                , ( "black_ash", "#3E3B3A" )
                , ( "hazelnut", "#B8860B" )
                , ( "black", "#000000" )
                , ( "pepper_blue", "#4973AB" )
                , ( "caramel", "#AF6E4D" )
                , ( "cocoa", "#D2691E" )
                , ( "ranger_green", "#444C38" )
                , ( "darkwood", "#654321" )
                , ( "java", "#1FC2C2" )
                , ( "indigo", "#4B0082" )
                , ( "night_forest", "#003E29" )
                , ( "willow", "#8A9A5B" )
                , ( "neon_green", "#39FF14" )
                , ( "teal", "#008080" )
                , ( "bluestone", "#005F6B" )
                , ( "stellar_black", "#0C090A" )
                , ( "sienna", "#A0522D" )
                , ( "mirum_black", "#1C1C1C" )
                , ( "raven", "#696969" )
                , ( "terracotta", "#E2725B" )
                ]
            )
        )
