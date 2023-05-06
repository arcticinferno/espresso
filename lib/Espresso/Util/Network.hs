{-# LANGUAGE OverloadedStrings #-}

module Espresso.Util.Network
  ( curl
  , gitClone
  , curl'
  , gitClone'
  ) where

import Network.HTTP.Conduit

import qualified Data.ByteString.Char8 as B8

import System.Environment (getEnv)
import System.Process (callCommand)

curl' :: String -> FilePath -> IO ()
curl' url path = undefined

curl :: String -> FilePath -> IO ()
curl url path = undefined

-- I need to figure out a way to download files with `curl`, but without using `Request`
gitClone' :: String -> FilePath -> IO ()
gitClone' repo path =
  getEnv "HOME" >>= \home ->
    callCommand $ "git clone " ++ repo ++ " " ++ home ++ path

gitClone :: String -> FilePath -> IO ()
gitClone repo path = callCommand $ "git clone " ++ repo ++ " " ++ path
