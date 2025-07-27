module Data.Expanded.String where

import Prelude

brAppend :: String -> String -> String
brAppend a b = a <> "\n" <> b

infixr 5 brAppend as <\>

