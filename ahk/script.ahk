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
