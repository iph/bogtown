#SingleInstance force
#Persistent
art_id := 0
F7::Reload

art_id := 0
wood_selection := 3
F6::Pause
F12::ExitApp

!a::
    WinGet, art_id, ID, A
    return
F9::
    loop {
        ControlSend,, {left}, ahk_id %art_id%
        sleep 300
        ControlSend,, {space}, ahk_id %art_id%
        sleep 300
    }
return
