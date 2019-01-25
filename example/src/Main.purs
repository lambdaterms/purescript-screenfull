module Main where

import Prelude

import Control.Monad.Maybe.Trans (MaybeT(..), runMaybeT)
import Control.Monad.Trans.Class (lift)
import Data.Maybe (Maybe(..))
import Effect (Effect)
import Effect.Ref (new, read, write) as Ref
import Web.DOM.Element (setAttribute)
import Web.DOM.Element (toEventTarget, toNode) as Element
import Web.DOM.Node (setTextContent, toEventTarget)
import Web.DOM.NonElementParentNode (getElementById)
import Web.Event.EventTarget (addEventListener, eventListener)
import Web.HTML (window) as HTML
import Web.HTML.Event.EventTypes (click)
import Web.HTML.HTMLDocument (toNonElementParentNode) as HTMLDocument
import Web.HTML.Window (document) as Window
import Web.Screenfull (enabled, exit, isFullScreen, onChange, request, toggle) as Screenfull


main :: Effect Unit
main = do
  doc ← HTML.window >>= Window.document <#> HTMLDocument.toNonElementParentNode
  let
    getElementById' s = (MaybeT $ getElementById s doc)
    getNodeById s =  Element.toNode <$> getElementById' s

  void $runMaybeT $ do
    isFullScreenNode ← getNodeById "isFullScreen"
    fsEnabledNode ← getNodeById "fsEnabled"

    let
      updateValues = do
        fsEnabled ← Screenfull.enabled
        setTextContent (show fsEnabled) fsEnabledNode
        isFullScreen ← Screenfull.isFullScreen
        setTextContent (show isFullScreen) isFullScreenNode

    lift updateValues

    requestFsButton ← getNodeById "request"
    l ← lift $ eventListener (const $ Screenfull.request)
    lift $ addEventListener click l false (toEventTarget requestFsButton)

    exitFsButton ← getNodeById "exit"
    e ← lift $ eventListener (const $ Screenfull.exit)
    lift $ addEventListener click e false (toEventTarget exitFsButton)

    toggleFsButton ← getNodeById "toggle"
    t ← lift $ eventListener (const $ Screenfull.toggle)
    lift $ addEventListener click t false (toEventTarget toggleFsButton)


    unregisterRef ← lift $ Ref.new Nothing
    onChangeButton ← getElementById' "onChange"

    let
      toggleRegistration = do
        unregister ← Ref.read unregisterRef
        case unregister of
          Nothing → do
            Screenfull.onChange updateValues >>= Just >>> flip Ref.write unregisterRef
            updateValues
            setAttribute "value" "unregister" onChangeButton
          Just u' → do
            u'
            Ref.write Nothing unregisterRef
            setTextContent "----" fsEnabledNode
            setTextContent "----" isFullScreenNode
            setAttribute "value" "register" onChangeButton

    lift toggleRegistration
    c ← lift $ eventListener $ const $ toggleRegistration
    -- void $ lift $ Screenfull.onChange (log "CHANGED")
    lift $ addEventListener click c false (Element.toEventTarget onChangeButton)

