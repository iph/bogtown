#Include classMemory.ahk
#SingleInstance force
#Persistent


WinGet, id, List, BlankTK
if not WinExist("Artisan"){
    WinSetTitle, % "ahk_id " id1, , Artisan
}

artisanread := new _ClassMemory("Artisan", "", hProcessCopy)
artisanBase := artisanread.BaseAddress
artisanInv := artisanread.readString(0x6FE204,,, 0xF8)
artisanMana := artisanread.read(0x6FE238, "UInt", 0x10C)
MsgBox % "hi" . artisanInv . " there"