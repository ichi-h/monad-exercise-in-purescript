module Exercise3.Applicative (executeBefore, executeAfter) where

import Prelude

import Data.Maybe (Maybe(..))
import Data.Expanded.String ((<\>))

-- # Before

addTwoMaybe :: Maybe Int -> Maybe Int -> Maybe Int
addTwoMaybe Nothing _ = Nothing
addTwoMaybe _ Nothing = Nothing
addTwoMaybe (Just x) (Just y) = Just (x + y)

-- addTwoMaybe mx my = case mx of
--   Nothing -> Nothing
--   Just x -> case my of
--     Nothing -> Nothing
--     Just y -> Just (x + y)

executeBefore :: String
executeBefore =
  "addTwoMaybe (Just 3) (Just 5): " <> show (addTwoMaybe (Just 3) (Just 5))
  <\> "addTwoMaybe (Just 3) Nothing: " <> show (addTwoMaybe (Just 3) Nothing)
  <\> "addTwoMaybe Nothing (Just 5): " <> show (addTwoMaybe Nothing (Just 5))

-- # After

-- `<$>` means `map` in infix notation.

-- ```purs
-- instance applyMaybe :: Apply Maybe where
--   apply (Just fn) x = fn <$> x
--   apply Nothing   _ = Nothing
-- 
-- instance applicativeMaybe :: Applicative Maybe where
--   pure = Just
-- ```
-- 
-- see: https://github.com/purescript/purescript-maybe/blob/v3.0.0/src/Data/Maybe.purs#L37-L93

-- `<*>` means `apply` in infix notation.

addTwoMaybe' :: Maybe Int -> Maybe Int -> Maybe Int
addTwoMaybe' mx my = (\x y -> x + y) <$> mx <*> my

addTwo :: forall f. Applicative f => f Int -> f Int -> f Int
addTwo fx fy = (\x y -> x + y) <$> fx <*> fy

executeAfter :: String
executeAfter =
  let
    maybeValue1 = Just 3 :: Maybe Int
    maybeValue2 = Just 5 :: Maybe Int
  in
    "addTwoMaybe (Just 3) (Just 5): " <> show (addTwoMaybe' maybeValue1 maybeValue2)
    <\> "addTwoMaybe (Just 3) Nothing: " <> show (addTwoMaybe' maybeValue1 Nothing)
    <\> "addTwoMaybe Nothing (Just 5): " <> show (addTwoMaybe' Nothing maybeValue2)
    <\> "addTwo (Just 3) (Just 5): " <> show (addTwo maybeValue1 maybeValue2)
    <\> "addTwo Nothing (Just 5): " <> show (addTwo Nothing maybeValue2)
