rageWaitTime :=  638000 - (5 * 123000)
SetTimer RageWait, %rageWaitTime%

Sleep 2000
ControlSend,,{9}, Warrior ; rage
Sleep 100

rageCounter = 1

#Persistent
SetTimer Rage, 123000
SetTimer RageWait, Off

Rage:
if (rageCounter < 5) {
    Sleep 200
    ControlSend,, r, Warrior
    Sleep 50
    ControlSend,,9, Warrior ; rage
    rageCounter += 1
} else {
    SetTimer Rage, Off
    SetTimer RageWait, %rageWaitTime%
}
return

RageWait:
    SetTimer RageWait, Off
    ControlSend,,9, Warrior ; rage
    rageCounter = 0
    SetTimer Rage, On
    return