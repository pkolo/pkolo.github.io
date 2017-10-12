module Main exposing (..)

import String exposing (join)
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
    program
        { init = init
        , view = view
        , update = update
        , subscriptions = \_ -> Sub.none
        }



-- model


type alias Model =
    { bio : String
    , categories : List String
    , technologies : List String
    , statuses : List String
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
    , status : String
    , categories : List String
    , technologies : List String
    , link : String
    , src_link : String
    , description : String
    }


init : ( Model, Cmd Msg )
init =
    ( initialModel, Cmd.none )


initialModel : Model
initialModel =
    let
        result =
            decodeResult Data.json
    in
        { bio = result.bio
        , categories = List.sort (unique (getCategories result.projects))
        , technologies = List.sort (unique (getTechnologies result.projects))
        , statuses = (unique (getStatuses result.projects))
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
        |> required "status" string
        |> required "categories" (list string)
        |> required "technologies" (list string)
        |> required "link" string
        |> required "src_link" string
        |> required "description" string


getStatuses : List Project -> List String
getStatuses projects =
    List.map (\p -> p.status) projects


getCategories : List Project -> List String
getCategories projects =
    List.concat (List.map (\p -> p.categories) projects)


getTechnologies : List Project -> List String
getTechnologies projects =
    List.concat (List.map (\p -> p.technologies) projects)


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
                ]
            , div [ class Container ]
                [ (getSidebar model)
                , div [ class Content ]
                    [ div []
                        (List.map viewProject (List.sortBy .id model.projects))
                    ]
                ]
            ]
        ]


getSidebar : Model -> Html Msg
getSidebar model =
    div [ class Sidebar ]
        [ div [ class SidebarHead ]
            [ text "Filter projects by" ]
        , div
            [ class FilterBtn
            , onClick (ResetModel)
            ]
            [ text separator
            , text "All"
            ]
        , div [ class FilterBar ]
            (List.map statusFilters model.statuses)
        , div [ class FilterBar ]
            (List.map categoryFilters model.categories)
        , div [ class FilterBar ]
            (List.map techFilters model.technologies)
        , div [ class SidebarFoot ]
            [ div [] [ text "© Patrick Kolodgy, 2017" ]
            , div []
                [ text "Written in Elm"
                , text separator
                , a
                    [ href "https://github.com/pkolo/pkolo.github.io"
                    , target "_blank"
                    , class Link
                    ]
                    [ text "src" ]
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
                , div [ class P ] [ text ("Technologies used: " ++ (join ", " (List.sort project.technologies))) ]
                , div [ class P ] [ text ("File under: " ++ (join ", " (List.sort project.categories))) ]
                ]
            ]
        ]


statusFilters : String -> Html Msg
statusFilters status =
    div
        [ class FilterBtn
        , onClick (StatusFilter status)
        ]
        [ text separator
        , text status
        ]


categoryFilters : String -> Html Msg
categoryFilters category =
    div
        [ class FilterBtn
        , onClick (CategoryFilter category)
        ]
        [ text separator
        , text category
        ]


techFilters : String -> Html Msg
techFilters tech =
    div
        [ class FilterBtn
        , onClick (TechFilter tech)
        ]
        [ text separator
        , text tech
        ]


getStatus : Project -> Html Msg
getStatus project =
    if project.status == "Active" then
        div [ class Active ]
            [ text "(active)" ]
    else if project.status == "In Progress" then
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
    = StatusFilter String
    | CategoryFilter String
    | TechFilter String
    | ResetModel


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        StatusFilter status ->
            ( filterByStatus initialModel status, Cmd.none )

        CategoryFilter category ->
            ( filterByCategory initialModel category, Cmd.none )

        TechFilter tech ->
            ( filterByTech initialModel tech, Cmd.none )

        ResetModel ->
            ( initialModel, Cmd.none )


filterByStatus : Model -> String -> Model
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


filterByTech : Model -> String -> Model
filterByTech model tech =
    let
        newProjects =
            List.filter (\p -> (List.member tech p.technologies)) model.projects
    in
        { model | projects = newProjects }
