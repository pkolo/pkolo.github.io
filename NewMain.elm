module Main exposing (..)

import String exposing (join)
import Html exposing (..)
import Json.Decode exposing (..)
import Json.Decode.Pipeline exposing (..)
import Element exposing (..)
import Element.Attributes exposing (..)
import Element.Events exposing (onClick)
import NewStyle exposing (..)
import Data


main : Program Never Model Msg
main =
    program
        { init = init
        , update = update
        , view = view
        , subscriptions = \_ -> Sub.none
        }



-- model


type alias Model =
    { bio : String
    , projects : List Project
    , filterBy : String
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


initialModel : Model
initialModel =
    let
        result =
            decodeResult Data.json
    in
        { bio = result.bio
        , projects = result.projects
        , filterBy = ""
        }


init : ( Model, Cmd Msg )
init =
    ( initialModel, Cmd.none )



-- UPDATE


type Msg
    = Clear
    | UpdateFilter String


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Clear ->
            ( initialModel, Cmd.none )

        UpdateFilter newFilter ->
            ( { model | filterBy = newFilter }, Cmd.none )



-- VIEW


view : Model -> Html Msg
view model =
    Element.layout stylesheet <|
        column Main
            []
            [ header
            , content model
            ]


header =
    column None
        [ padding 20 ]
        [ el Title [] (Element.text "Patrick Kolodgy")
        , navBar
        ]


navBar =
    row None
        [ spacing 15 ]
        [ el None [] (Element.text "Brooklyn, NY")
        , el None [] (Element.text "pkolodgy at gmail")
        , newTab "http://github.com/pkolo" <| el None [] (Element.text "github")
        , el None [] (Element.text "linkedin")
        ]


content model =
    row None
        [ spacing 40 ]
        [ sideBar model
        , projectList model.projects
        ]


sideBar model =
    column None
        [ width (px 180) ]
        [ el None [] (Element.text model.filterBy) ]


projectList projects =
    column None
        [ spacing 25 ]
        (List.map project projects)


project p =
    column None
        []
        [ projectMeta p
        , el None [] (Element.text p.description)
        , projectTagList "Technologies" p.technologies
        , projectTagList "Categories" p.categories
        ]


projectMeta p =
    row None
        [ spacing 20 ]
        [ el None [] (Element.text p.name)
        , el None [] (Element.text p.status)
        , el None [] (Element.text "link")
        , el None [] (Element.text "src")
        ]


projectTagList title tagList =
    row None
        [ spacing 10 ]
        (List.map tagLink tagList)


tagLink tag =
    el None [ onClick (UpdateFilter tag) ] (Element.text tag)
