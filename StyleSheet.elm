module StyleSheet exposing (..)

import Style exposing (..)
import Color exposing (Color)


type Class
    = Body
    | Header
    | Nav
    | Link
    | Bio
    | Container
    | Sidebar
    | SidebarHead
    | FilterBar
    | FilterBtn
    | Content
    | Title
    | Status
    | UL
    | P
    | Active
    | InProgress
    | Inactive
    | ProjectInfo
    | ProjectHeader
    | ProjectLink
    | ProjectName
    | ProjectDetails
    | ProjectDetail
    | ProjectThumb


stylesheet : StyleSheet Class msg
stylesheet =
    Style.renderWith [ Style.autoImportGoogleFonts ]
        [ class Body
            [ maxWidth (px 960)
            , padding (left 15)
            , font "Didact Gothic"
            ]
        , class Header
            [ padding (bottom 25)
            ]
        , class Nav
            [ padding (left 2) ]
        , class Link
            [ textColor (Color.rgb 130 130 210)
            , inline
            ]
        , class Bio
            [ padding (top 10) ]
        , class Container
            [ maxWidth (px 1200)
            , flowRight
                { wrap = True
                , horizontal = alignLeft
                , vertical = alignTop
                }
            ]
        , class FilterBar
            [ padding (bottom 10) ]
        , class FilterBtn
            [ hover
                [ textColor (Color.rgb 210 130 130)
                , cursor "pointer"
                ]
            ]
        , class Content
            [ padding (left 2)
            , maxWidth (px 960)
            ]
        , class Sidebar
            [ width (px 180) ]
        , class SidebarHead
            [ fontsize 20
            , padding (bottom 5)
            ]
        , class Title
            [ fontsize 52
            ]
        , class Status
            [ fontsize 25
            , padding (bottom 15)
            ]
        , class UL
            [ spacing (top 10) ]
        , class P
            [ padding (bottom 5) ]
        , class Active
            [ textColor (Color.rgb 50 150 50)
            , inline
            , padding (left 5)
            ]
        , class InProgress
            [ textColor (Color.rgb 150 150 50)
            , inline
            , padding (left 5)
            ]
        , class Inactive
            [ textColor (Color.rgb 150 50 50)
            , inline
            , padding (left 5)
            ]
        , class ProjectInfo
            [ padding (leftRightTopBottom 20 0 0 10) ]
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
        , class ProjectDetails
            [ maxWidth (px 825)
            , Style.flowLeft
                { wrap = True
                , horizontal = Style.alignRight
                , vertical = Style.alignTop
                }
            ]
        , class ProjectDetail
            [ padding (bottom 10)
            , maxWidth (px 700)
            ]
        , class ProjectThumb
            [ width (px 120)
            , Style.floatLeft
            , padding (allButLeft 5)
            ]
        ]
