module NewStyle exposing (..)

import Style exposing (..)
import Style.Color as ElementColor
import Style.Font as ElementFont
import Style.Scale as Scale
import Color exposing (rgba)


type NewStyle
    = None
    | Main
    | Title


colors =
    { darkGrey = rgba 40 40 40 1
    , white = rgba 255 255 255 1
    }


scale : Int -> Float
scale =
    Scale.modular 16 1.618


stylesheet : StyleSheet NewStyle variation
stylesheet =
    Style.styleSheet
        [ style None []
        , style Main
            [ ElementColor.text colors.darkGrey
            , ElementColor.background colors.white
            , ElementFont.size (scale 1)
            ]
        , style Title
            [ ElementFont.size (scale 3)
            ]
        ]
