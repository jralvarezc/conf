import XMonad

main = xmonad defaultConfig
        { modMask = mod4Mask -- Use Super instead of Alt
        , terminal = "kitty"
        -- more changes
        }