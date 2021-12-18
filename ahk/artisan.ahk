art_id := 0
wood_selection := 3
F6::Pause
F7::Reload
F12::ExitApp

!a::
    WinGet, art_id, ID, A
    return



f::
    Rotah_Take("ginko wood", art_id)
    SendChat("splinter", art_id)
    loop 10 
    {
        ControlSend,, {up}, ahk_id %art_id%
        sleep 500
    }

    loop 5 
    {
        loop 20 
        {
            Wood(3, art_id)
        }

        SendChat("buy my all weaving tools", art_id)
        SendChat("buy my all fine weaving tools", art_id)
    }
    loop 20 
    {
        ControlSend,, {down}, ahk_id %art_id%
        sleep 500
    }

    ControlSend,, {3}, ahk_id %art_id%
    return 
Rotah_Deposit(item_name, art_id)
{
    SendChat("I will deposit all " . item_name, art_id)
}

Rotah_Take(item_name, art_id)
{
    SendChat("Give my all " . item_name . " back", art_id)
}

Wood(selection, art_id)
{
    SendChat("wood", art_id)
    SelectItem(selection, art_id)
    ControlSend,, {enter}, ahk_id %art_id% 
    return
}

SendChat(word, art_id)
{
    ControlSend,, {enter}, ahk_id %art_id%
    sleep 400
    ControlSend,, %word%, ahk_id %art_id%
    sleep 400
    ControlSend,, {enter}, ahk_id %art_id%
    sleep 400 
    return
}

SelectItem(x, art_id)
{
    loop %x%
    {
        ControlSend,, {down}, ahk_id %art_id%
        sleep 200
    }
    ControlSend,, {enter}, ahk_id %art_id%
    sleep 400
}
