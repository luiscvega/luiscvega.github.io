port module CategoryFilters exposing (main)

import Array
import Browser
import Browser.Events
import Dict
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Json.Decode
import Svg
import Svg.Attributes


port filtersChanged : String -> Cmd msg


type alias Model =
    {}


init : String -> ( Model, Cmd Msg )
init flags =
    ( {}, Cmd.none )


type Msg
    = FilterClicked String String


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        FilterClicked filter option ->
            ( model, filtersChanged "cliaslkfdj" )


view : Model -> Html.Html Msg
view model =
    Html.form [ class "divide-y divide-gray-200" ]
        [ div
            [ class "py-10 first:pt-0 last:pb-0"
            ]
            [ fieldset []
                [ legend
                    [ class "block text-sm font-medium text-gray-900"
                    ]
                    [ text "Color" ]
                , div
                    [ class "space-y-3 pt-6"
                    ]
                    [ div
                        [ class "flex gap-3"
                        ]
                        [ div
                            [ class "flex h-5 shrink-0 items-center"
                            ]
                            [ div
                                [ class "group grid size-4 grid-cols-1"
                                ]
                                [ input
                                    [ id "color-0"
                                    , name "color[]"
                                    , value "white"
                                    , type_ "checkbox"
                                    , class "col-start-1 row-start-1 appearance-none rounded-sm border border-gray-300 bg-white checked:border-indigo-600 checked:bg-indigo-600 indeterminate:border-indigo-600 indeterminate:bg-indigo-600 focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-indigo-600 disabled:border-gray-300 disabled:bg-gray-100 disabled:checked:bg-gray-100 forced-colors:appearance-auto"
                                    , onClick (FilterClicked "color" "white")
                                    ]
                                    []
                                , Svg.svg
                                    [ Svg.Attributes.class "pointer-events-none col-start-1 row-start-1 size-3.5 self-center justify-self-center stroke-white group-has-disabled:stroke-gray-950/25"
                                    , Svg.Attributes.viewBox "0 0 14 14"
                                    , Svg.Attributes.fill "none"
                                    ]
                                    [ Svg.path
                                        [ Svg.Attributes.class "opacity-0 group-has-checked:opacity-100"
                                        , Svg.Attributes.d "M3 8L6 11L11 3.5"
                                        , Svg.Attributes.strokeWidth "2"
                                        , Svg.Attributes.strokeLinecap "round"
                                        , Svg.Attributes.strokeLinejoin "round"
                                        ]
                                        []
                                    , Svg.path
                                        [ Svg.Attributes.class "opacity-0 group-has-indeterminate:opacity-100"
                                        , Svg.Attributes.d "M3 7H11"
                                        , Svg.Attributes.strokeWidth "2"
                                        , Svg.Attributes.strokeLinecap "round"
                                        , Svg.Attributes.strokeLinejoin "round"
                                        ]
                                        []
                                    ]
                                ]
                            ]
                        , label
                            [ for "color-0"
                            , class "text-sm text-gray-600"
                            ]
                            [ text "White" ]
                        ]
                    , div
                        [ class "flex gap-3"
                        ]
                        [ div
                            [ class "flex h-5 shrink-0 items-center"
                            ]
                            [ div
                                [ class "group grid size-4 grid-cols-1"
                                ]
                                [ input
                                    [ id "color-1"
                                    , name "color[]"
                                    , value "beige"
                                    , type_ "checkbox"
                                    , class "col-start-1 row-start-1 appearance-none rounded-sm border border-gray-300 bg-white checked:border-indigo-600 checked:bg-indigo-600 indeterminate:border-indigo-600 indeterminate:bg-indigo-600 focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-indigo-600 disabled:border-gray-300 disabled:bg-gray-100 disabled:checked:bg-gray-100 forced-colors:appearance-auto"
                                    ]
                                    []
                                , Svg.svg
                                    [ Svg.Attributes.class "pointer-events-none col-start-1 row-start-1 size-3.5 self-center justify-self-center stroke-white group-has-disabled:stroke-gray-950/25"
                                    , Svg.Attributes.viewBox "0 0 14 14"
                                    , Svg.Attributes.fill "none"
                                    ]
                                    [ Svg.path
                                        [ Svg.Attributes.class "opacity-0 group-has-checked:opacity-100"
                                        , Svg.Attributes.d "M3 8L6 11L11 3.5"
                                        , Svg.Attributes.strokeWidth "2"
                                        , Svg.Attributes.strokeLinecap "round"
                                        , Svg.Attributes.strokeLinejoin "round"
                                        ]
                                        []
                                    , Svg.path
                                        [ Svg.Attributes.class "opacity-0 group-has-indeterminate:opacity-100"
                                        , Svg.Attributes.d "M3 7H11"
                                        , Svg.Attributes.strokeWidth "2"
                                        , Svg.Attributes.strokeLinecap "round"
                                        , Svg.Attributes.strokeLinejoin "round"
                                        ]
                                        []
                                    ]
                                ]
                            ]
                        , label
                            [ for "color-1"
                            , class "text-sm text-gray-600"
                            ]
                            [ text "Beige" ]
                        ]
                    , div
                        [ class "flex gap-3"
                        ]
                        [ div
                            [ class "flex h-5 shrink-0 items-center"
                            ]
                            [ div
                                [ class "group grid size-4 grid-cols-1"
                                ]
                                [ input
                                    [ id "color-2"
                                    , name "color[]"
                                    , value "blue"
                                    , type_ "checkbox"
                                    , class "col-start-1 row-start-1 appearance-none rounded-sm border border-gray-300 bg-white checked:border-indigo-600 checked:bg-indigo-600 indeterminate:border-indigo-600 indeterminate:bg-indigo-600 focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-indigo-600 disabled:border-gray-300 disabled:bg-gray-100 disabled:checked:bg-gray-100 forced-colors:appearance-auto"
                                    ]
                                    []
                                , Svg.svg
                                    [ Svg.Attributes.class "pointer-events-none col-start-1 row-start-1 size-3.5 self-center justify-self-center stroke-white group-has-disabled:stroke-gray-950/25"
                                    , Svg.Attributes.viewBox "0 0 14 14"
                                    , Svg.Attributes.fill "none"
                                    ]
                                    [ Svg.path
                                        [ Svg.Attributes.class "opacity-0 group-has-checked:opacity-100"
                                        , Svg.Attributes.d "M3 8L6 11L11 3.5"
                                        , Svg.Attributes.strokeWidth "2"
                                        , Svg.Attributes.strokeLinecap "round"
                                        , Svg.Attributes.strokeLinejoin "round"
                                        ]
                                        []
                                    , Svg.path
                                        [ Svg.Attributes.class "opacity-0 group-has-indeterminate:opacity-100"
                                        , Svg.Attributes.d "M3 7H11"
                                        , Svg.Attributes.strokeWidth "2"
                                        , Svg.Attributes.strokeLinecap "round"
                                        , Svg.Attributes.strokeLinejoin "round"
                                        ]
                                        []
                                    ]
                                ]
                            ]
                        , label
                            [ for "color-2"
                            , class "text-sm text-gray-600"
                            ]
                            [ text "Blue" ]
                        ]
                    , div
                        [ class "flex gap-3"
                        ]
                        [ div
                            [ class "flex h-5 shrink-0 items-center"
                            ]
                            [ div
                                [ class "group grid size-4 grid-cols-1"
                                ]
                                [ input
                                    [ id "color-3"
                                    , name "color[]"
                                    , value "brown"
                                    , type_ "checkbox"
                                    , class "col-start-1 row-start-1 appearance-none rounded-sm border border-gray-300 bg-white checked:border-indigo-600 checked:bg-indigo-600 indeterminate:border-indigo-600 indeterminate:bg-indigo-600 focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-indigo-600 disabled:border-gray-300 disabled:bg-gray-100 disabled:checked:bg-gray-100 forced-colors:appearance-auto"
                                    ]
                                    []
                                , Svg.svg
                                    [ Svg.Attributes.class "pointer-events-none col-start-1 row-start-1 size-3.5 self-center justify-self-center stroke-white group-has-disabled:stroke-gray-950/25"
                                    , Svg.Attributes.viewBox "0 0 14 14"
                                    , Svg.Attributes.fill "none"
                                    ]
                                    [ Svg.path
                                        [ Svg.Attributes.class "opacity-0 group-has-checked:opacity-100"
                                        , Svg.Attributes.d "M3 8L6 11L11 3.5"
                                        , Svg.Attributes.strokeWidth "2"
                                        , Svg.Attributes.strokeLinecap "round"
                                        , Svg.Attributes.strokeLinejoin "round"
                                        ]
                                        []
                                    , Svg.path
                                        [ Svg.Attributes.class "opacity-0 group-has-indeterminate:opacity-100"
                                        , Svg.Attributes.d "M3 7H11"
                                        , Svg.Attributes.strokeWidth "2"
                                        , Svg.Attributes.strokeLinecap "round"
                                        , Svg.Attributes.strokeLinejoin "round"
                                        ]
                                        []
                                    ]
                                ]
                            ]
                        , label
                            [ for "color-3"
                            , class "text-sm text-gray-600"
                            ]
                            [ text "Brown" ]
                        ]
                    , div
                        [ class "flex gap-3"
                        ]
                        [ div
                            [ class "flex h-5 shrink-0 items-center"
                            ]
                            [ div
                                [ class "group grid size-4 grid-cols-1"
                                ]
                                [ input
                                    [ id "color-4"
                                    , name "color[]"
                                    , value "green"
                                    , type_ "checkbox"
                                    , class "col-start-1 row-start-1 appearance-none rounded-sm border border-gray-300 bg-white checked:border-indigo-600 checked:bg-indigo-600 indeterminate:border-indigo-600 indeterminate:bg-indigo-600 focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-indigo-600 disabled:border-gray-300 disabled:bg-gray-100 disabled:checked:bg-gray-100 forced-colors:appearance-auto"
                                    ]
                                    []
                                , Svg.svg
                                    [ Svg.Attributes.class "pointer-events-none col-start-1 row-start-1 size-3.5 self-center justify-self-center stroke-white group-has-disabled:stroke-gray-950/25"
                                    , Svg.Attributes.viewBox "0 0 14 14"
                                    , Svg.Attributes.fill "none"
                                    ]
                                    [ Svg.path
                                        [ Svg.Attributes.class "opacity-0 group-has-checked:opacity-100"
                                        , Svg.Attributes.d "M3 8L6 11L11 3.5"
                                        , Svg.Attributes.strokeWidth "2"
                                        , Svg.Attributes.strokeLinecap "round"
                                        , Svg.Attributes.strokeLinejoin "round"
                                        ]
                                        []
                                    , Svg.path
                                        [ Svg.Attributes.class "opacity-0 group-has-indeterminate:opacity-100"
                                        , Svg.Attributes.d "M3 7H11"
                                        , Svg.Attributes.strokeWidth "2"
                                        , Svg.Attributes.strokeLinecap "round"
                                        , Svg.Attributes.strokeLinejoin "round"
                                        ]
                                        []
                                    ]
                                ]
                            ]
                        , label
                            [ for "color-4"
                            , class "text-sm text-gray-600"
                            ]
                            [ text "Green" ]
                        ]
                    , div
                        [ class "flex gap-3"
                        ]
                        [ div
                            [ class "flex h-5 shrink-0 items-center"
                            ]
                            [ div
                                [ class "group grid size-4 grid-cols-1"
                                ]
                                [ input
                                    [ id "color-5"
                                    , name "color[]"
                                    , value "purple"
                                    , type_ "checkbox"
                                    , class "col-start-1 row-start-1 appearance-none rounded-sm border border-gray-300 bg-white checked:border-indigo-600 checked:bg-indigo-600 indeterminate:border-indigo-600 indeterminate:bg-indigo-600 focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-indigo-600 disabled:border-gray-300 disabled:bg-gray-100 disabled:checked:bg-gray-100 forced-colors:appearance-auto"
                                    ]
                                    []
                                , Svg.svg
                                    [ Svg.Attributes.class "pointer-events-none col-start-1 row-start-1 size-3.5 self-center justify-self-center stroke-white group-has-disabled:stroke-gray-950/25"
                                    , Svg.Attributes.viewBox "0 0 14 14"
                                    , Svg.Attributes.fill "none"
                                    ]
                                    [ Svg.path
                                        [ Svg.Attributes.class "opacity-0 group-has-checked:opacity-100"
                                        , Svg.Attributes.d "M3 8L6 11L11 3.5"
                                        , Svg.Attributes.strokeWidth "2"
                                        , Svg.Attributes.strokeLinecap "round"
                                        , Svg.Attributes.strokeLinejoin "round"
                                        ]
                                        []
                                    , Svg.path
                                        [ Svg.Attributes.class "opacity-0 group-has-indeterminate:opacity-100"
                                        , Svg.Attributes.d "M3 7H11"
                                        , Svg.Attributes.strokeWidth "2"
                                        , Svg.Attributes.strokeLinecap "round"
                                        , Svg.Attributes.strokeLinejoin "round"
                                        ]
                                        []
                                    ]
                                ]
                            ]
                        , label
                            [ for "color-5"
                            , class "text-sm text-gray-600"
                            ]
                            [ text "Purple" ]
                        ]
                    ]
                ]
            ]
        , div
            [ class "py-10 first:pt-0 last:pb-0"
            ]
            [ fieldset []
                [ legend
                    [ class "block text-sm font-medium text-gray-900"
                    ]
                    [ text "Category" ]
                , div
                    [ class "space-y-3 pt-6"
                    ]
                    [ div
                        [ class "flex gap-3"
                        ]
                        [ div
                            [ class "flex h-5 shrink-0 items-center"
                            ]
                            [ div
                                [ class "group grid size-4 grid-cols-1"
                                ]
                                [ input
                                    [ id "category-0"
                                    , name "category[]"
                                    , value "new-arrivals"
                                    , type_ "checkbox"
                                    , class "col-start-1 row-start-1 appearance-none rounded-sm border border-gray-300 bg-white checked:border-indigo-600 checked:bg-indigo-600 indeterminate:border-indigo-600 indeterminate:bg-indigo-600 focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-indigo-600 disabled:border-gray-300 disabled:bg-gray-100 disabled:checked:bg-gray-100 forced-colors:appearance-auto"
                                    ]
                                    []
                                , Svg.svg
                                    [ Svg.Attributes.class "pointer-events-none col-start-1 row-start-1 size-3.5 self-center justify-self-center stroke-white group-has-disabled:stroke-gray-950/25"
                                    , Svg.Attributes.viewBox "0 0 14 14"
                                    , Svg.Attributes.fill "none"
                                    ]
                                    [ Svg.path
                                        [ Svg.Attributes.class "opacity-0 group-has-checked:opacity-100"
                                        , Svg.Attributes.d "M3 8L6 11L11 3.5"
                                        , Svg.Attributes.strokeWidth "2"
                                        , Svg.Attributes.strokeLinecap "round"
                                        , Svg.Attributes.strokeLinejoin "round"
                                        ]
                                        []
                                    , Svg.path
                                        [ Svg.Attributes.class "opacity-0 group-has-indeterminate:opacity-100"
                                        , Svg.Attributes.d "M3 7H11"
                                        , Svg.Attributes.strokeWidth "2"
                                        , Svg.Attributes.strokeLinecap "round"
                                        , Svg.Attributes.strokeLinejoin "round"
                                        ]
                                        []
                                    ]
                                ]
                            ]
                        , label
                            [ for "category-0"
                            , class "text-sm text-gray-600"
                            ]
                            [ text "All New Arrivals" ]
                        ]
                    , div
                        [ class "flex gap-3"
                        ]
                        [ div
                            [ class "flex h-5 shrink-0 items-center"
                            ]
                            [ div
                                [ class "group grid size-4 grid-cols-1"
                                ]
                                [ input
                                    [ id "category-1"
                                    , name "category[]"
                                    , value "tees"
                                    , type_ "checkbox"
                                    , class "col-start-1 row-start-1 appearance-none rounded-sm border border-gray-300 bg-white checked:border-indigo-600 checked:bg-indigo-600 indeterminate:border-indigo-600 indeterminate:bg-indigo-600 focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-indigo-600 disabled:border-gray-300 disabled:bg-gray-100 disabled:checked:bg-gray-100 forced-colors:appearance-auto"
                                    ]
                                    []
                                , Svg.svg
                                    [ Svg.Attributes.class "pointer-events-none col-start-1 row-start-1 size-3.5 self-center justify-self-center stroke-white group-has-disabled:stroke-gray-950/25"
                                    , Svg.Attributes.viewBox "0 0 14 14"
                                    , Svg.Attributes.fill "none"
                                    ]
                                    [ Svg.path
                                        [ Svg.Attributes.class "opacity-0 group-has-checked:opacity-100"
                                        , Svg.Attributes.d "M3 8L6 11L11 3.5"
                                        , Svg.Attributes.strokeWidth "2"
                                        , Svg.Attributes.strokeLinecap "round"
                                        , Svg.Attributes.strokeLinejoin "round"
                                        ]
                                        []
                                    , Svg.path
                                        [ Svg.Attributes.class "opacity-0 group-has-indeterminate:opacity-100"
                                        , Svg.Attributes.d "M3 7H11"
                                        , Svg.Attributes.strokeWidth "2"
                                        , Svg.Attributes.strokeLinecap "round"
                                        , Svg.Attributes.strokeLinejoin "round"
                                        ]
                                        []
                                    ]
                                ]
                            ]
                        , label
                            [ for "category-1"
                            , class "text-sm text-gray-600"
                            ]
                            [ text "Tees" ]
                        ]
                    , div
                        [ class "flex gap-3"
                        ]
                        [ div
                            [ class "flex h-5 shrink-0 items-center"
                            ]
                            [ div
                                [ class "group grid size-4 grid-cols-1"
                                ]
                                [ input
                                    [ id "category-2"
                                    , name "category[]"
                                    , value "crewnecks"
                                    , type_ "checkbox"
                                    , class "col-start-1 row-start-1 appearance-none rounded-sm border border-gray-300 bg-white checked:border-indigo-600 checked:bg-indigo-600 indeterminate:border-indigo-600 indeterminate:bg-indigo-600 focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-indigo-600 disabled:border-gray-300 disabled:bg-gray-100 disabled:checked:bg-gray-100 forced-colors:appearance-auto"
                                    ]
                                    []
                                , Svg.svg
                                    [ Svg.Attributes.class "pointer-events-none col-start-1 row-start-1 size-3.5 self-center justify-self-center stroke-white group-has-disabled:stroke-gray-950/25"
                                    , Svg.Attributes.viewBox "0 0 14 14"
                                    , Svg.Attributes.fill "none"
                                    ]
                                    [ Svg.path
                                        [ Svg.Attributes.class "opacity-0 group-has-checked:opacity-100"
                                        , Svg.Attributes.d "M3 8L6 11L11 3.5"
                                        , Svg.Attributes.strokeWidth "2"
                                        , Svg.Attributes.strokeLinecap "round"
                                        , Svg.Attributes.strokeLinejoin "round"
                                        ]
                                        []
                                    , Svg.path
                                        [ Svg.Attributes.class "opacity-0 group-has-indeterminate:opacity-100"
                                        , Svg.Attributes.d "M3 7H11"
                                        , Svg.Attributes.strokeWidth "2"
                                        , Svg.Attributes.strokeLinecap "round"
                                        , Svg.Attributes.strokeLinejoin "round"
                                        ]
                                        []
                                    ]
                                ]
                            ]
                        , label
                            [ for "category-2"
                            , class "text-sm text-gray-600"
                            ]
                            [ text "Crewnecks" ]
                        ]
                    , div
                        [ class "flex gap-3"
                        ]
                        [ div
                            [ class "flex h-5 shrink-0 items-center"
                            ]
                            [ div
                                [ class "group grid size-4 grid-cols-1"
                                ]
                                [ input
                                    [ id "category-3"
                                    , name "category[]"
                                    , value "sweatshirts"
                                    , type_ "checkbox"
                                    , class "col-start-1 row-start-1 appearance-none rounded-sm border border-gray-300 bg-white checked:border-indigo-600 checked:bg-indigo-600 indeterminate:border-indigo-600 indeterminate:bg-indigo-600 focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-indigo-600 disabled:border-gray-300 disabled:bg-gray-100 disabled:checked:bg-gray-100 forced-colors:appearance-auto"
                                    ]
                                    []
                                , Svg.svg
                                    [ Svg.Attributes.class "pointer-events-none col-start-1 row-start-1 size-3.5 self-center justify-self-center stroke-white group-has-disabled:stroke-gray-950/25"
                                    , Svg.Attributes.viewBox "0 0 14 14"
                                    , Svg.Attributes.fill "none"
                                    ]
                                    [ Svg.path
                                        [ Svg.Attributes.class "opacity-0 group-has-checked:opacity-100"
                                        , Svg.Attributes.d "M3 8L6 11L11 3.5"
                                        , Svg.Attributes.strokeWidth "2"
                                        , Svg.Attributes.strokeLinecap "round"
                                        , Svg.Attributes.strokeLinejoin "round"
                                        ]
                                        []
                                    , Svg.path
                                        [ Svg.Attributes.class "opacity-0 group-has-indeterminate:opacity-100"
                                        , Svg.Attributes.d "M3 7H11"
                                        , Svg.Attributes.strokeWidth "2"
                                        , Svg.Attributes.strokeLinecap "round"
                                        , Svg.Attributes.strokeLinejoin "round"
                                        ]
                                        []
                                    ]
                                ]
                            ]
                        , label
                            [ for "category-3"
                            , class "text-sm text-gray-600"
                            ]
                            [ text "Sweatshirts" ]
                        ]
                    , div
                        [ class "flex gap-3"
                        ]
                        [ div
                            [ class "flex h-5 shrink-0 items-center"
                            ]
                            [ div
                                [ class "group grid size-4 grid-cols-1"
                                ]
                                [ input
                                    [ id "category-4"
                                    , name "category[]"
                                    , value "pants-shorts"
                                    , type_ "checkbox"
                                    , class "col-start-1 row-start-1 appearance-none rounded-sm border border-gray-300 bg-white checked:border-indigo-600 checked:bg-indigo-600 indeterminate:border-indigo-600 indeterminate:bg-indigo-600 focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-indigo-600 disabled:border-gray-300 disabled:bg-gray-100 disabled:checked:bg-gray-100 forced-colors:appearance-auto"
                                    ]
                                    []
                                , Svg.svg
                                    [ Svg.Attributes.class "pointer-events-none col-start-1 row-start-1 size-3.5 self-center justify-self-center stroke-white group-has-disabled:stroke-gray-950/25"
                                    , Svg.Attributes.viewBox "0 0 14 14"
                                    , Svg.Attributes.fill "none"
                                    ]
                                    [ Svg.path
                                        [ Svg.Attributes.class "opacity-0 group-has-checked:opacity-100"
                                        , Svg.Attributes.d "M3 8L6 11L11 3.5"
                                        , Svg.Attributes.strokeWidth "2"
                                        , Svg.Attributes.strokeLinecap "round"
                                        , Svg.Attributes.strokeLinejoin "round"
                                        ]
                                        []
                                    , Svg.path
                                        [ Svg.Attributes.class "opacity-0 group-has-indeterminate:opacity-100"
                                        , Svg.Attributes.d "M3 7H11"
                                        , Svg.Attributes.strokeWidth "2"
                                        , Svg.Attributes.strokeLinecap "round"
                                        , Svg.Attributes.strokeLinejoin "round"
                                        ]
                                        []
                                    ]
                                ]
                            ]
                        , label
                            [ for "category-4"
                            , class "text-sm text-gray-600"
                            ]
                            [ text "Pants & Shorts" ]
                        ]
                    ]
                ]
            ]
        , div
            [ class "py-10 first:pt-0 last:pb-0"
            ]
            [ fieldset []
                [ legend
                    [ class "block text-sm font-medium text-gray-900"
                    ]
                    [ text "Sizes" ]
                , div
                    [ class "space-y-3 pt-6"
                    ]
                    [ div
                        [ class "flex gap-3"
                        ]
                        [ div
                            [ class "flex h-5 shrink-0 items-center"
                            ]
                            [ div
                                [ class "group grid size-4 grid-cols-1"
                                ]
                                [ input
                                    [ id "sizes-0"
                                    , name "sizes[]"
                                    , value "xs"
                                    , type_ "checkbox"
                                    , class "col-start-1 row-start-1 appearance-none rounded-sm border border-gray-300 bg-white checked:border-indigo-600 checked:bg-indigo-600 indeterminate:border-indigo-600 indeterminate:bg-indigo-600 focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-indigo-600 disabled:border-gray-300 disabled:bg-gray-100 disabled:checked:bg-gray-100 forced-colors:appearance-auto"
                                    ]
                                    []
                                , Svg.svg
                                    [ Svg.Attributes.class "pointer-events-none col-start-1 row-start-1 size-3.5 self-center justify-self-center stroke-white group-has-disabled:stroke-gray-950/25"
                                    , Svg.Attributes.viewBox "0 0 14 14"
                                    , Svg.Attributes.fill "none"
                                    ]
                                    [ Svg.path
                                        [ Svg.Attributes.class "opacity-0 group-has-checked:opacity-100"
                                        , Svg.Attributes.d "M3 8L6 11L11 3.5"
                                        , Svg.Attributes.strokeWidth "2"
                                        , Svg.Attributes.strokeLinecap "round"
                                        , Svg.Attributes.strokeLinejoin "round"
                                        ]
                                        []
                                    , Svg.path
                                        [ Svg.Attributes.class "opacity-0 group-has-indeterminate:opacity-100"
                                        , Svg.Attributes.d "M3 7H11"
                                        , Svg.Attributes.strokeWidth "2"
                                        , Svg.Attributes.strokeLinecap "round"
                                        , Svg.Attributes.strokeLinejoin "round"
                                        ]
                                        []
                                    ]
                                ]
                            ]
                        , label
                            [ for "sizes-0"
                            , class "text-sm text-gray-600"
                            ]
                            [ text "XS" ]
                        ]
                    , div
                        [ class "flex gap-3"
                        ]
                        [ div
                            [ class "flex h-5 shrink-0 items-center"
                            ]
                            [ div
                                [ class "group grid size-4 grid-cols-1"
                                ]
                                [ input
                                    [ id "sizes-1"
                                    , name "sizes[]"
                                    , value "s"
                                    , type_ "checkbox"
                                    , class "col-start-1 row-start-1 appearance-none rounded-sm border border-gray-300 bg-white checked:border-indigo-600 checked:bg-indigo-600 indeterminate:border-indigo-600 indeterminate:bg-indigo-600 focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-indigo-600 disabled:border-gray-300 disabled:bg-gray-100 disabled:checked:bg-gray-100 forced-colors:appearance-auto"
                                    ]
                                    []
                                , Svg.svg
                                    [ Svg.Attributes.class "pointer-events-none col-start-1 row-start-1 size-3.5 self-center justify-self-center stroke-white group-has-disabled:stroke-gray-950/25"
                                    , Svg.Attributes.viewBox "0 0 14 14"
                                    , Svg.Attributes.fill "none"
                                    ]
                                    [ Svg.path
                                        [ Svg.Attributes.class "opacity-0 group-has-checked:opacity-100"
                                        , Svg.Attributes.d "M3 8L6 11L11 3.5"
                                        , Svg.Attributes.strokeWidth "2"
                                        , Svg.Attributes.strokeLinecap "round"
                                        , Svg.Attributes.strokeLinejoin "round"
                                        ]
                                        []
                                    , Svg.path
                                        [ Svg.Attributes.class "opacity-0 group-has-indeterminate:opacity-100"
                                        , Svg.Attributes.d "M3 7H11"
                                        , Svg.Attributes.strokeWidth "2"
                                        , Svg.Attributes.strokeLinecap "round"
                                        , Svg.Attributes.strokeLinejoin "round"
                                        ]
                                        []
                                    ]
                                ]
                            ]
                        , label
                            [ for "sizes-1"
                            , class "text-sm text-gray-600"
                            ]
                            [ text "S" ]
                        ]
                    , div
                        [ class "flex gap-3"
                        ]
                        [ div
                            [ class "flex h-5 shrink-0 items-center"
                            ]
                            [ div
                                [ class "group grid size-4 grid-cols-1"
                                ]
                                [ input
                                    [ id "sizes-2"
                                    , name "sizes[]"
                                    , value "m"
                                    , type_ "checkbox"
                                    , class "col-start-1 row-start-1 appearance-none rounded-sm border border-gray-300 bg-white checked:border-indigo-600 checked:bg-indigo-600 indeterminate:border-indigo-600 indeterminate:bg-indigo-600 focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-indigo-600 disabled:border-gray-300 disabled:bg-gray-100 disabled:checked:bg-gray-100 forced-colors:appearance-auto"
                                    ]
                                    []
                                , Svg.svg
                                    [ Svg.Attributes.class "pointer-events-none col-start-1 row-start-1 size-3.5 self-center justify-self-center stroke-white group-has-disabled:stroke-gray-950/25"
                                    , Svg.Attributes.viewBox "0 0 14 14"
                                    , Svg.Attributes.fill "none"
                                    ]
                                    [ Svg.path
                                        [ Svg.Attributes.class "opacity-0 group-has-checked:opacity-100"
                                        , Svg.Attributes.d "M3 8L6 11L11 3.5"
                                        , Svg.Attributes.strokeWidth "2"
                                        , Svg.Attributes.strokeLinecap "round"
                                        , Svg.Attributes.strokeLinejoin "round"
                                        ]
                                        []
                                    , Svg.path
                                        [ Svg.Attributes.class "opacity-0 group-has-indeterminate:opacity-100"
                                        , Svg.Attributes.d "M3 7H11"
                                        , Svg.Attributes.strokeWidth "2"
                                        , Svg.Attributes.strokeLinecap "round"
                                        , Svg.Attributes.strokeLinejoin "round"
                                        ]
                                        []
                                    ]
                                ]
                            ]
                        , label
                            [ for "sizes-2"
                            , class "text-sm text-gray-600"
                            ]
                            [ text "M" ]
                        ]
                    , div
                        [ class "flex gap-3"
                        ]
                        [ div
                            [ class "flex h-5 shrink-0 items-center"
                            ]
                            [ div
                                [ class "group grid size-4 grid-cols-1"
                                ]
                                [ input
                                    [ id "sizes-3"
                                    , name "sizes[]"
                                    , value "l"
                                    , type_ "checkbox"
                                    , class "col-start-1 row-start-1 appearance-none rounded-sm border border-gray-300 bg-white checked:border-indigo-600 checked:bg-indigo-600 indeterminate:border-indigo-600 indeterminate:bg-indigo-600 focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-indigo-600 disabled:border-gray-300 disabled:bg-gray-100 disabled:checked:bg-gray-100 forced-colors:appearance-auto"
                                    ]
                                    []
                                , Svg.svg
                                    [ Svg.Attributes.class "pointer-events-none col-start-1 row-start-1 size-3.5 self-center justify-self-center stroke-white group-has-disabled:stroke-gray-950/25"
                                    , Svg.Attributes.viewBox "0 0 14 14"
                                    , Svg.Attributes.fill "none"
                                    ]
                                    [ Svg.path
                                        [ Svg.Attributes.class "opacity-0 group-has-checked:opacity-100"
                                        , Svg.Attributes.d "M3 8L6 11L11 3.5"
                                        , Svg.Attributes.strokeWidth "2"
                                        , Svg.Attributes.strokeLinecap "round"
                                        , Svg.Attributes.strokeLinejoin "round"
                                        ]
                                        []
                                    , Svg.path
                                        [ Svg.Attributes.class "opacity-0 group-has-indeterminate:opacity-100"
                                        , Svg.Attributes.d "M3 7H11"
                                        , Svg.Attributes.strokeWidth "2"
                                        , Svg.Attributes.strokeLinecap "round"
                                        , Svg.Attributes.strokeLinejoin "round"
                                        ]
                                        []
                                    ]
                                ]
                            ]
                        , label
                            [ for "sizes-3"
                            , class "text-sm text-gray-600"
                            ]
                            [ text "L" ]
                        ]
                    , div
                        [ class "flex gap-3"
                        ]
                        [ div
                            [ class "flex h-5 shrink-0 items-center"
                            ]
                            [ div
                                [ class "group grid size-4 grid-cols-1"
                                ]
                                [ input
                                    [ id "sizes-4"
                                    , name "sizes[]"
                                    , value "xl"
                                    , type_ "checkbox"
                                    , class "col-start-1 row-start-1 appearance-none rounded-sm border border-gray-300 bg-white checked:border-indigo-600 checked:bg-indigo-600 indeterminate:border-indigo-600 indeterminate:bg-indigo-600 focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-indigo-600 disabled:border-gray-300 disabled:bg-gray-100 disabled:checked:bg-gray-100 forced-colors:appearance-auto"
                                    ]
                                    []
                                , Svg.svg
                                    [ Svg.Attributes.class "pointer-events-none col-start-1 row-start-1 size-3.5 self-center justify-self-center stroke-white group-has-disabled:stroke-gray-950/25"
                                    , Svg.Attributes.viewBox "0 0 14 14"
                                    , Svg.Attributes.fill "none"
                                    ]
                                    [ Svg.path
                                        [ Svg.Attributes.class "opacity-0 group-has-checked:opacity-100"
                                        , Svg.Attributes.d "M3 8L6 11L11 3.5"
                                        , Svg.Attributes.strokeWidth "2"
                                        , Svg.Attributes.strokeLinecap "round"
                                        , Svg.Attributes.strokeLinejoin "round"
                                        ]
                                        []
                                    , Svg.path
                                        [ Svg.Attributes.class "opacity-0 group-has-indeterminate:opacity-100"
                                        , Svg.Attributes.d "M3 7H11"
                                        , Svg.Attributes.strokeWidth "2"
                                        , Svg.Attributes.strokeLinecap "round"
                                        , Svg.Attributes.strokeLinejoin "round"
                                        ]
                                        []
                                    ]
                                ]
                            ]
                        , label
                            [ for "sizes-4"
                            , class "text-sm text-gray-600"
                            ]
                            [ text "XL" ]
                        ]
                    , div
                        [ class "flex gap-3"
                        ]
                        [ div
                            [ class "flex h-5 shrink-0 items-center"
                            ]
                            [ div
                                [ class "group grid size-4 grid-cols-1"
                                ]
                                [ input
                                    [ id "sizes-5"
                                    , name "sizes[]"
                                    , value "2xl"
                                    , type_ "checkbox"
                                    , class "col-start-1 row-start-1 appearance-none rounded-sm border border-gray-300 bg-white checked:border-indigo-600 checked:bg-indigo-600 indeterminate:border-indigo-600 indeterminate:bg-indigo-600 focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-indigo-600 disabled:border-gray-300 disabled:bg-gray-100 disabled:checked:bg-gray-100 forced-colors:appearance-auto"
                                    ]
                                    []
                                , Svg.svg
                                    [ Svg.Attributes.class "pointer-events-none col-start-1 row-start-1 size-3.5 self-center justify-self-center stroke-white group-has-disabled:stroke-gray-950/25"
                                    , Svg.Attributes.viewBox "0 0 14 14"
                                    , Svg.Attributes.fill "none"
                                    ]
                                    [ Svg.path
                                        [ Svg.Attributes.class "opacity-0 group-has-checked:opacity-100"
                                        , Svg.Attributes.d "M3 8L6 11L11 3.5"
                                        , Svg.Attributes.strokeWidth "2"
                                        , Svg.Attributes.strokeLinecap "round"
                                        , Svg.Attributes.strokeLinejoin "round"
                                        ]
                                        []
                                    , Svg.path
                                        [ Svg.Attributes.class "opacity-0 group-has-indeterminate:opacity-100"
                                        , Svg.Attributes.d "M3 7H11"
                                        , Svg.Attributes.strokeWidth "2"
                                        , Svg.Attributes.strokeLinecap "round"
                                        , Svg.Attributes.strokeLinejoin "round"
                                        ]
                                        []
                                    ]
                                ]
                            ]
                        , label
                            [ for "sizes-5"
                            , class "text-sm text-gray-600"
                            ]
                            [ text "2XL" ]
                        ]
                    ]
                ]
            ]
        ]


main : Program String Model Msg
main =
    Browser.element
        { init = init
        , update = update
        , view = view
        , subscriptions = \_ -> Sub.none
        }
