module Main exposing (..)

{-| THIS FILE IS NOT PART OF THE WORKSHOP! It is only to verify that you
have everything set up properly.
-}

import Auth
import Html exposing (..)
import Html.Attributes exposing (..)
import Http
import Json.Decode
import Browser


main : Program () Model Msg
main =
    Browser.document
        { view = view
        , update = update
        , init = \_ -> ( initialModel, searchFeed )
        , subscriptions = \_ -> Sub.none
        }


initialModel :  Model
initialModel =
    { status = "Verifying setup..."
    }


type alias Model =
    { status : String }


searchFeed : Cmd Msg
searchFeed =
    let
        url =
            "https://api.github.com/search/repositories?q=test"
        decoder = Json.Decode.succeed ()
        req =
            { method = "GET"
            , headers = [ Http.header "Authorization" <| "token " ++ Auth.token ]
            , url = url
            , body = Http.emptyBody
            , expect = Http.expectJson Response decoder
            , timeout = Nothing
            , tracker = Nothing
            }
    in
        Http.request req


view : Model -> Browser.Document Msg
view model =
    { title = "Big Test"
    , body = [
        div [ class "content" ]
            [ header [] [ h1 [] [ text "Elm Workshop" ] ]
            , div
                [ style "font-size" "48px"
                , style "text-align" "center"
                , style "padding" "48px"
                ]
                [ text model.status ]
            ]]
    }


type Msg
    = Response (Result Http.Error ())


update : Msg -> Model -> ( Model, Cmd Msg )
update msg _ =
    case msg of
        Response (Ok ()) ->
            ( { status = "You're all set!" }, Cmd.none )

        Response (Err err) ->
            let
                status =
                    case err of
                        Http.Timeout ->
                            "Timed out trying to contact GitHub. Check your Internet connection?"

                        Http.NetworkError ->
                            "Network error. Check your Internet connection?"

                        Http.BadUrl url ->
                            "Invalid test URL: " ++ url

                        Http.BadBody bbMsg ->
                            "Invalid Response palyload: " ++ bbMsg

                        Http.BadStatus st ->
                            case st of
                                401 ->
                                    "Auth.elm does not have a valid token. :( Try recreating Auth.elm by following the steps in the README under the section “Create a GitHub Personal Access Token”."

                                _ ->
                                    "GitHub's Search API returned an error: " ++ String.fromInt st
            in
            ( { status = status }, Cmd.none )
