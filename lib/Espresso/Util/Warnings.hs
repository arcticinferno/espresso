{-# LANGUAGE OverloadedStrings #-}

module Espresso.Util.Warnings
  ( sendWarning
  , WarnOpt(..)
  , Program
  ) where

import Data.Text (Text, unpack)

type Program = Text

data WarnOpt
  = Warning
  | Dependency

sendWarning :: WarnOpt -> Program -> Text -> IO ()
sendWarning Warning prog msg =
  putStrLn $ unpack $ "WARNING: " <> prog <> " ~$ " <> msg
sendWarning Dependency prog msg =
  putStrLn $ unpack $ "INFO: " <> prog <> " depends on " <> ("`" <> msg <> "`")
