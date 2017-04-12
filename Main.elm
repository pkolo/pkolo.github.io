module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class, target, href, property, src)
import Html.Events exposing (onClick)
import Json.Decode exposing (..)
import Json.Decode.Pipeline exposing (..)
import StyleSheet exposing (Class(..))
import Style exposing (all)
import Set exposing (..)
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
    , categories : List String
    , projects : List Project
    }


type alias Result =
    { bio : String
    , projects : List Project
    }


type alias Project =
    { id : Int
    , name : String
    , timeline : String
    , status : Int
    , categories : List String
    , technologies : List String
    , link : String
    , src_link : String
    , description : String
    }


initialModel : Model
initialModel =
    let
        result =
            decodeResult Data.json
    in
        { bio = result.bio
        , categories = (unique (getCategories result.projects))
        , projects = result.projects
        }


decodeResult : String -> Result
decodeResult json =
    case Json.Decode.decodeString modelDecoder json of
        Ok model ->
            model

        Err errorMessage ->
            { bio = "Error"
            , projects = []
            }


modelDecoder : Decoder Result
modelDecoder =
    Json.Decode.Pipeline.decode Result
        |> required "bio" string
        |> required "projects" (list projectDecoder)


projectDecoder : Decoder Project
projectDecoder =
    Json.Decode.Pipeline.decode Project
        |> required "id" int
        |> required "name" string
        |> required "timeline" string
        |> required "status" int
        |> required "categories" (list string)
        |> required "technologies" (list string)
        |> required "link" string
        |> required "src_link" string
        |> required "description" string


getCategories : List Project -> List String
getCategories projects =
    List.concat (List.map (\p -> p.categories) projects)


unique : List comparable -> List comparable
unique list =
    uniqueHelp identity Set.empty list


uniqueHelp : (a -> comparable) -> Set comparable -> List a -> List a
uniqueHelp f existing remaining =
    case remaining of
        [] ->
            []

        first :: rest ->
            let
                computedFirst =
                    f first
            in
                if Set.member computedFirst existing then
                    uniqueHelp f existing rest
                else
                    first :: uniqueHelp f (Set.insert computedFirst existing) rest



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
                , div [ class Bio ] [ text model.bio ]
                , div
                    [ class FilterBtn
                    , onClick (StatusFilter 0)
                    ]
                    [ text "Active" ]
                , text separator
                , div
                    [ class FilterBtn
                    , onClick (StatusFilter 1)
                    ]
                    [ text "In Progress" ]
                , text separator
                , div
                    [ class FilterBtn
                    , onClick (StatusFilter 2)
                    ]
                    [ text "Inactive" ]
                ]
            , p []
                (List.map categoryFilters model.categories)
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
                , div [ class P ] [ text ("Technologies used: " ++ (toString project.technologies)) ]
                , div [ class P ] [ text ("File under: " ++ (toString project.categories)) ]
                ]
            ]
        ]


categoryFilters : String -> Html Msg
categoryFilters category =
    div
        [ class FilterBtn
        , onClick (CategoryFilter category)
        ]
        [ text category ]


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



-- update


type Msg
    = StatusFilter Int
    | CategoryFilter String


update : Msg -> Model -> Model
update msg model =
    case msg of
        StatusFilter status ->
            filterByStatus initialModel status

        CategoryFilter category ->
            filterByCategory initialModel category


filterByStatus : Model -> Int -> Model
filterByStatus model status =
    let
        newProjects =
            List.filter (\p -> p.status == status) model.projects
    in
        { model | projects = newProjects }


filterByCategory : Model -> String -> Model
filterByCategory model category =
    let
        newProjects =
            List.filter (\p -> (List.member category p.categories)) model.projects
    in
        { model | projects = newProjects }
