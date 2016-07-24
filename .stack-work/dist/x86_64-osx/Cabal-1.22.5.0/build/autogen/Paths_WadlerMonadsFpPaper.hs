module Paths_WadlerMonadsFpPaper (
    version,
    getBinDir, getLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where

import qualified Control.Exception as Exception
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude

catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
catchIO = Exception.catch

version :: Version
version = Version [0,1,0,0] []
bindir, libdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "/Users/m.cheikhna/Documents/repos/mine/WadlerMonadsFpPaper/.stack-work/install/x86_64-osx/lts-6.8/7.10.3/bin"
libdir     = "/Users/m.cheikhna/Documents/repos/mine/WadlerMonadsFpPaper/.stack-work/install/x86_64-osx/lts-6.8/7.10.3/lib/x86_64-osx-ghc-7.10.3/WadlerMonadsFpPaper-0.1.0.0-AwRWBoLBPWuEvu14iktgQL"
datadir    = "/Users/m.cheikhna/Documents/repos/mine/WadlerMonadsFpPaper/.stack-work/install/x86_64-osx/lts-6.8/7.10.3/share/x86_64-osx-ghc-7.10.3/WadlerMonadsFpPaper-0.1.0.0"
libexecdir = "/Users/m.cheikhna/Documents/repos/mine/WadlerMonadsFpPaper/.stack-work/install/x86_64-osx/lts-6.8/7.10.3/libexec"
sysconfdir = "/Users/m.cheikhna/Documents/repos/mine/WadlerMonadsFpPaper/.stack-work/install/x86_64-osx/lts-6.8/7.10.3/etc"

getBinDir, getLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "WadlerMonadsFpPaper_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "WadlerMonadsFpPaper_libdir") (\_ -> return libdir)
getDataDir = catchIO (getEnv "WadlerMonadsFpPaper_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "WadlerMonadsFpPaper_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "WadlerMonadsFpPaper_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
