module Main where

import Prelude

import Effect (Effect)
import Effect.Console (log)
import Exercise1.TypeClass as TypeClassExercise
import Exercise2.Functor as FunctorExercise
import Exercise3.Applicative as ApplicativeExercise
import Exercise4.Monad as MonadExercise

main :: Effect Unit
main = do
  log "# Executing TypeClass Exercise\n"
  log TypeClassExercise.execute
  log "\n# Executing Functor Exercise:\n"
  log FunctorExercise.executeBefore
  log FunctorExercise.executeAfter
  log "\n# Executing Applicative Exercise:\n"
  log ApplicativeExercise.executeBefore
  log ApplicativeExercise.executeAfter
  log "\n# Executing Monad Exercise:\n"
  log MonadExercise.executeBefore
  log MonadExercise.executeAfter

