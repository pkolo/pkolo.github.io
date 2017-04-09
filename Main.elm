module Hello exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)


main : Html msg
main =
    body []
        [ h1 []
            [ text ("Patrick Kolodgy") ]
        , p []
            [ text ("Web developer / Musician / Audio engineer / Podcaster") ]
        , p []
            [ a
                [ href "https://github.com/pkolo"
                , target "_blank"
                ]
                [ text ("github") ]
            , text (" / ")
            , a
                [ href "https://www.linkedin.com/in/pkolodgy/"
                , target "_blank"
                ]
                [ text ("linkedin") ]
            ]
        , h3 []
            [ text ("Active") ]
        , ul []
            [ li []
                [ a
                    [ href "https://list-o-matic.herokuapp.com/"
                    , target "_blank"
                    ]
                    [ text ("link") ]
                , text (" - A web app that lets users log in and contribute to ranked lists of albums. The very-relatable")
                ]
            , li []
                [ a
                    [ href "https://soundcloud.com/sounds-park"
                    , target "_blank"
                    ]
                    [ text ("Sounds Park") ]
                , text (" - Intermittently updated with songs and remixes of my creation.")
                ]
            ]
        ]
