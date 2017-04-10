module StyleSheet exposing (..)

import Style exposing (..)
import Html exposing (Html)


type Class
    = Content


stylesheet : StyleSheet Class msg
stylesheet =
    Style.render
        [ class Content
            [ width (px 300)
            ]
        ]
