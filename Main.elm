module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class, target, href, property, src)
import Json.Decode exposing (..)
import Json.Decode.Pipeline exposing (..)
import StyleSheet exposing (Class(..))
import Style exposing (all)
import Data


main : Program Never Model Msg
main =
    Html.beginnerProgram
        { view = view
        , model = initialModel
        , update = update
        }



-- model


type alias Model =
    { bio : String
    , projects : List Project
    }


type alias Project =
    { id : Int
    , name : String
    , timeline : String
    , status : Int
    , categories : String
    , technologies : String
    , link : String
    , src_link : String
    , description : String
    }


initialModel : Model
initialModel =
    decodeResult Data.json


decodeResult : String -> Model
decodeResult json =
    case Json.Decode.decodeString modelDecoder json of
        Ok model ->
            model

        Err errorMessage ->
            { bio = "Error"
            , projects = []
            }


modelDecoder : Decoder Model
modelDecoder =
    Json.Decode.Pipeline.decode Model
        |> required "bio" string
        |> required "projects" (list projectDecoder)


projectDecoder : Decoder Project
projectDecoder =
    Json.Decode.Pipeline.decode Project
        |> required "id" int
        |> required "name" string
        |> required "timeline" string
        |> required "status" int
        |> required "categories" string
        |> required "technologies" string
        |> required "link" string
        |> required "src_link" string
        |> required "description" string



-- view


{ class, classList } =
    StyleSheet.stylesheet


view : Model -> Html Msg
view model =
    div []
        [ Style.embed StyleSheet.stylesheet
        , div [ class Body ]
            [ header [ class Header ]
                [ div [ class Title ] [ text "Patrick Kolodgy" ]
                , nav [ class Nav ]
                    [ text "Brooklyn, NY"
                    , text separator
                    , text "pkolodgy at gmail"
                    , text separator
                    , a
                        [ href "https://github.com/pkolo"
                        , target "_blank"
                        , class Link
                        ]
                        [ text "github" ]
                    , text separator
                    , a
                        [ href "https://www.linkedin.com/in/pkolodgy/"
                        , target "_blank"
                        , class Link
                        ]
                        [ text "linkedin" ]
                    ]
                , div [] [ text model.bio ]
                ]
            , div [ class Content ]
                [ div []
                    (List.map viewProject (List.sortBy .status model.projects))
                ]
            ]
        ]


viewProject : Project -> Html Msg
viewProject project =
    div [ class ProjectInfo ]
        [ div [ class ProjectHeader ]
            [ span [ class ProjectName ]
                [ text project.name ]
            , (getStatus project)
            , (getLink project)
            , (getSrc project)
            ]
        , div [ class ProjectDetails ]
            [ div [ class ProjectDetail ]
                [ div [ class P ] [ text project.description ]
                , div [ class P ] [ text ("Technologies used: " ++ project.technologies) ]
                , div [ class P ] [ text ("File under: " ++ project.categories) ]
                ]
            ]
        ]


getStatus : Project -> Html Msg
getStatus project =
    if project.status == 0 then
        div [ class Active ]
            [ text "(active)" ]
    else if project.status == 1 then
        div [ class InProgress ]
            [ text "(in progress)" ]
    else
        div [ class Inactive ]
            [ text "(inactive)" ]


getLink : Project -> Html Msg
getLink project =
    if project.link /= "" then
        span [ class ProjectLink ]
            [ a
                [ href project.link
                , target "_blank"
                , class Link
                ]
                [ text "link" ]
            ]
    else
        text ""


getSrc : Project -> Html Msg
getSrc project =
    if project.src_link /= "" then
        span [ class ProjectLink ]
            [ a
                [ href project.src_link
                , target "_blank"
                , class Link
                ]
                [ text "src" ]
            ]
    else
        text ""


separator : String
separator =
    " | "


type Msg
    = SetQuery String



-- update


update : Msg -> Model -> Model
update msg model =
    initialModel
