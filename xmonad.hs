import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Layout.NoBorders
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.Cursor
import XMonad.Util.EZConfig(additionalKeys)
import XMonad.Actions.Volume
import System.IO


main = do
    xmproc <- spawnPipe "/usr/bin/xmobar /home/joseph/.xmobarrc"
    xmonad $ defaultConfig
        { manageHook = manageDocks <+> manageHook defaultConfig
        , layoutHook = smartBorders $ avoidStruts  $  layoutHook defaultConfig
        , logHook = dynamicLogWithPP xmobarPP
                        { ppOutput = hPutStrLn xmproc
                        , ppTitle = xmobarColor "green" "" . shorten 50
                        }

        , borderWidth        = 1
        , normalBorderColor  = "#606060"
        , focusedBorderColor = "#cd8b00"
        , modMask            = mod4Mask  -- rebind mod to Windows key
        --, mod1               = modMask
        } `additionalKeys`
        [ ((mod1Mask, xK_c), kill)  -- kill without shift
        , ((mod4Mask .|. shiftMask, xK_z), spawn "xscreensaver-command -lock")
        ---, ((mod3Mask, xK_Return), spawn $ XMonad.terminal conf)
        , ((mod4Mask, xK_b), spawn "vimb")
        --, ((mod4Mask, xK_e), spawn "emacs") -- use a server instead
        , ((mod4Mask, xK_n), spawn "gnome-control-center")
        , ((controlMask, xK_Print), spawn "sleep 0.2; scrot -s")
        , ((0, xK_Print), spawn "scrot")
        ]

