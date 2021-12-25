#Include classNexus.ahk
#Include classMap.ahk
#SingleInstance force
#Persistent
art_id := 0
F7::Reload

art_id := 0
wood_selection := 3
F6::Pause
F12::ExitApp
!d::
    Gui,Add,ListView, r50 w300 vList, x | y | val
    Gui, Show
    WinGet, id, List, BlankTK

    if not WinExist("Artisan"){
        WinSetTitle, % "ahk_id " id1, , Artisan
    }
    WinGet, artId, ID, Artisan
    nexus := new Nexus("Artisan")
    mapManager := new MapManager(18, 17)
    mapManager.map[18][11] := 2
    mapManager.map[17][12] := 2
    mapManager.map[16][13] := 2
    mapManager.map[16][16] := 2
    mapManager.map[14][7] := 2
    mapManager.map[13][5] := 2
    mapManager.map[13][9] := 2
    mapManager.map[12][12] := 2
    mapManager.map[7][1] := 2
    mapManager.map[7][7] := 2
    mapManager.map[7][15] := 2
    mapManager.map[5][5] := 2
    mapManager.map[3][1] := 2
    mapManager.map[1][9] := 2
    entities := GetEntities(nexus)
    len := entities.Length()
    loop %len% {
        position := mapManager.FindClosestPosition(nexus.mapX(), nexus.mapY(), entities)
        chosen := entities.RemoveAt(position)
        if mapManager.map[chosen.x][chosen.y] = 2
        {
            continue
        }
        bestPath := mapManager.FindBestPath(nexus.mapX(), nexus.mapY(), chosen.x, chosen.y)

        for index, item in bestPath.positions
        {
          LV_Add("", item.x, item.y, 0)
          TryMove(nexus, item.x, item.y, artId)
        }
    }
    return
!e:: 
    nexus := new Nexus("Artisan")
    last := nexus.lastSageOrWhisper()
    MsgBox % last
    return
!c::
    WinGet, id, List, BlankTK

    if not WinExist("Artisan"){
        WinSetTitle, % "ahk_id " id1, , Artisan
    }
    nexus := new Nexus("Artisan")
    mapManager := new MapManager(18, 17)
    ; some random 10 uid, that we move from (1,1) to (2,1)

    entities := GetEntities(nexus)
    i := 1
    len := entities.Length()-1
    loop %len%
    {
      entity := entities[i]
      LV_Add("", entity.name, entity.x, entity.y, entity.uid, i)
      i++
    }
    LV_ModifyCol()
    x := nexus.mapX()
    y := nexus.mapY()
    position := mapManager.FindClosestPosition(x,y, entities)
    msgBox % position
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

TryMove(nexus, goalX, goalY, art_id)
{
    previousX := nexus.mapX()
    previousY := nexus.mapY()
    tries := 0
    loop
    {
        x := nexus.mapX()
        y := nexus.mapY()
        distanceX := goalX - x
        distanceY := goalY - y
        ; let's move x first
        if (distanceX + distanceY) = 0
        {
           break
        }

        if x = previousX and y = previousY
        {
           tries++
        }

        if tries = 180
        {
           return 1
        }

        if distanceX > 0
        {
            ControlSend,, {right}, ahk_id %art_id%
            ;// move right
            ControlSend,, {right}, "Artisan"
            continue
        }

        if distanceX < 0
        {
           ;// move left
           ControlSend,, {left}, ahk_id %art_id%
           continue
        }

        if distanceY > 0
        {
            ;// move down
            ControlSend,, {down}, ahk_id %art_id%
            continue
        }

        if distanceY < 0
        {
            ;// move down
            ControlSend,, {up}, ahk_id %art_id%
            continue
        }



        sleep 500
    }

    return 0
}
GetEntities(nexus)
{
    entities := []
    i := 0
    loop
    {
        name := nexus.entityName(i)
        uid := nexus.entityUid(i)
        x := nexus.entityCoordX(i)
        y := nexus.entityCoordY(i)
        entity := new Entity(uid, name, x, y)
        if (StrLen(name) > 1)
        {
           i++
           continue
        }
        entities.Push(entity)

        ; There is no suc thing as a guid of 0, it means you have hit "null space"
        ; and have exceeded the entity system
        if (uid < 1)
        {
            break
        }

        i++
    }
    return entities
}