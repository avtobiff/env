import XMonad
import qualified XMonad.StackSet as W
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Layout.Fullscreen
import XMonad.Layout.NoBorders
import XMonad.Layout.NoFrillsDecoration
import XMonad.Layout.StackTile
import XMonad.Layout.ThreeColumns
import XMonad.Util.EZConfig(additionalKeys)
import XMonad.Util.Run(spawnPipe)
import System.IO

main = do
    -- http://weather.rap.ucar.edu/surface/stations.txt
    xmproc <- spawnPipe "/usr/bin/xmobar /home/avtobiff/.xmobarrc"
    xmonad $ defaultConfig {
            normalBorderColor = "#333333",
            focusedBorderColor = "#ff3f3f",
            manageHook = manageDocks <+> manageHook defaultConfig,
            layoutHook = myLayout,
            logHook = dynamicLogWithPP xmobarPP {
                    ppOutput = hPutStrLn xmproc,
                    ppTitle = xmobarColor "grey" "" . shorten 50,
                    ppCurrent = xmobarColor "grey" ""
                    }
             } `additionalKeys` myKeys

myLayout = avoidStruts (
    tiled |||
    Mirror tiled |||
    Full) |||
    noBorders (fullscreenFull Full)
  where
    tiled = Tall 1 (3/100) (1/2)

myWorkspaces = [show n | n <- [1..9]]

--myLayout = StackTile 1 (3/100) (1/2) ||| noBorders Full
--myLayoutHook = avoidStruts $ noFrillsDeco shrinkText defaultTheme $ layoutHook myLayout

myKeys = [((mod1Mask .|. shiftMask, xK_l), spawn "xscreensaver-command -lock"),
          ((mod1Mask, xK_p), spawn "dmenu_run -b -nb black -nf grey -sb \"#aa0000\"")
         ]
         ++
         [((m .|. mod1Mask, k), windows $ f i)
          | (i, k) <- zip myWorkspaces [xK_1..xK_9],
            (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]
