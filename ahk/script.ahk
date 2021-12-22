warrior_id := 0
poet_id := 0
asv_loop := true

    
!p::
    WinGet, poet_id, ID, A
return
!w::
    WinGet, warrior_id, ID, A
return
F6::Pause

!n::
    loop_second := 0
    loop
    {
        if Mod(loop_second, 10) == 0
        {
            ControlSend,, {9}, ahk_id %warrior_id%
        }
        loop_second += 1
        sleep 1000
    }
return
