#Include classNexus.ahk
#Include classEntity.ahk
#SingleInstance force
#Persistent
art_id := 0
F7::Reload

art_id := 0
wood_selection := 3
F6::Pause
F12::ExitApp
!c::
    entityManager := new EntityPositionManager()
    ; some random 10 uid, that we move from (1,1) to (2,1)
    positions := entityManager.AddEntityData(1888, 1, 1)
    entityManager.AddEntityData(1888, 2, 1)
    positions := entityManager.GetData(1888)
    MsgBox % positions[1].x . " " positions[2].x
return

!b::
    WinGet, id, List, BlankTK

    if not WinExist("Artisan"){
        WinSetTitle, % "ahk_id " id1, , Artisan
    }
    nexus := new Nexus("Artisan")
    Gui,Add,ListView, r50 w300 vList, Name| x | y | direction | guid
    Gui, Show
    loop 
    {
        i := 0
        loop 
        {
            x := nexus.entityCoordX(i)
            y := nexus.entityCoordY(i)
            name := nexus.entityName(i)
            guid := nexus.entityUid(i)
            direction := nexus.entityDirection(i)

            ; There is no suc thing as a guid of 0, it means you have hit "null space"
            ; and have exceeded the entity system
            if (guid < 1)
            {
            break
            }
            LV_Add("", name, x, y, direction, guid)
            i++
        }
        LV_ModifyCol()
        sleep 5000
        LV_Delete()
    }
    return

return
!a::
    WinGet, art_id, ID, A
    WinGet, id, List, BlankTK

    if not WinExist("Artisan"){
        WinSetTitle, % "ahk_id " id1, , Artisan
    }
    nexus := new Nexus("Artisan")
    Gui,Add,ListView, r50 w300 vList, Name| x | y | guid
    Gui, Show
    loop 
    {
        i := 0
        loop 
        {
            x := nexus.entityCoordX(i)
            y := nexus.entityCoordY(i)
            name := nexus.entityName(i)
            guid := nexus.entityUid(i)

            ; There is no suc thing as a guid of 0, it means you have hit "null space"
            ; and have exceeded the entity system
            if (guid < 1)
            {
            break
            }
            LV_Add("", name, x, y, guid)
            i++
        }
        LV_ModifyCol()
        sleep 5000
        LV_Delete()
    }
    return



F9::
    loop {
        ControlSend,, {left}, ahk_id %art_id%
        sleep 300
        ControlSend,, {space}, ahk_id %art_id%
        sleep 300
    }
return

ManhattenDistance(myPos, theirPos)
{

}

