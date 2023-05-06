{-# LANGUAGE OverloadedStrings #-}

module Espresso.Programs.Alacritty
  ( execAlacritty
  , AlacrittyConf(..)
  ) where

import Data.Aeson
import Data.Text (Text, unpack)
import Espresso.Types
import Espresso.Util.Network
import Network.HTTP.Client (Request)

data AlacrittyConf = AlacrittyConf
  { git :: Maybe [(Text, Text)]
  , warns :: Maybe [Text]
  , curls :: Maybe [(Text, Text)]
  , depends :: Maybe [Text]
  } deriving (Show)

instance FromJSON AlacrittyConf where
  parseJSON (Object v) =
    AlacrittyConf <$> v .:? "git" <*> v .:? "warns" <*> v .:? "curl" <*>
    v .:? "depends"
  parseJSON _ = fail "Expected an object for `alacritty`"

aSubClone :: [(Text, Text)] -> IO ()
aSubClone = mapM_ (\(name, url) -> gitClone (unpack name) (unpack url))

aSubCurl :: [(Request, Text)] -> IO ()
aSubCurl = mapM_ (\(name, url) -> curl name (unpack url))

execAlacritty :: AlacrittyConf -> IO ()
execAlacritty (AlacrittyConf Nothing Nothing Nothing Nothing) = return ()
execAlacritty (AlacrittyConf Nothing _ Nothing _) = return ()
execAlacritty (AlacrittyConf (Just gits) Nothing Nothing Nothing) =
  aSubClone gits
execAlacritty (AlacrittyConf (Just gits) Nothing (Just curlt) Nothing) =
  aSubCurl curlt >> aSubClone gits
