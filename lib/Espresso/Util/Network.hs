{-# LANGUAGE OverloadedStrings #-}

module Espresso.Util.Network
  ( curl
  , gitClone
  , curl'
  , gitClone'
  ) where

import qualified Data.ByteString.Lazy as BL
import Network.HTTP.Simple (Request, getResponseBody, httpLBS)

import System.Environment (getEnv)
import System.Process (callCommand)

curl' :: Request -> FilePath -> IO ()
curl' link path =
  httpLBS link >>= \r ->
    getEnv "HOME" >>= \home -> BL.writeFile (home ++ path) $ getResponseBody r

curl :: Request -> FilePath -> IO ()
curl link path = httpLBS link >>= \r -> BL.writeFile path $ getResponseBody r

gitClone' :: String -> FilePath -> IO ()
gitClone' repo path =
  getEnv "HOME" >>= \home ->
    callCommand $ "git clone " ++ repo ++ " " ++ home ++ path

gitClone :: String -> FilePath -> IO ()
gitClone repo path = callCommand $ "git clone " ++ repo ++ " " ++ path
