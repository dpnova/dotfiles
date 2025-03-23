import XMonad
import XMonad.Actions.CycleWindows
import Data.Semigroup
import qualified Data.Text as T
import qualified XMonad.StackSet as W
import XMonad.Util.Themes
import qualified Data.Map as M
import XMonad.Config.Xfce
import XMonad.Config
import XMonad.Layout.Tabbed
import XMonad.Layout.Simplest
import XMonad.Layout.Grid
import XMonad.Layout.Spacing
import XMonad.Layout.ShowWName
import XMonad.Layout.Reflect
import XMonad.Layout.OneBig
import XMonad.Layout.ThreeColumns
import XMonad.Layout.Spiral
import XMonad.Actions.CycleWindows
import XMonad.Actions.UpdatePointer
import XMonad.Layout.CircleEx
import XMonad.Layout.AutoMaster
import XMonad.Layout.Magnifier
import XMonad.Layout.DecorationMadness
import XMonad.Hooks.InsertPosition
import XMonad.Layout.Renamed(renamed)
import qualified XMonad.Core as XMonad
    (workspaces,manageHook,keys,logHook,startupHook,borderWidth,mouseBindings
    ,layoutHook,modMask,terminal,normalBorderColor,focusedBorderColor,focusFollowsMouse
    ,handleEventHook,clickJustFocuses)
import XMonad.Hooks.EwmhDesktops
import XMonad.Layout
import XMonad.Operations
import XMonad.ManageHook
import XMonad.Hooks.ManageHelpers
import XMonad.Actions.CopyWindow
import XMonad.Layout.SubLayouts
import Graphics.X11.Xlib.Extras
import XMonad.Hooks.SetWMName
import XMonad.Hooks.ManageDocks
import Data.Ratio
import Data.Maybe
import Graphics.X11.Xlib.Extras
import XMonad.Util.EZConfig(additionalKeys)
import XMonad.Config.Desktop
import Graphics.X11.ExtraTypes.XF86
import System.IO
import XMonad.Layout.NoBorders
import XMonad.Util.SpawnOnce ( spawnOnce )
import qualified XMonad.Layout.MultiToggle as MT
import XMonad.Layout.MultiToggle.Instances



myWorkspaces = ["1:dev","2:browse","3:comm","4:monitor","5:email","6:cast","7","8:tunes","9:hide"]
base03  = "#002b36"
base02  = "#3A3945"
base01  = "#586e75"
base00  = "#657b83"
base0   = "#839496"
base1   = "#93a1a1"
base2   = "#eee8d5"
base3   = "#fdf6e3"
yellow  = "#b58900"
orange  = "#cb4b16"
orange2 = "#DD2820"
salmon  = "#D4625E"
red     = "#dc322f"
magenta = "#d33682"
violet  = "#6c71c4"
blue    = "#268bd2"
cyan    = "#2aa198"
green   = "#859900"
pink    = "#f92672"
darker  = "#1E1F21"

gap     = 9
border  = 1


active   = pink
activeWarn = red
inactive = darker
focusColor = blue
unfocusColor = base02
feature = salmon

--myNormalBorderColor  = base02
--myFocusedBorderColor = feature
myNormalBorderColor  = darker
myFocusedBorderColor = blue


