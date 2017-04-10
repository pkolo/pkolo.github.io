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
    { results : List SearchResult
    }


initialModel : Model
initialModel =
    { results = decodeResults Data.json
    }


type alias SearchResult =
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


responseDecoder : Decoder (List SearchResult)
responseDecoder =
    Json.Decode.Pipeline.decode identity
        |> required "projects" (list searchResultDecoder)


searchResultDecoder : Decoder SearchResult
searchResultDecoder =
    Json.Decode.Pipeline.decode SearchResult
        |> required "id" int
        |> required "name" string
        |> required "timeline" string
        |> required "status" string
        |> required "categories" string
        |> required "technologies" string
        |> required "link" string
        |> required "src_link" string
        |> required "description" string


decodeResults : String -> List SearchResult
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
            , span [] [ text "Like GitHub, but for Elm things." ]
            ]
        , ul []
            (List.map viewSearchResult model.results)
        , p []
            [ text (toString model) ]
        ]


viewSearchResult : SearchResult -> Html Msg
viewSearchResult result =
    li []
        [ text "Anything" ]


type Msg
    = SetQuery String



-- update


update : Msg -> Model -> Model
update msg model =
    initialModel
