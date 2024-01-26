module Main where

import Control.Concurrent (forkIO, threadDelay)
import Control.Monad (forever)
import Control.Monad.IO.Class (MonadIO)
import Control.Monad.Logger (LoggingT, runStdoutLoggingT)

{-# NOINLINE leaky #-}
leaky :: MonadIO m => LoggingT m ()
leaky = forever $ pure ()

main :: IO ()
main = do
  putStrLn "Starting repro"
  _ <- forkIO $ runStdoutLoggingT leaky
  threadDelay (5 * 1000000)
  putStrLn "Quitting"
