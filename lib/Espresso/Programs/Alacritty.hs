{-# LANGUAGE OverloadedStrings #-}

module Espresso.Programs.Alacritty
  ( execAlacritty
  , AlacrittyConf(..)
  ) where

import Data.Aeson
import Data.Text (Text, unpack)
import Espresso.Types
import Espresso.Util.Network

data AlacrittyConf = AlacrittyConf
  { git :: Maybe [(Text, Text)]
  , warns :: Maybe [Text]
  , curl :: Maybe [(Text, Text)]
  , depends :: Maybe [Text]
  } deriving (Show, Eq)

instance FromJSON AlacrittyConf where
  parseJSON (Object v) =
    AlacrittyConf <$> v .:? "git" <*> v .:? "warns" <*> v .:? "curl" <*>
    v .:? "depends"
  parseJSON _ = fail "Expected an object for `alacritty`"

aSubClone :: [(Text, Text)] -> IO ()
aSubClone gits =
  mapM_ (\(name, url) -> gitClone (unpack name) (unpack url)) gits

execAlacritty :: AlacrittyConf -> IO ()
execAlacritty (AlacrittyConf Nothing Nothing Nothing Nothing) = return ()
execAlacritty (AlacrittyConf Nothing _ Nothing _) = return ()
execAlacritty (AlacrittyConf (Just gits) Nothing Nothing Nothing) =
  aSubClone gits
