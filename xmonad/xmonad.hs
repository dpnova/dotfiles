import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.SetWMName
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import XMonad.Config.Desktop
import XMonad.Hooks.ManageHelpers
import Graphics.X11.ExtraTypes.XF86
import System.IO
import XMonad.Layout.Tabbed
import XMonad.Layout.Grid
import XMonad.Layout.Spacing
import XMonad.Layout.ShowWName
import XMonad.Layout.Reflect
import XMonad.Layout.OneBig
import XMonad.Actions.CycleWindows
import XMonad.Layout.Magnifier
import qualified Data.Map as M
import XMonad.Core as XMonad hiding
    (workspaces,manageHook,keys,logHook,startupHook,borderWidth,mouseBindings
    ,layoutHook,modMask,terminal,normalBorderColor,focusedBorderColor,focusFollowsMouse
    ,handleEventHook,clickJustFocuses)
import qualified XMonad.Core as XMonad
    (workspaces,manageHook,keys,logHook,startupHook,borderWidth,mouseBindings
    ,layoutHook,modMask,terminal,normalBorderColor,focusedBorderColor,focusFollowsMouse
    ,handleEventHook,clickJustFocuses)
import XMonad.Layout
import XMonad.Operations
import XMonad.ManageHook
import qualified XMonad.StackSet as W
import Data.Bits ((.|.))
import Data.Monoid
import qualified Data.Map as M
import System.Exit
import Graphics.X11.Xlib
import Graphics.X11.Xlib.Extras

import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.FadeInactive


curLayout :: X String
curLayout = gets windowset >>= return . description . W.layout . W.workspace . W.current

myWorkspaces = ["1:dev","2:dev-extra","3:comms","4:monitoring","5:email","6:casting","7","8:tunes","9:hide"]
myXmonadBar = "dzen2 -e 'button2=;' -dock -x '0' -y '0' -h '24' -w '1960' -ta 'l' -fg '#FFFFFF' -bg '#1B1D1E'"
myStatusBar = "conky -c /home/dpn/.xmonad/.conky_dzen | dzen2 -e 'button2=;' -x '1960' -w '600' -h '24' -ta 'r' -bg '#1B1D1E' -fg '#FFFFFF' -y '0'"
myBitmapsDir = "/home/dpn/.xmonad/dzen2"

myLogHook :: Handle -> X ()
myLogHook h = dynamicLogWithPP $ defaultPP
    {
        ppCurrent           =   dzenColor "#ebac54" "#1B1D1E" . pad
      , ppVisible           =   dzenColor "white" "#1B1D1E" . pad
      , ppHidden            =   dzenColor "white" "#1B1D1E" . pad
      , ppHiddenNoWindows   =   dzenColor "#7b7b7b" "#1B1D1E" . pad
      , ppUrgent            =   dzenColor "#ff0000" "#1B1D1E" . pad
      , ppWsSep             =   " "
      , ppSep               =   "  |  "
      , ppLayout            =   dzenColor "#ebac54" "#1B1D1E" .
                                (\x -> case x of
                                    "ResizableTall"             ->      "^i(" ++ myBitmapsDir ++ "/tall.xbm)"
                                    "Mirror ResizableTall"      ->      "^i(" ++ myBitmapsDir ++ "/mtall.xbm)"
                                    "Full"                      ->      "^i(" ++ myBitmapsDir ++ "/full.xbm)"
                                    "Simple Float"              ->      "~"
                                    _                           ->      x
                                )
      , ppTitle             =   (" " ++) . dzenColor "white" "#1B1D1E" . dzenEscape
      , ppOutput            =   hPutStrLn h
    }

