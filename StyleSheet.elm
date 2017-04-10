module StyleSheet exposing (..)

import Style exposing (..)
import Html exposing (Html)


type Class
    = Body
    | Header
    | Content
    | Title
    | Status


stylesheet : StyleSheet Class msg
stylesheet =
    Style.render
        [ class Body
            [ maxWidth (px 960)
            , padding (left 15)
            ]
        , class Header
            [ padding (bottom 25)
            ]
        , class Content
            []
        , class Title
            [ fontsize 50 ]
        , class Status
            [ fontsize 25 ]
        ]
