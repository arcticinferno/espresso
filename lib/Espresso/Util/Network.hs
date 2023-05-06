{-# LANGUAGE OverloadedStrings #-}

module Espresso.Util.Network
  ( curl
  , gitClone
  , curl'
  , gitClone'
  ) where

import Network.HTTP.Client
import Network.HTTP.Simple
import Network.URI

import Control.Monad ((>=>))

import qualified Data.ByteString.Char8 as B8

import System.Environment (getEnv)
import System.Process (callCommand)

curl' :: String -> FilePath -> IO ()
curl' url path =
  getEnv "HOME" >>= \home ->
    parseRequest url >>= \lin ->
      httpBS lin >>= \d -> B8.writeFile (home ++ path) $ getResponseBody d

curl :: String -> FilePath -> IO ()
curl url path =
  parseRequest url >>= \lin ->
    httpBS lin >>= \d -> B8.writeFile path $ getResponseBody d

gitClone' :: String -> FilePath -> IO ()
gitClone' repo path =
  getEnv "HOME" >>= \home ->
    callCommand $ "git clone " ++ repo ++ " " ++ home ++ path

gitClone :: String -> FilePath -> IO ()
gitClone repo path = callCommand $ "git clone " ++ repo ++ " " ++ path
