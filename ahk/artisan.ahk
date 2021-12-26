art_id := 0
#Include classNexus.ahk
wood_selection := 3
F6::Pause
F7::Reload
F12::ExitApp
s::
    WinGet, id, List, BlankTK

    if not WinExist("Artisan"){
        WinSetTitle, % "ahk_id " id1, , Artisan
    }
    WinGet, art_id, ID, Artisan

    nexus := new Nexus("Artisan")
    loop
    {
        Rotah_Take("Tin ore [pwdr]", art_id)
        Rotah_Take("Tin ore [sm]", art_id)
        Rotah_Take("Tin ore [med]", art_id)
        Rotah_Take("Tin ore [lrg]", art_id)
        Ring(art_id)
        loop 3 {
            loop 20
            {
                UseIfInventory(nexus, art_id, "Tin Ore [pwdr]", 1)
                UseIfInventory(nexus, art_id, "Tin Ore [sm]", 2)
                UseIfInventory(nexus, art_id, "Tin Ore [med]", 3)
                UseIfInventory(nexus, art_id, "Tin Ore [lrg]", 4)
            }
            SendChat("buy my all slag", art_id)
        }
        Port(art_id)
        Rotah_Deposit("metal", art_id)
        Rotah_Deposit("fine metal", art_id)
    }

    return
o::
    Rotah_Take("wool", art_id)
    Rotah_Deposit("fine cloth", art_id)
    Rotah_Deposit("cloth", art_id)
    sleep 500
    SendChat("sel", art_id)
    return
p::
    loop 100
    {
       SendChat("wood", art_id)
       SelectItem(5, art_id)
       ControlSend,, {enter}, ahk_id %art_id%
    }
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
    SendChat("i will deposit all " . item_name, art_id)
}

Rotah_Take(item_name, art_id)
{
    SendChat("give my all " . item_name . " back", art_id)
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
    sleep 300
    ControlSend,, {enter}, ahk_id %art_id%
    sleep 450
    ControlSend,, %word%, ahk_id %art_id%
    sleep 450
    ControlSend,, {enter}, ahk_id %art_id%
    sleep 450
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

Ring(art_id)
{
    ControlSend,, {u}, ahk_id %art_id%
    ControlSend,, {b}, ahk_id %art_id%
}

Port(art_id)
{
    ControlSend,, {u}, ahk_id %art_id%
    ControlSend,, {c}, ahk_id %art_id%
}


UseIfInventory(nexus, artId, itemName, itemSelection)
{
    position := CheckInventory(nexus, itemName, 1)
    if (position = -1)
    {
       return
    }
    ControlSend,, {esc}, ahk_id %artId%
    sleep 300
    SendChat("smelt", artId)
    SelectItem(itemSelection, artId)
    ControlSend,, {enter}, ahk_id %artId%
    sleep 300
}

CheckInventory(nexus, itemName, quantityMin)
{
    position := FindItemPosition(nexus, itemName)
    if position != -1
    {
        quantity := nexus.inventoryItemQuantity(position)
        if (quantity > quantityMin)
        {
           return position
        }
    }

    return -1
}

FindItemPosition(nexus, itemName)
{
     i := 0
     loop 27
     {
        item := nexus.inventoryItemName(i)
        if (InStr(item, itemName))
        {
           return i
        }

        i++
     }

     return -1
}
