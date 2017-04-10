module StyleSheet exposing (..)

import Style exposing (..)
import Html exposing (Html)


type Class
    = Body
    | Header
    | Content
    | Title
    | Status
    | UL
    | ProjectInfo
    | ProjectHeader
    | ProjectLink
    | ProjectName
    | ProjectDetail


stylesheet : StyleSheet Class msg
stylesheet =
    Style.render
        [ class Body
            [ maxWidth (px 960)
            , padding (left 15)
            , font "serif"
            ]
        , class Header
            [ padding (bottom 25)
            ]
        , class Content
            []
        , class Title
            [ fontsize 50 ]
        , class Status
            [ fontsize 25
            , padding (bottom 15)
            ]
        , class UL
            [ spacing (top 10) ]
        , class ProjectInfo
            [ padding (leftRightTopBottom 20 0 0 20) ]
        , class ProjectHeader
            []
        , class ProjectLink
            [ inline
            , padding (leftRight 5)
            ]
        , class ProjectName
            [ fontsize 22
            , inline
            ]
        , class ProjectDetail
            [ padding (bottom 10) ]
        ]
