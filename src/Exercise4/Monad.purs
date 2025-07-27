module Exercise4.Monad (executeBefore, executeAfter) where

import Prelude

import Data.Maybe (Maybe(..))
import Data.Expanded.String ((<\>))

-- # Before

safeDivide :: Int -> Int -> Maybe Int
safeDivide _ 0 = Nothing
safeDivide x y = Just (x / y)

complexChain :: Maybe Int -> Maybe Int
complexChain Nothing = Nothing
complexChain (Just x) =
  case safeDivide x 2 of
    Nothing -> Nothing
    Just y ->
      case safeDivide y 3 of
        Nothing -> Nothing
        Just z -> Just (z + 1)

executeBefore :: String
executeBefore =
  "complexChain (Just 24): " <> show (complexChain (Just 24))
  <\> "complexChain (Just 0): " <> show (complexChain (Just 0))
  <\> "complexChain Nothing: " <> show (complexChain Nothing)

-- # After

-- ```purs
-- instance bindMaybe :: Bind Maybe where
--   bind (Just x) k = k x
--   bind Nothing  _ = Nothing
-- 
-- instance monadMaybe :: Monad Maybe
-- ```
-- 
-- see: https://github.com/purescript/purescript-maybe/blob/v3.0.0/src/Data/Maybe.purs#L120-L146

-- `>>=` means `bind` in infix notation.

complexChain' :: Maybe Int -> Maybe Int
complexChain' mx =
  mx >>= \x ->
    safeDivide x 2 >>= \y ->
      safeDivide y 3 >>= \z ->
        pure (z + 1)

complexChain'' :: Maybe Int -> Maybe Int
complexChain'' mx = do
  x <- mx
  y <- safeDivide x 2
  z <- safeDivide y 3
  pure (z + 1)

executeAfter :: String
executeAfter =
  "complexChain' (Just 24): " <> show (complexChain' (Just 24))
  <\> "complexChain' (Just 0): " <> show (complexChain' (Just 0))
  <\> "complexChain' Nothing: " <> show (complexChain' Nothing)
  <\> "complexChain'' (Just 24): " <> show (complexChain'' (Just 24))
  <\> "complexChain'' (Just 0): " <> show (complexChain'' (Just 0))
  <\> "complexChain'' Nothing: " <> show (complexChain'' Nothing)
