module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class, target, href, property)
import Json.Decode exposing (..)
import Json.Decode.Pipeline exposing (..)
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
    { projects : List Project
    }


initialModel : Model
initialModel =
    { projects = decodeResults Data.json
    }


type alias Project =
    { id : Int
    , name : String
    , timeline : String
    , status : String
    , categories : String
    , technologies : String
    , link : String
    , src_link : String
    , description : String
    }


responseDecoder : Decoder (List Project)
responseDecoder =
    Json.Decode.Pipeline.decode identity
        |> required "projects" (list searchResultDecoder)


searchResultDecoder : Decoder Project
searchResultDecoder =
    Json.Decode.Pipeline.decode Project
        |> required "id" int
        |> required "name" string
        |> required "timeline" string
        |> required "status" string
        |> required "categories" string
        |> required "technologies" string
        |> required "link" string
        |> required "src_link" string
        |> required "description" string


decodeResults : String -> List Project
decodeResults json =
    case decodeString responseDecoder json of
        Ok searchResults ->
            searchResults

        Err errorMessage ->
            []



-- view


view : Model -> Html Msg
view model =
    div []
        [ header []
            [ h1 [] [ text "Patrick Kolodgy" ]
            , nav []
                [ text "Brooklyn, NY"
                , text separator
                , text "pkolodgy at gmail"
                , text separator
                , a
                    [ href "https://github.com/pkolo"
                    , target "_blank"
                    ]
                    [ text "github" ]
                , text separator
                , a
                    [ href "https://www.linkedin.com/in/pkolodgy/"
                    , target "_blank"
                    ]
                    [ text "linkedin" ]
                ]
            ]
        , h3 []
            [ text "Active" ]
        , ul []
            (List.map viewProject (activeProjects model.projects))
        , h3 []
            [ text "Works in progress" ]
        , ul []
            (List.map viewProject (wipProjects model.projects))
        , h3 []
            [ text "Inactive" ]
        , ul []
            (List.map viewProject (inactiveProjects model.projects))
        ]


activeProjects : List Project -> List Project
activeProjects projects =
    List.filter (\project -> (project.status == "Active")) projects


wipProjects : List Project -> List Project
wipProjects projects =
    List.filter (\project -> (project.status == "Work in progress")) projects


inactiveProjects : List Project -> List Project
inactiveProjects projects =
    List.filter (\project -> (project.status == "Inactive")) projects


viewProject : Project -> Html Msg
viewProject project =
    li []
        [ div [ class "project" ]
            [ div [ class "project-info" ]
                [ text project.name
                , (getLink project)
                , (getSrc project)
                ]
            , div [ class "project-details" ]
                [ p []
                    [ text project.description ]
                , p []
                    [ text ("Technologies used: " ++ project.technologies) ]
                , p []
                    [ text ("File under: " ++ project.categories) ]
                ]
            ]
        ]


getLink : Project -> Html Msg
getLink project =
    if project.link /= "" then
        span []
            [ text separator
            , a
                [ href project.link
                , target "_blank"
                ]
                [ text "link" ]
            ]
    else
        text ""


getSrc : Project -> Html Msg
getSrc project =
    if project.src_link /= "" then
        span []
            [ text separator
            , a
                [ href project.src_link
                , target "_blank"
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
