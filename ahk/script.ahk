warrior_id := 0
poet_id := 0
asv_loop := true

!p::
    WinGet, poet_id, ID, A
return
!w::
    WinGet, warrior_id, ID, A
return
!a::
    WinActivate, ahk_id %poet_id%
    sleep 200
    Send {6}
    sleep 200
    Send {enter}
    Send {7}
    Send {enter}
    Send {8}
    sleep 200
    Send {enter}
    WinActivate, ahk_id %warrior_id%
return

!h::
    loop 50 {
        sleep 500
        ControlSend,, {enter}, ahk_id %warrior_id%
        sleep 500
        ControlSend,, wood, ahk_id %warrior_id%
        sleep 500
        ControlSend,, {enter}, ahk_id %warrior_id%
        sleep 500
        ControlSend,, {up}, ahk_id %warrior_id%
        sleep 500
        ControlSend,, {up}, ahk_id %warrior_id%
        sleep 500
        ControlSend,, {enter}, ahk_id %warrior_id%
        sleep 500
        ControlSend,, {enter}, ahk_id %warrior_id%
    }

return

!b::
    loop
    {
        sleep 50
        ControlSend,, {space}, ahk_id %warrior_id%
    }
return
!c::
    asv_loop = true
    loop {
        send {enter}
        sleep 100
        send {w}
        send {e}
        send {a}
        send {v}
        send {e}
        sleep 100
        send {enter}
        sleep 100
        send {down}
        sleep 100
        send {enter}
        sleep 200
        send {enter}
        if !asv_loop
        {
            break
        }
    }

return
!f::
    asv_loop = true
    loop {
        ControlSend,, {enter}, ahk_id %warrior_id%
        sleep 100
        ControlSend,, gem, ahk_id %warrior_id%
        sleep 500
        ControlSend,, {enter}, ahk_id %warrior_id%
        sleep 500
        ControlSend,, {down}, ahk_id %warrior_id%
        sleep 500
        ControlSend,, {enter}, ahk_id %warrior_id%
        sleep 500
        ControlSend,, {enter}, ahk_id %warrior_id%
        if !asv_loop
        {
            break
        }
    }

return

!m::
    WinActivate, ahk_id %poet_id%
    Send {0}
    sleep 100
    Send {3}
    sleep 100
    Send {4}
    sleep 100
    Send {5}
    sleep 300
    Send {6}
    sleep 300
    Send {7}
return
!=::
    WinActivate, ahk_id %poet_id%
    Send {5 down}
    sleep 6000
    Send {5 up}
    WinActivate, ahk_id %warrior_id%
return
!n::
    asv_loop = true
    loop_second = 0

    time_subtraction = 0
    loop
    {

        if Mod(loop_second, 5) == 0
        {
            ControlSend,, {0}, ahk_id %poet_id%
            sleep 100
            ControlSend,, {4}, ahk_id %poet_id%
            sleep 100
            ControlSend,, {5}, ahk_id %poet_id%
            sleep 400
            ControlSend,, {6}, ahk_id %poet_id%
            sleep 300
            ControlSend,, {7}, ahk_id %poet_id%
            time_subtraction += 900
            sleep 100

        }

        if Mod(loop_second, 20) == 0 
         {
            loop 20 
            {
                ControlSend,, {8}, ahk_id %poet_id%
                sleep 100
            }
            loop 20 
            {
                ControlSend,, {3}, ahk_id %poet_id%
                sleep 100
            }
            time_subtraction += 4000
        }

        if Mod(loop_second, 10) == 0
        {
            ControlSend,, {8}, ahk_id %warrior_id%
            sleep 500
            ControlSend,, {9}, ahk_id %warrior_id%
            sleep 500
            time_subtraction += 1000
        }

        if Mod(loop_second, 30) == 0
        {
            sleep 200
            ControlSend,, {5}, ahk_id %warrior_id%
            sleep 200
            time_subtraction += 400
        }
        if !asv_loop
        {
            break
        }

        if time_subtraction > 1000
        {
            time_subtraction -= 1000
        } else {
            sleep_amount := 1000 - time_subtraction
            time_subtraction = 0
            sleep %sleep_amount%
        }

        if !asv_loop 
        {
            break
        }
        loop_second += 1
    }
return
!s::
    IfWinActive, ahk_id %poet_id%
    {  
        WinActivate, ahk_id %warrior_id%
        return
    }
    IfWinActive, ahk_id %warrior_id%
    {  
        WinActivate, ahk_id %poet_id%
        return
    }
return

!d::
    asv_loop = false
return
