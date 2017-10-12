module NewStyle exposing (..)

import Style exposing (..)
import Style.Color as ElementColor
import Style.Font as ElementFont
import Color exposing (rgba)


type NewStyle
    = None
    | Main
    | Header
    | Title
    | Nav
    | Bio
    | ProjectTitle
    | ProjectDescription
    | SideBar
    | SideBarTitle
    | Link
    | Tag
    | ActiveTag
    | Active
    | InProgress
    | Inactive


colors =
    { darkGrey = rgba 100 100 100 1
    , white = rgba 255 255 255 1
    , pink = rgba 210 130 130 1
    , green = rgba 50 150 50 1
    , yellow = rgba 150 150 50 1
    , red = rgba 150 50 50 1
    , blue = rgba 130 130 210 1
    }


stylesheet : StyleSheet NewStyle variation
stylesheet =
    Style.styleSheet
        [ style None []
        , style Main
            [ ElementColor.background colors.white
            , ElementFont.typeface
                [ (ElementFont.importUrl { name = "Didact Gothic", url = "https://fonts.googleapis.com/css?family=Didact+Gothic" })
                ]
            , ElementFont.size 16
            ]
        , style Header [ ElementFont.size 16 ]
        , style Title
            [ ElementFont.size 52 ]
        , style ProjectTitle
            [ ElementFont.size 22 ]
        , style ProjectDescription
            [ ElementFont.lineHeight 1.25 ]
        , style SideBar
            [ ElementColor.text colors.darkGrey ]
        , style SideBarTitle
            [ ElementFont.size 20 ]
        , style Link
            [ ElementColor.text colors.blue
            , ElementFont.underline
            ]
        , style Tag
            [ hover
                [ ElementColor.text colors.pink
                , cursor "pointer"
                ]
            ]
        , style ActiveTag
            [ ElementColor.text colors.pink ]
        , style Active
            [ ElementColor.text colors.green ]
        , style InProgress
            [ ElementColor.text colors.yellow ]
        , style Inactive
            [ ElementColor.text colors.red ]
        ]
