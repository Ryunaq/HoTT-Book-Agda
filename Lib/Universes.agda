module Lib.Universes where

open import Agda.Primitive public
  renaming (
            Set to Universe
          ; lsuc to infix 1 _âº
          ; SetÏ to ð¤Ï)

variable
  ð¾ ð¿ ð : Level

ð° : (â : Level) â Universe (â âº)
ð° â = Universe â

ð°â = Universe lzero
ð°â = Universe (lzero âº)
ð°â = Universe (lzero âº âº)
ð°â = Universe (lzero âº âº âº)

_âºâº : (â : Level) â Level
â âºâº = (â âº) âº

universe-of : {â : Level} (X : ð° â) â Level
universe-of {â} X = â