main = do
    -- xmproc <- spawnPipe "/usr/bin/xmobar /home/dpn/.xmonad/xmobarrc"
    xmproc <- spawnPipe myXmonadBar
    dzenRight <- spawnPipe myStatusBar
    dConfig <- dzen desktopConfig
    xmonad $ docks
        def{
            keys = myKeys,
            logHook = myLogHook xmproc  >> fadeInactiveLogHook 0xdddddddd,
            --logHook = dynamicLogWithPP xmobarPP
            --            { ppOutput = hPutStrLn xmproc, ppTitle = xmobarColor "green" "" . shorten 50 },
            borderWidth = 6,
            workspaces = myWorkspaces,
            focusFollowsMouse = True,
            focusedBorderColor = "#f92672",
	    terminal = "gnome-terminal",
            manageHook = manageDocks <+> manageHook dConfig,
            startupHook = setWMName "LG3D",
            layoutHook = showWName $
		avoidStruts (spacing 5 $ Mirror (Tall 1 (3/100) (1/2))) |||
	    	avoidStruts (spacing 5 $ Tall 1 (3/100) (1/2)) |||
		avoidStruts (spacing 5 $ reflectHoriz (Tall 1 (3/100) (1/2))) |||
		avoidStruts Full |||
		Grid |||
		-- (magnifiercz' 1.8 $ avoidStruts Grid) |||
		avoidStruts (spacing 5 $ reflectVert (Mirror (Tall 1 (3/100) (1/2)))) |||
		avoidStruts Full |||
		(magnifiercz' 1.2 $ avoidStruts Grid) |||
		avoidStruts (spacing 5 $ reflectVert (Mirror (Tall 1 (3/100) (1/2)))) |||
		OneBig (0.5) (0.5) |||
		layoutHook defaultConfig
        } `additionalKeys`
        [ ((0, xK_Scroll_Lock), spawn "gnome-screensaver-command -l")
        , ((0, xF86XK_Tools), spawn "/usr/bin/pcmanfm")
        , ((0, xF86XK_Launch5), spawn "/usr/bin/pcmanfm")
        , ((controlMask, xK_Print), spawn "sleep 0.2; shutter -f")
        , ((0, xK_Print), spawn "shutter -s")
        , ((0, xF86XK_AudioPlay), spawn "playerctl play-pause")
        , ((0, xF86XK_AudioStop), spawn "playerctl stop")
        , ((0, xF86XK_AudioPrev), spawn "playerctl previous")
        , ((0, xF86XK_AudioNext), spawn "playerctl next")
        , ((0, xF86XK_AudioRaiseVolume), spawn "pactl set-sink-volume alsa_output.pci-0000_00_1b.0.analog-stereo +5%")
        , ((0, xF86XK_AudioLowerVolume), spawn "pactl set-sink-volume alsa_output.pci-0000_00_1b.0.analog-stereo -5%")
        ]

-- | The xmonad key bindings. Add, modify or remove key bindings here.
--
-- (The comment formatting character is used when generating the manpage)
--
myKeys conf@(XConfig {XMonad.modMask = modMask}) = M.fromList $
    -- launching and killing programs
    [ ((modMask .|. shiftMask, xK_Return), spawn $ XMonad.terminal conf) -- %! Launch terminal
    , ((modMask,               xK_p     ), spawn "dmenu_run -b") -- %! Launch dmenu
    , ((modMask .|. shiftMask, xK_p     ), spawn "gmrun") -- %! Launch gmrun
    , ((modMask .|. shiftMask, xK_c     ), kill) -- %! Close the focused window

    --    , ((modMask,               xK_space ), sendMessage NextLayout) -- %! Rotate through the available layout algorithms
    , ((modMask, xK_space ), sendMessage NextLayout >> (curLayout >>= \d -> spawn $ "zenity --notification --text="++d))
    , ((modMask .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf) -- %!  Reset the layouts on the current workspace to default

    , ((modMask,               xK_n     ), refresh) -- %! Resize viewed windows to the correct size

    -- move focus up or down the window stack
    , ((modMask,               xK_Tab   ), windows W.focusDown) -- %! Move focus to the next window
    , ((modMask .|. shiftMask, xK_Tab   ), windows W.focusUp  ) -- %! Move focus to the previous window
    , ((modMask,               xK_j     ), windows W.focusDown) -- %! Move focus to the next window
    , ((modMask,               xK_k     ), windows W.focusUp  ) -- %! Move focus to the previous window
    , ((modMask,               xK_m     ), windows W.focusMaster  ) -- %! Move focus to the master window

    -- modifying the window order
    , ((modMask,               xK_Return), windows W.swapMaster) -- %! Swap the focused window and the master window
    , ((modMask .|. shiftMask, xK_j     ), windows W.swapDown  ) -- %! Swap the focused window with the next window
    , ((modMask .|. shiftMask, xK_k     ), windows W.swapUp    ) -- %! Swap the focused window with the previous window

    -- resizing the master/slave ratio
    , ((modMask,               xK_h     ), sendMessage Shrink) -- %! Shrink the master area
    , ((modMask,               xK_l     ), sendMessage Expand) -- %! Expand the master area

    -- floating layer support
    , ((modMask,               xK_t     ), withFocused $ windows . W.sink) -- %! Push window back into tiling

    -- increase or decrease number of windows in the master area
    , ((modMask              , xK_comma ), sendMessage (IncMasterN 1)) -- %! Increment the number of windows in the master area
    , ((modMask              , xK_period), sendMessage (IncMasterN (-1))) -- %! Deincrement the number of windows in the master area

    -- quit, or restart
    , ((modMask .|. shiftMask, xK_q     ), io (exitWith ExitSuccess)) -- %! Quit xmonad
    , ((modMask              , xK_q     ), spawn "killall conky dzen;if type xmonad; then xmonad --recompile && xmonad --restart; else xmessage xmonad not in \\$PATH: \"$PATH\"; fi") -- %! Restart xmonad

    , ((modMask .|. shiftMask, xK_slash ), spawn ("echo \"" ++ help ++ "\" | xmessage -file -")) -- %! Run xmessage with a summary of the default keybindings (useful for beginners)
    -- repeat the binding for non-American layout keyboards
    , ((modMask              , xK_question), spawn ("echo \"" ++ help ++ "\" | xmessage -file -"))
    , ((mod4Mask,  xK_s), cycleRecentWindows [xK_Super_L] xK_s xK_w)
    ]
    ++
    -- mod-[1..9] %! Switch to workspace N
    -- mod-shift-[1..9] %! Move client to workspace N
    [((m .|. modMask, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
    ++
    -- mod-{w,e,r} %! Switch to physical/Xinerama screens 1, 2, or 3
    -- mod-shift-{w,e,r} %! Move client to screen 1, 2, or 3
    [((m .|. modMask, key), screenWorkspace sc >>= flip whenJust (windows . f))
        | (key, sc) <- zip [xK_w, xK_e, xK_r, xK_d] [0..]
        , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]

help :: String
help = unlines ["The default modifier key is 'alt'. Default keybindings:",
    "",
    "-- launching and killing programs",
    "mod-Shift-Enter  Launch xterminal",
    "mod-p            Launch dmenu",
    "mod-Shift-p      Launch gmrun",
    "mod-Shift-c      Close/kill the focused window",
    "mod-Space        Rotate through the available layout algorithms",
    "mod-Shift-Space  Reset the layouts on the current workSpace to default",
    "mod-n            Resize/refresh viewed windows to the correct size",
    "",
    "-- move focus up or down the window stack",
    "mod-Tab        Move focus to the next window",
    "mod-Shift-Tab  Move focus to the previous window",
    "mod-j          Move focus to the next window",
    "mod-k          Move focus to the previous window",
    "mod-m          Move focus to the master window",
    "",
    "-- modifying the window order",
    "mod-Return   Swap the focused window and the master window",
    "mod-Shift-j  Swap the focused window with the next window",
    "mod-Shift-k  Swap the focused window with the previous window",
    "",
    "-- resizing the master/slave ratio",
    "mod-h  Shrink the master area",
    "mod-l  Expand the master area",
    "",
    "-- floating layer support",
    "mod-t  Push window back into tiling; unfloat and re-tile it",
    "",
    "-- increase or decrease number of windows in the master area",
    "mod-comma  (mod-,)   Increment the number of windows in the master area",
    "mod-period (mod-.)   Deincrement the number of windows in the master area",
    "",
    "-- quit, or restart",
    "mod-Shift-q  Quit xmonad",
    "mod-q        Restart xmonad",
    "mod-[1..9]   Switch to workSpace N",
    "",
    "-- Workspaces & screens",
    "mod-Shift-[1..9]   Move client to workspace N",
    "mod-{w,e,r}        Switch to physical/Xinerama screens 1, 2, or 3",
    "mod-Shift-{w,e,r}  Move client to screen 1, 2, or 3",
    "",
    "-- Mouse bindings: default actions bound to mouse events",
    "mod-button1  Set the window to floating mode and move by dragging",
    "mod-button2  Raise the window to the top of the stack",
    "mod-button3  Set the window to floating mode and resize by dragging"]