myShowWNameTheme = def
    --{ swn_font = "xft:Monospace:pixelsize=120:regular:antialias=true:hinting=true"
    { swn_font = "xft:Roboto:pixelsize=120:regular:antialias=true:hinting=true"
    , swn_fade = 0.4
    , swn_bgcolor = base03
    , swn_color = feature
    }

myKeys conf@(XConfig {XMonad.modMask = modMask}) = M.fromList $
    [ ((modMask .|. shiftMask, xK_m), withFocused (sendMessage . MergeAll))
    , ((modMask .|. shiftMask, xK_u), withFocused (sendMessage . UnMerge))
    , ((modMask .|. shiftMask, xK_n), withFocused (sendMessage . mergeDir W.focusDown'))
    , ((modMask .|. shiftMask, xK_period), onGroup W.focusUp')
    , ((modMask .|. shiftMask, xK_comma), onGroup W.focusDown')
    ]
newKeys x = myKeys x `M.union` keys def x
myTabTheme = (theme adwaitaDarkTheme)
    { decoHeight = 20
    , fontName = "xft:JetBrainsMono Nerd Font Mono:pixelsize=10:light:antialias=true:hinting=true,xft:Noto Color Emoji:size=10,xft:Emoji One:size=10"
    }
myStartupHook = do
    spawnOnce "exec eww daemon"
    spawnOnce "exec playerctld daemon"

myManageHook = composeAll
    [ className =? "Gimp"      --> doFloat
    , appName =? "rustdesk" --> hasBorder False
    , className =? "mixxc"      --> (doFloat <+> hasBorder False)
    , title =? "Whisker Menu"      --> doFloat
    , title =? "Whisker Menu"      --> hasBorder False
    , title =? "Application Finder"      --> doFloat
    , title =? "File Operation Progress" --> doFloat
    , className =? "zoom" --> (doFloat <+> hasBorder False)
    , stringProperty "WM_WINDOW_ROLE" =? "quake" --> (doFloat <+> hasBorder False)
    , isFullscreen --> hasBorder False
    , stringProperty "WM_WINDOW_TYPE" =? "_NET_WM_WINDOW_TYPE_HUDDLES-MINI-PANEL" --> hasBorder False
    , stringProperty "TDROP_NAME" =? "tdrop" --> (doFloat <+> hasBorder False)
    , isInProperty "_NET_WM_WINDOW_TYPE" "_NET_WM_WINDOW_TYPE_UTILITY" --> (doFloat <+> hasBorder False)
    -- , isFullscreen --> (doF W.focusDown <+> doFullFloat <+> hasBorder False)
    ]

-- Gaps around and between windows
-- Dimensions are given as (Border top bottom right left)
mySpacing = spacingRaw True             -- Only for >1 window
                       -- The bottom edge seems to look narrower than it is
                       (Border 0 20 15 15) -- Size of screen edge gaps
                       True             -- Enable screen edge gaps
                       (Border 10 10 10 10) -- Size of window gaps
                       True             -- Enable window gaps

myBigSpacing = spacingRaw True             -- Only for >1 window
                       -- The bottom edge seems to look narrower than it is
                       (Border 0 55 45 45) -- Size of screen edge gaps
                       True             -- Enable screen edge gaps
                       (Border 40 40 40 40) -- Size of window gaps
                       True             -- Enable window gaps

main = xmonad $ ewmhFullscreen $ ewmh $ xfceConfig  {
            borderWidth = border,
            workspaces = myWorkspaces,
            focusFollowsMouse = True,
            focusedBorderColor = myFocusedBorderColor,
            normalBorderColor = myNormalBorderColor,
            keys = newKeys,
            terminal = "/home/dpn/.local/kitty.app/bin/kitty",
            manageHook =  manageDocks <+> myManageHook <+> manageHook def, -- insertPosition Below Newer <>
            startupHook = myStartupHook,
            logHook = updatePointer (0.5, 0.5) (0, 0),
            layoutHook = addTabs shrinkText myTabTheme $
                MT.mkToggle (MT.single REFLECTX) $
                MT.mkToggle (MT.single NBFULL) $
                showWName' myShowWNameTheme $
                subLayout [] Simplest $
                avoidStruts $
                smartBorders $
                desktopLayoutModifiers
              circleEx {cDelta = -3*pi/4} |||
              mySpacing Full |||
              (mySpacing (spiral (125 % 146)))  |||
              (mySpacing $ Tall 1 (3/100) (1/2)) |||
              -- (mySpacing $ Mirror (Tall 1 (3/100) (1/2))) |||
              Mirror (Tall 1 (3/100) (1/2)) |||
              (mySpacing $ reflectHoriz (ThreeCol 1 (3/100) (1/2))) |||
              --(myBigSpacing $ Tall 1 (3/100) (1/2)) |||
              -- (autoMaster 1 (1/100) (mySpacing $ tabbed shrinkText myTabTheme)) |||
              -- (ThreeCol 1 (3/100) (1/2)) |||
              (mySpacing $ Grid) |||
              OneBig (0.5) (0.5) -- |||
              -- (mySpacing $ reflectHoriz (Tall 1 (3/100) (1/2)))
              -- |||
              -- avoidStruts (spacing 10 $ reflectVert (Mirror (Tall 1 (3/100) (1/2))))

} `additionalKeys` (
--        [ ((0, xK_Scroll_Lock), spawn "xfce4-screensaver-command -l;xset +dpms dpms 600 1200 1800")
        [ ((0, xF86XK_Tools), spawn "/usr/bin/thunar")
        , ((0, xF86XK_Launch5), spawn "/usr/bin/thunar")
        , ((controlMask, xK_Print), spawn "sleep 0.2; xfce4-screenshooter -w")
        , ((0, xK_Print), spawn "sleep 0.2; xfce4-screenshooter -r")
        , ((0, xF86XK_AudioPlay), spawn "playerctl -a play-pause")
        , ((0, xF86XK_AudioStop), spawn "playerctl -a stop")
        , ((0, xF86XK_AudioPrev), spawn "playerctl -a previous")
        , ((0, xF86XK_AudioNext), spawn "playerctl -a next")
        , ((0, xF86XK_AudioRaiseVolume), spawn "pactl set-sink-volume bluez_sink.10_4F_A8_8C_CA_DA.a2dp_sink +5%")
        , ((0, xF86XK_AudioLowerVolume), spawn "pactl set-sink-volume bluez_sink.10_4F_A8_8C_CA_DA.a2dp_sink -5%")
--        , ((0, 0xffc5), spawn "autorandr -cf")
--        , ((0, xF86XK_Display), spawn "autorandr -cf")
--        , ((0, xF86XK_WakeUp), spawn "xfce4-screensaver-command -l;xset +dpms dpms 600 1200 1800")
        , ((mod1Mask, xK_p), spawn "xfce4-popup-whiskermenu -p")
        , ((mod1Mask .|. controlMask, xK_z), sendMessage $ MT.Toggle REFLECTX)
        , ((mod1Mask .|. controlMask, xK_x), sendMessage $ MT.Toggle NBFULL)
        , ((mod4Mask,  xK_s), cycleRecentWindows [xK_Super_L] xK_s xK_w)
        , ((mod1Mask, xK_z), rotOpposite)
        , ((mod1Mask                , xK_i), rotUnfocusedUp)
        , ((mod1Mask                , xK_u), rotUnfocusedDown)
        , ((mod1Mask .|. controlMask, xK_i), rotFocusedUp)
        , ((mod1Mask .|. controlMask, xK_u), rotFocusedDown)
        ] ++ [
        ((m .|. mod1Mask, key), screenWorkspace sc >>= flip whenJust (windows . f)) -- Replace 'mod1Mask' with your mod key of choice.
        | (key, sc) <- zip [xK_w, xK_e, xK_r] [1,0,2] -- was [0..] *** change to match your screen order ***
        , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]
    )


