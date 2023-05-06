{-# LANGUAGE OverloadedStrings #-}

module Espresso.Types where

import Control.Applicative ((<|>))
import qualified Data.ByteString.Char8 as BS
import Data.Text (Text)
import Data.Yaml
-- Individual Program Types should be constructed with the following fields:
-- `warns`: a list of warning messages
-- `depends`: a list of dependencies
-- `git`: git url/destination(s)
-- `curl`: url/destination(s)
-- All should be `Maybe`
