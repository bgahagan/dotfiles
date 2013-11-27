
import XMonad
import XMonad.Config.Gnome
import XMonad.Hooks.ManageDocks
import XMonad.Util.EZConfig
import XMonad.Layout.Gaps
import Data.List

myManageHook = composeAll . concat $
   [ [ className =? "Firefox-bin" --> doShift "6:ff" ]
   , [ className =? "Firefox" --> doShift "6:ff" ]
   , [(className =? "Firefox" <&&> resource =? "Dialog") --> doFloat]
   , [ className =? "Emacs" --> doShift "2:emacs" ]
   , [ className =? "Emacsclient" --> doShift "2:emacs" ]
   , [ className =? "Unity-2d-panel" --> doIgnore ]
   , [ className =? "Unity-2d-launcher" --> doIgnore ]
   ]

myLayouts = gaps [(U, 24)] $ layoutHook gnomeConfig

main = xmonad $ gnomeConfig
         { workspaces = ["1:chrome","2:emacs","3:console","4:server","5:mail","6:ff","7","8","9","0","-","="]
         , manageHook = myManageHook <+> manageHook gnomeConfig
         , modMask = mod4Mask
         , layoutHook = myLayouts
         , terminal = "urxvt"
         , focusFollowsMouse = False
         }
         `additionalKeysP` [ ("M-S-q", spawn "gnome-session-quit --power-off") ]

