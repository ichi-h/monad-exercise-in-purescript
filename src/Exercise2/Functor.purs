module Exercise2.Functor (executeBefore, executeAfter) where

import Prelude

import Data.Either (Either(..))
import Data.Maybe (Maybe(..))
import Data.Expanded.String ((<\>))

-- # Before

addOneMaybe :: Maybe Int -> Maybe Int
addOneMaybe Nothing = Nothing
addOneMaybe (Just x) = Just (x + 1)

-- addOneMaybe v = case v of
--   Nothing -> Nothing
--   Just x -> Just (x + 1)

addOneEither :: Either String Int -> Either String Int
addOneEither (Left err) = Left err
addOneEither (Right x) = Right (x + 1)

-- addOneEither v = case v of
--   Left err -> Left err
--   Right x -> Right (x + 1)

executeBefore :: String
executeBefore =
  "addOneMaybe (Just 5)': " <> show (addOneMaybe (Just 5))
  <\> "addOneMaybe Nothing: " <> show (addOneMaybe Nothing)
  <\> "addOneEither (Right 10)': " <> show (addOneEither (Right 10))
  <\> "addOneEither (Left \"Error\"): " <> show (addOneEither (Left "Error"))

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

-- The following is actually implemented using derive, but if you want to implement it explicitly, do it like this:
-- 
-- ```purs
-- instance functorEither :: Functor (Either e) where
--   map fn (Right x) = Right (fn x)
--   map _  (Left err) = Left err
-- ```
-- 
-- see: https://github.com/purescript/purescript-either/blob/v6.1.0/src/Data/Either.purs#L31

addOneEither' :: Either String Int -> Either String Int
addOneEither' = map (\x -> x + 1)

addOne :: forall f. Functor f => f Int -> f Int
addOne = map (_ + 1)

executeAfter :: String
executeAfter =
  let
    maybeValue = Just 5 :: Maybe Int
    rightValue = Right 10 :: Either String Int
    leftValue = Left "Error" :: Either String Int
  in
    "addOneMaybe' (Just 5): " <> show (addOneMaybe' maybeValue)
    <\> "addOneMaybe' Nothing: " <> show (addOneMaybe' Nothing)
    <\> "addOneEither' (Right 10): " <> show (addOneEither' rightValue)
    <\> "addOneEither' (Left \"Error\"): " <> show (addOneEither' leftValue)
    <\> "addOne (Just 5): " <> show (addOne maybeValue)
    <\> "addOne Nothing: " <> show (addOne Nothing)
    <\> "addOne (Right 10): " <> show (addOne rightValue)
    <\> "addOne (Left \"Error\"): " <> show (addOne leftValue)
