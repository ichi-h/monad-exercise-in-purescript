module Exercise2.Functor (executeBefore, executeAfter) where

import Prelude

import Data.Maybe (Maybe(..))
import Data.Expanded.String ((<\>))

-- # Before

addOneMaybe :: Maybe Int -> Maybe Int
addOneMaybe Nothing = Nothing
addOneMaybe (Just x) = Just (x + 1)

-- addOneMaybe v = case v of
--   Nothing -> Nothing
--   Just x -> Just (x + 1)

executeBefore :: String
executeBefore =
  "addOneMaybe (Just 5)': " <> show (addOneMaybe (Just 5))
  <\> "addOneMaybe Nothing: " <> show (addOneMaybe Nothing)

-- # After

-- ```purs
-- instance functorMaybe :: Functor Maybe where
--   map fn (Just x) = Just (fn x)
--   map _  _        = Nothing
-- ```
-- 
-- see: https://github.com/purescript/purescript-maybe/blob/v3.0.0/src/Data/Maybe.purs#L33

addOneMaybe' :: Maybe Int -> Maybe Int
addOneMaybe' = map (\x -> x + 1)

addOne :: forall f. Functor f => f Int -> f Int
addOne = map (_ + 1)

executeAfter :: String
executeAfter =
  let
    maybeValue = Just 5 :: Maybe Int
  in
    "addOneMaybe' (Just 5): " <> show (addOneMaybe' maybeValue)
    <\> "addOneMaybe' Nothing: " <> show (addOneMaybe' Nothing)
    <\> "addOne (Just 5): " <> show (addOne maybeValue)
    <\> "addOne Nothing: " <> show (addOne Nothing)
