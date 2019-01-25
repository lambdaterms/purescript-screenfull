module Web.Screenfull where

import Prelude

import Control.Promise (Promise, toAff)
import Data.Maybe (Maybe)
import Data.Nullable (Nullable, toMaybe)
import Effect (Effect)
import Effect.Aff (Aff)
import Effect.Class (liftEffect)
import Web.HTML (HTMLElement)

-- | Methods

foreign import exit ∷ Effect (Promise Unit)

exitAff ∷ Aff Unit
exitAff = liftEffect request >>= toAff

-- | Returns effect which unregisters passed handler
foreign import onChange ∷ Effect Unit → Effect (Effect Unit)

foreign import request ∷ Effect (Promise Unit)

requestAff ∷ Aff Unit
requestAff = liftEffect request >>= toAff

foreign import toggle ∷ Effect (Promise Unit)

toggleAff ∷ Aff Unit
toggleAff = liftEffect toggle >>= toAff

-- | Properties

foreign import elementImpl ∷ Effect (Nullable HTMLElement)

element ∷ Effect (Maybe HTMLElement)
element = toMaybe <$> elementImpl

foreign import enabled ∷ Effect Boolean

foreign import isFullScreen ∷ Effect Boolean

