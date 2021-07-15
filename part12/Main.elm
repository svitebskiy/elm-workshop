module Main exposing (main)

import ElmHub
import Browser


main : Program () ElmHub.Model ElmHub.Msg
main =
    Browser.element
        { view = ElmHub.view
        , update = ElmHub.update
        , init = \_ -> ElmHub.init
        , subscriptions = ElmHub.subscriptions
        }
