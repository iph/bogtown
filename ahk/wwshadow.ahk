IF NOT A_IsAdmin
{
   Run *RunAs "%A_ScriptFullPath%"
   ExitApp
}

#Include classNexus.ahk
#SingleInstance force
#Persistent
spellsword := 0
wizard := 0
; Beginning setup that should always run.
WinGet, id, List, BlankTK
if not WinExist("SpellSword"){
    WinSetTitle, % "ahk_id " id1, , Shadow
}

if not WinExist("Wizard"){
    WinSetTitle, % "ahk_id " id2, , Healer
}

WinGet, shadow, ID, Shadow
WinGet, healer, ID, Healer

healerClient := new nexus("Healer")
shadowClient := new nexus("Shadow")

F6::Pause
F7::Reload
F12::ExitApp
/::
   ControlSend,,{u}, Healer
   sleep 50
   ControlSend,,{g}, Healer
   return
!.::
   loop {
       HealGroup(healerClient, healer, 1, 90.0)

       RecastAethers("Magi's Bane", healerClient, healer, 8)
       RecastGroup("Sanctuary", healerClient, healer, 6)
       RecastGroup("Harden armor", healerClient, healer, 4)
       sleep 400
   }
return

Recast(spellName, client, id, keyCast)
{
    effect := client.activeEffects()
    if InStr(effect, spellName)
    {
       return
    }
    ControlSend,, %keyCast%, ahk_id %id%

}

RecastTarget(spellName, client, id, keyCast, targetUid)
{
    effect := client.activeEffects()
    if InStr(effect, spellName)
    {
       return
    }

    client.targetSpellUid(targetUid)
    ControlSend,, %keyCast% {enter} , ahk_id %id%
    ControlSend,, {esc} , ahk_id %id%

}

RecastAethers(spellName, client, id, keyCast)
{
    effect := client.activeEffects()
    StringReplace, effectRedone, effect, ------------------------, @, All
    StringSplit, spellbits, effectRedone, @
    if InStr(spellbits2, spellName)
    {
       return
    }
    ControlSend,, %keyCast%, ahk_id %id%
    return
}


HealGroup(client, id, keyCast, percent)
{
   i := 0
   targetUid := 0
   memberSize := client.groupMemberSize()
   loop %memberSize%
   {
        targetUid := client.groupMemberUid(i)
        currentVita := client.groupMemberCurrentVita(i)
        maxVita := client.groupMemberMaxVita(i)

        groupPercent := currentVita/maxVita*100

        if (groupPercent < percent) {
            client.targetSpellUid(targetUid)
            ControlSend,, %keyCast% {enter} , ahk_id %id%
            ControlSend,, {esc} , ahk_id %id%
        }
        i++
   }

   return
}


RecastGroup(spellName, client, id, keyCast)
{
    effect := client.activeEffects()
    if InStr(effect, spellName)
    {
       return
    }

   i := 0
   targetUid := 0
   memberSize := client.groupMemberSize()
   loop %memberSize%
   {
        targetUid := client.groupMemberUid(i)
        client.targetSpellUid(targetUid)
        ControlSend,, %keyCast% {enter} , ahk_id %id%
        ControlSend,, {esc} , ahk_id %id%
        i++
   }

   myUid := client.selfUid()
   ControlSend,, %keyCast% {enter} , ahk_id %id%
   ControlSend,, {esc} , ahk_id %id%

   return
}

FindUid(needle, client)
{
   i := 0
   targetUid := 0
   memberSize := client.groupMemberSize()
   loop %memberSize%
   {
        name := client.groupMemberName(i)
        if InStr(name, needle)
        {
           targetUid := client.groupMemberUid(i)
           return targetUid
        }
        i++
   }

   return 0
}