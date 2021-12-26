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
    WinSetTitle, % "ahk_id " id1, , SpellSword
}

if not WinExist("Wizard"){
    WinSetTitle, % "ahk_id " id2, , Wizard
}

WinGet, spellsword, ID, SpellSword
WinGet, wizard, ID, Wizard

spellswordClient := new nexus("SpellSword")
wizardClient := new nexus("Wizard")

F6::Pause
F7::Reload
F12::ExitApp

/::
   ControlSend,,{u}, Wizard
   sleep 50
   ControlSend,,{i}, Wizard
   return
!.::
   targetUid := FindUid("iph", wizardClient)
   second := 0
   loop {
       Recast("Meditate", wizardClient,  wizard, 0)
       RecastTarget("Thunderstorm", wizardClient, wizard, 6, targetUid)
       RecastTarget("Diamond Dust", wizardClient, wizard, 7, targetUid)
       ;RecastTarget("Sanctuary", spellswordClient, wizard, 4, targetUid)
       ;RecastTarget("Harden armor", wizardClient, wizard, 5, targetUid)
       Recast("Magis Bane", wizardClient, wizard, 8)
       Recast("Auto Venom", wizardClient, wizard, 3)

       RecastAethers("Enchant Blade", spellswordClient, spellsword, 9)
       Recast("Tebaek's technique", spellswordClient, spellsword, 8)
       Recast("Zeal", spellswordClient, spellsword, 5)
       sleep 400

       second++

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