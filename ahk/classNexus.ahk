#Include classMemory.ahk

; Nexus is a wrapper around the process for nexus itself. It allows
; access to convenience methods for simple parts of the game itself.
; uses classMemory, located at: https://github.com/Kalamity/classMemory
;
; just copy that fellow in to the same directory, and you can immediately
; do:
;
;  #Include classNexus.ahk
;  
;  nexus := new Nexus("<Name of process>");
;
;    All available methods:
;        inventoryItemName(position)
;        inventoryItemQuantity(position)
;        spell(position)
;        currentVita()
;        maxVita()
;        currentMana()
;        maxMana()
;        exp()
;        gold()
;        level()
;        name()
;        path()
;        activeEffects()
;        lastChatOrBlueSpell()
;        lastSageOrWhisper()
;        selfUid()
;        mapName()
;        mapX()
;        mapY()
;     ------ Entity APIS ------
;        entityName(position)
;        entityCoordX(position)
;        entityCoordY(position)
;        entityPixelX(position)
;        entityPixelY(position)
;        entityUid(position)
;        entityCount(position)
;        entityDirection(position)
;     ------ Group APIs -------
;        groupMemberUid(position)
;        groupMemberName(position)
;        groupMemberCurrentMana(position)
;        groupMemberMaxMana(position)
;        groupMemberCurrentVita(position)
;        groupMemberMaxVita(position)
;        groupMemberSize()
;     ------ Targets API ------
;        targetNpcUid()
;        targetPlayerUid()
;        targetSpellUid()
class Nexus {
    static class_mem
    
    __new(program) 
    {
        this.class_mem := new _ClassMemory(program, "", hProcessCopy)
    }

    ; Method: inventoryItemName(position)
    ; Example: Assume I have an artisan that has three items in their inventory: 
    ;    a: Tin Ore [sm] (2)
    ;    b: Sturdy Axe
    ;    c: Weaving tools
    ;
    ; To query `Sturdy Axe`, I would run:
    ;  ```
    ;  nexus := new Nexus("artisan")
    ;  nexus.inventoryItemName(1)
    ;  ```
    ;
    ; Parameters:
    ;    position - unsigned integer for the inventory position you want to read. Starts at 0 for first item
    ;               in your inventory
    ;
    ; Return:
    ;    String - the name of the item at the position entered. Will return Null if out of bounds.
    inventoryItemName(position) 
    {
        item := this.class_mem.readString(0x6DD490,, encoding := "utf-16",  0x1641AA + position * 0x1FC)
        return item
    }

    ; Method: inventoryItemName(position)
    ; Example: Assume I have an artisan that has three items in their inventory: 
    ;    a: Tin Ore [sm] (2)
    ;    b: Sturdy Axe
    ;    c: Weaving tools
    ;
    ; To query `Tine Ore` quantity, I would run:
    ;  ```
    ;  nexus := new Nexus("artisan")
    ;  nexus.inventoryItemQuantity(0)
    ;  ```
    ;  the above code would return `2` -- as there are 2 ores
    ;
    ; Parameters:
    ;    position - unsigned integer for the spell position you want to read. Starts at 0 for first item
    ;               in your inventory
    ;
    ; Return:
    ;    UInt - the quantity of the items at the given position
    inventoryItemQuantity(position) 
    {
        itemQuantity:= this.class_mem.read(0x6DD490, "UInt", 0x1642EC + position * 0x1FC)
        return itemQuantity
    }

    ; Method: spell(position)
    ; Example: Assume I have an artisan that has three spells. 
    ;    a: Soothe
    ;    b: Gateway
    ;    c: Return
    ;
    ; To query Soothe, I would run:
    ;  ```
    ;  nexus := new Nexus("artisan")
    ;  nexus.spell(0)
    ;  ```
    ;
    ; Parameters:
    ;    position - unsigned integer for the spell position you want to read. Starts at 0 for first spell.
    ;
    ; Return:
    ;    String - the name of the spell at the position entered. Will return Null if out of bounds.
    spell(position) 
    {
        spell := this.class_mem.readString(0x6DD490,, encoding := "utf-16", 0x16A83C + position * 0x148)
        return spell
    }

    ; Method: currentVita()
    ; Example: Assume I have a warrior with 1100 / 1300 hp

    ; To query current vitality (1100), I would run:
    ;  ```
    ;  nexus := new Nexus("warrior")
    ;  nexus.currentVita()
    ;  ```
    ;
    ; the expected return value would be `1100`
    ;
    ; Return:
    ;    UInt - The current vitality of the logged in character.
    currentVita()
    {
        vita := this.class_mem.read(0x6FE238, "UInt", 0x104)
        return vita
    }

    ; Method: maxVita()
    ; Example: Assume I have a warrior with 1100 / 1300 hp

    ; To query max vitality (1300), I would run:
    ;  ```
    ;  nexus := new Nexus("warrior")
    ;  nexus.maxVita()
    ;  ```
    ;
    ; the expected return value would be `1300`
    ;
    ; Return:
    ;    UInt - The maximum vitality of the logged in character.
    maxVita()
    {
        vita := this.class_mem.read(0x6FE238, "UInt", 0x108)
        return vita
    }

    ; Method: currentMana()
    ; Example: Assume I am logged in to a warrior with 600 / 900 mana

    ; To query current mana (600), I would run:
    ;  ```
    ;  nexus := new Nexus("warrior")
    ;  nexus.currentMana()
    ;  ```
    ;
    ; the expected return value would be `600`
    ;
    ; Return:
    ;    UInt - The current mana of the logged in character.
    currentMana()
    {
        mana := this.class_mem.read(0x6FE238, "UInt", 0x10C)
        return mana
    }

    ; Method: maxMana()
    ; Example: Assume I am logged in to a warrior with 600 / 900 mana

    ; To query max mana (900), I would run:
    ;  ```
    ;  nexus := new Nexus("warrior")
    ;  nexus.maxMana()
    ;  ```
    ;
    ; the expected return value would be `900`
    ;
    ; Return:
    ;    UInt - The maximum mana of the logged in character.
    maxMana()
    {
        mana := this.class_mem.read(0x6FE238, "UInt", 0x110)
        return mana
    }

    ; Method: exp()
    ; Example: Assume I am logged in to a warrior with 6,848,000 exp

    ; To query exp, I would run:
    ;  ```
    ;  nexus := new Nexus("warrior")
    ;  nexus.exp()
    ;  ```
    ;
    ; the expected return value would be `6,848,000`
    ;
    ; Return:
    ;    UInt - The experience the currently logged in character has.
    exp()
    {
        exp := this.class_mem.read(0x6FE238, "UInt", 0x114)
        return exp
    }

    ; Method: gold()
    ; Example: Assume I am logged in to a warrior with 75,516 gold

    ; To query gold, I would run:
    ;  ```
    ;  nexus := new Nexus("warrior")
    ;  nexus.gold()
    ;  ```
    ;
    ; the expected return value would be `75,516`
    ;
    ; Return:
    ;    UInt - The gold the currently logged in character has.
    gold()
    {
        gold := this.class_mem.read(0x6FE238, "UInt", 0x11C)
        return gold
    }

    ; Method: name()
    ; Example: Assume I am logged in to a warrior with the name `Iph`
    ; To query my name, I would run:
    ;  ```
    ;  nexus := new Nexus("warrior")
    ;  nexus.name()
    ;  ```
    ;
    ; the expected return value would be `Iph`
    ;
    ; Return:
    ;    String - The name of the current logged in character
    name()
    {
        name := this.class_mem.readString(0x6DD490,, encoding := "utf-16", 0x12A)
        return name
    }

    ; Method: path()
    ; Example: Assume I am logged in to an Artisan.

    ; To query my path, I would run:
    ;  ```
    ;  nexus := new Nexus("artisan")
    ;  nexus.path()
    ;  ```
    ;
    ; The value returned is "Artisan"
    ;
    ; Return:
    ;    String - The "path" this character is assigned to. Seems to what's filled in
    path()
    {
        path := this.class_mem.readString(0x6FDB3C,, encoding := "utf-16", 0x1FC)
        return path
    }

    ; Method: path()
    ; Example: Assume I am logged in to a Spellblade and have the current effects
    ; ```
    ; Enchant Blade 678s
    ; Tebaek's technique 571s
    ; ---------------------
    ; Enchant Blade 68s
    ; ```
    ;
    ; To query this full string (yes, all of it):
    ;  ```
    ;  nexus := new Nexus("warrior")
    ;  nexus.effects()
    ;  ```
    ;
    ; The value returned is "the entirety of the string above.
    ;
    ; Return:
    ;    String - All current effects impacting the logged in character.
    activeEffects()
    {
        status := this.class_mem.readString(0x4C1260,, encoding := "utf-16", 0x4A4)
        return status
    }

    ; Method: lastChatOrBlueSpell()
    ;
    ; Example: This needs a bit of prefixing. There seem to be 6 types of chat representation.
    ; 1: Server/Guide -- things like "Welcome to the game" that are auto generated at time intervals
    ; 2: Sage -- shout to the world
    ; 3: Chat -- current "eye distance" can hear you.
    ; 4: Shout -- same as chat but the entire room can hear
    ; 5: Whisper -- directed chat to a person.
    ; 6: Spell -- a spell sometimes says stuff in the chatbox as well.
    ;
    ; Now given this, let me tag some sample chat:
    ; ```
    ; sage-- [SKIN] hmm..
    ; sage -- [Staff] 3 times.
    ; chat -- iph: hi
    ; ```
    ; To query the last chat or spell (in this case "iph: hi"):
    ;  ```
    ;  nexus := new Nexus("warrior")
    ;  nexus.lastChatOrBlueSpell()
    ;  ```
    ;
    ; The value returned is "iph: hi" - verbatim.
    ;
    ; Return:
    ;    String - Most recent chat or spell in the chatbox
    lastChatOrBlueSpell()
    {
        chat := this.class_mem.readString(0x6FE788,, encoding := "utf-16", 0x12C)
        return chat
    }

    ; Method: lastSageOrWhisper()
    ;
    ; Example: This needs a bit of prefixing. There seem to be 6 types of chat representation.
    ; 1: Server/Guide -- things like "Welcome to the game" that are auto generated at time intervals
    ; 2: Sage -- shout to the world
    ; 3: Chat -- current "eye distance" can hear you.
    ; 4: Shout -- same as chat but the entire room can hear
    ; 5: Whisper -- directed chat to a person.
    ; 6: Spell -- a spell sometimes says stuff in the chatbox as well.
    ;
    ; Now given this, let me tag some sample chat:
    ; ```
    ; sage-- [SKIN] hmm..
    ; sage -- [Staff] 3 times.
    ; chat -- iph: hi
    ; ```
    ; To query the last chat or spell (in this case "iph: hi"):
    ;  ```
    ;  nexus := new Nexus("warrior")
    ;  nexus.lastSageOrWhisper()
    ;  ```
    ;
    ; The value returned is "[Staff] 3 times." - verbatim.
    ;
    ; Return:
    ;    String - Most recent sage or whisper.
    lastSageOrWhisper()
    {
        chat := this.class_mem.readString(0x5C07D4,, encoding := "utf-16", 0x174)
        return chat
    }

    ; Method: selfUid()
    ;
    ; Authors note: uids are unique ids for specific characters within Nexus. I haven't found a good use case
    ;      for these but left the uid APIs in to allow others to experiment.
    ; Example: I am logged in as Iph. I run selfUid and get `1685` this login session. Every time I run this while
    ;          logged in, I will continue to get `1685`

    ; Small example:
    ;  ```
    ;  nexus := new Nexus("warrior")
    ;  nexus.selfUid()
    ;  ```
    ; Return:
    ;    UInt - uid of character that's currently logged in for this process.
    selfUid()
    {
       uid := this.class_mem.read(0x6DD490, "UInt", 0xFC)
       return uid
    }

    ; Method: time()
    ; Example: Nexus runs on a different time system than a normal clock. It still has 24 hours, but no minutes.
    ;          When a person queries time, they query which hour in the day it is.
    ;
    ; Let's say it's morning (05) and I want to query the time. I would run:
    ;  ```
    ;  nexus := new Nexus("warrior")
    ;  nexus.time()
    ;  ```
    ;
    ; the expected return value would be `5`
    ;
    ; Return:
    ;    UInt - A number between 0-23 that represents the hour in the day.
    time()
    {
       time := this.class_mem.read(0x6FE168, "UInt", 0xF8)
       return time
    }

    ; Method: time()
    ; Example: Let's say I'm logged in to Nexus, and am on the map `Mythic Nexus`
    ;
    ; I want to query what map I'm on, I would run:
    ;  ```
    ;  nexus := new Nexus("warrior")
    ;  nexus.mapName()
    ;  ```
    ;
    ; the expected return value would be "Mythic Nexus"
    ;
    ; Return:
    ;    String - the current name of the map the character is on.
    mapName()
    {
        name := this.class_mem.readString(0x6FE204,, encoding := "utf-16", 0xF8)
        return name
    }

    ; Method: mapX()
    ; Example: Let's say I'm logged in to Nexus, and am at position (032, 050)
    ;
    ; I want to query what the X value of my character position. I would run:
    ;  ```
    ;  nexus := new Nexus("warrior")
    ;  nexus.mapX()
    ;  ```
    ;
    ; the expected return value would be `32`
    ;
    ; Return:
    ;    UInt - the X position of the character that's currently logged in.
    mapX()
    {
        position := this.class_mem.read(0x6FE238, "UInt", 0xFC)
        return position
    }

    ; Method: mapY()
    ; Example: Let's say I'm logged in to Nexus, and am at position (032, 050)
    ;
    ; I want to query what the Y value of my character position. I would run:
    ;  ```
    ;  nexus := new Nexus("warrior")
    ;  nexus.mapY()
    ;  ```
    ;
    ; the expected return value would be `50`
    ;
    ; Return:
    ;    UInt - the Y position of the character that's currently logged in.
    mapY()
    {
        position := this.class_mem.read(0x6FE238, "UInt", 0x100)
        return position
    }

    ; Method: entityName(position)
    ;
    ; Author's Note: Entities are "things on the current map". E.g. if another person
    ;                is in the map. This includes monsters. It hasn't been tested how
    ;                often this data is refreshed.
    ;
    ; Example: Let's say I'm logged in to Nexus, and am in a room with a sheep. The sheep was
    ;          in the room first. The assumption is that the positions are:
    ;
    ;          0: Sheep (entity metadata)
    ;          1: Iph   (entity metadata) <<< Haven't tested if it shows self, or if you query self.
    ;
    ; I want to query the sheep. I would run
    ;  ```
    ;  nexus := new Nexus("warrior")
    ;  nexus.entityName(0)
    ;  ```
    ;
    ; the expected return value would be null, sheeps don't have names. So far, it seems only other PC characters
    ; show up for entityName.
    ;
    ; Return:
    ;    String - will return the name of a PC character. For Monsters, it is Null.
    entityName(position)
    {
        name := this.class_mem.readString(0x6FE61C,, encoding := "utf-16", 0x12E + position * 0x20C)
        return name
    }

    ; Method: entityCoordX(position)
    ;
    ; Author's Note: Entities are "things on the current map". E.g. if another person
    ;                is in the map. This includes monsters. It hasn't been tested how
    ;                often this data is refreshed.
    ;
    ; Example: Let's say I'm logged in to Nexus, and am in a room with a sheep. The sheep was
    ;          in the room first. The assumption is that the positions are:
    ;
    ;          0: Sheep, location: (50, 182)
    ;          1: Iph, location: (81, 165)
    ;
    ; I want to query the sheep's X location. I would run
    ;  ```
    ;  nexus := new Nexus("warrior")
    ;  nexus.entityCoordX(0)
    ;  ```
    ;
    ; the expected return value would be `50`
    ;
    ; Parameters:
    ;    position - unsigned integer for the entity you want to read. Starts at 0 for first entity
    ;
    ; Return:
    ;    UInt - returns the x position of the entity.
    entityCoordX(position)
    {
        position := this.class_mem.read(0x6FE61C, "UInt", 0x104 + position * 0x20C)
        return position
    }

    ; Method: entityCoordY(position)
    ;
    ; Author's Note: Entities are "things on the current map". E.g. if another person
    ;                is in the map. This includes monsters. It hasn't been tested how
    ;                often this data is refreshed.
    ;
    ; Example: Let's say I'm logged in to Nexus, and am in a room with a sheep. The sheep was
    ;          in the room first. The assumption is that the positions are:
    ;
    ;          0: Sheep, location: (50, 182)
    ;          1: Iph, location: (81, 165)
    ;
    ; I want to query the sheep's Y location. I would run
    ;  ```
    ;  nexus := new Nexus("warrior")
    ;  nexus.entityCoordY(0)
    ;  ```
    ; the expected return value would be `182`
    ;
    ; Parameters:
    ;    position - unsigned integer for the entity you want to read. Starts at 0 for first entity
    ;
    ; Return:
    ;    UInt - returns the y position of the entity.
    entityCoordY(position)
    {
        position := this.class_mem.read(0x6FE61C, "UInt", 0x108  + position * 0x20C)
        return position
    }

    ; Method: entityPixelX(position)
    ;
    ; Author's Note: Entities are "things on the current map". E.g. if another person
    ;                is in the map. This includes monsters. It hasn't been tested how
    ;                often this data is refreshed.
    ;
    ; Author's Note 2: I'm not sure what pixel X / pixel y do. I think it's the amount of pixels the image
    ;                  of the entity takes up -- which doesn't really matter (doesn't take up more than 1 space).
    ;
    ; Nevertheless, I want to query how many pixels take up the x dimension, I run:
    ;  ```
    ;  nexus := new Nexus("warrior")
    ;  nexus.entityPixelX(0)
    ;  ```
    ; the expected return value would be the amount of pixels on X
    ;
    ; Parameters:
    ;    position - unsigned integer for the entity you want to read. Starts at 0 for first entity
    ;
    ; Return:
    ;    UInt - returns the pixels for the x dimension.
    entityPixelX(position)
    {
        position := this.class_mem.read(0x6FE61C, "UInt", 0x10C + position * 0x20C)
        return position
    }

    ; Method: entityPixelY(position)
    ;
    ; Author's Note: Entities are "things on the current map". E.g. if another person
    ;                is in the map. This includes monsters. It hasn't been tested how
    ;                often this data is refreshed.
    ;
    ; Author's Note 2: I'm not sure what pixel X / pixel y do. I think it's the amount of pixels the image
    ;                  of the entity takes up -- which doesn't really matter (doesn't take up more than 1 space).
    ;
    ; Nevertheless, I want to query how many pixels take up the y dimension, I run:
    ;  ```
    ;  nexus := new Nexus("warrior")
    ;  nexus.entityPixelY(0)
    ;  ```
    ; the expected return value would be the amount of pixels on Y
    ;
    ; Parameters:
    ;    position - unsigned integer for the entity you want to read. Starts at 0 for first entity
    ;
    ; Return:
    ;    UInt - returns the pixels for the y dimension.
    entityPixelY(position)
    {
        position := this.class_mem.read(0x6FE61C, "UInt", 0x110  + position * 0x20C)
        return position
    }

    ; Method: entityUid(position)
    ;
    ; Author's Note: Entities are "things on the current map". E.g. if another person
    ;                is in the map. This includes monsters. It hasn't been tested how
    ;                often this data is refreshed.
    ;
    ; UID is the unique id of a monster or character. Let's say I want to check the uid
    ; for a sheep:
    ;
    ;          0: Sheep
    ;          1: Iph
    ;
    ; To query, I would run:
    ;  ```
    ;  nexus := new Nexus("warrior")
    ;  nexus.entityUid(0)
    ;  ```
    ; the expected return value would be the uid of the sheep.
    ;
    ; Parameters:
    ;    position - unsigned integer for the entity you want to read. Starts at 0 for first entity
    ;
    ; Return:
    ;    UInt - returns the uid of the entity at the position specified.
    entityUid(position)
    {
        position := this.class_mem.read(0x6FE61C, "UInt", 0x100  + position * 0x20C)
        return position
    }

    ; Method: entityUid(position)
    ;
    ; Author's Note: I have no clue what "count" does for entity. There are actually 3 separate offsets, but
    ;                I have no clue what any of these offsets do, or represent.
    ;
    ; Here are the 3 offsets: 0x424, 0x38, 0xC. I only use offset 0x424. If you know what this does, contact me.
    entityCount(position)
    {
        count := this.class_mem.read(0x6DD4AC, "UInt", 0x424  + position * 0x20C)
        return count
    }

    entityDirection(position)
    {
        count := this.class_mem.read(0x6FE61C, "UInt", 0x1C9  + position * 0x20C)
        return count
    }

    ; Method: groupMemberName(position)
    ;
    ; Parameters:
    ;    position - unsigned integer for the group member you want to read. Starts at 0 for first group member
    ;               (visually, in game it's highest to lowest)
    ;
    ; Example: If you look at your group in nexus, the position ordering is 0 starting at the top, then going down by
    ;          1 each time. Let's say Iph and Craftsman are in a group and either of them opens up the Group tab and see:
    ;
    ;     Iph 100% Vita, 100% Mana
    ;     Craftsman: 100% Vita, 100% Mana
    ;
    ;  If you run:
    ;  ```
    ;  nexus := new Nexus("warrior")
    ;  nexus.groupMemberName(0)
    ;  ```
    ;  You will get `Iph`. If you want craftsman, you would instead use:
    ;  ```
    ;  nexus.groupMemberName(1)
    ;  ```

    ; Return:
    ;    String - Player at position specified
    groupMemberName(position)
    {
       name := this.class_mem.readString(0x6DD490,, encoding := "utf-16", 0x21C+ position * 0x12C)
       if name == Null
       {
          return Null
       }

       position := InStr(name, " [")
       subStrName := SubStr(name, 1, position)
       return subStrName
    }

    ; Method: groupMemberSize()
    ;
    ; Description: Amount of people in the current processes group
    ;
    ; Parameters:
    ;    position - unsigned integer for the group member you want to read. Starts at 0 for first group member
    ;               (visually, in game it's highest to lowest)
    ;
    ; Example: Let's say there are 2 characters in a group:
    ;
    ;     Iph 100% Vita, 100% Mana
    ;     Craftsman: 100% Vita, 100% Mana
    ;
    ;  If you run:
    ;  ```
    ;  nexus := new Nexus("warrior")
    ;  nexus.groupMemberSize()
    ;  ```
    ;  You will get `2`, as there are 2 group members
    ; Return:
    ;    UInt - Amount of players in the group
    groupMemberSize()
    {
       size := this.class_mem.read(0x6DD490, "UInt", 0x3CB0)
       return size
    }

    ; Method: groupMemberUid(position)
    ;
    ; Parameters:
    ;    position - unsigned integer for the group member you want to read. Starts at 0 for first group member
    ;               (visually, in game it's highest to lowest)
    ;
    ; Example: Let's say there are 2 characters in a group:
    ;
    ;     Iph 100% Vita, 100% Mana
    ;     Craftsman: 100% Vita, 100% Mana
    ;
    ;  If you run:
    ;  ```
    ;  nexus := new Nexus("warrior")
    ;  nexus.groupMemberUid(0)
    ;  ```
    ;  You will get the uid of Iph
    ;
    ; Return:
    ;    UInt - Uid of position
    groupMemberUid(position)
    {
       name := this.class_mem.read(0x6DD490, "UInt", 0x218 + position * 0x12C)
       return name
    }

    ; Method: groupMemberCurrentMana(position)
    ;
    ; Parameters:
    ;    position - unsigned integer for the group member you want to read. Starts at 0 for first group member
    ;               (visually, in game it's highest to lowest)
    ;
    ; Example: Let's say there are 2 characters in a group:
    ;
    ;     Iph 100% Vita, 95% Mana - mana is 1.8k / 2k
    ;     Craftsman: 100% Vita, 100% Mana
    ;
    ;  If you run:
    ;  ```
    ;  nexus := new Nexus("warrior")
    ;  nexus.groupMemberCurrentMana(0)
    ;  ```
    ;  You will get 1.8k, which is the current mana of iph.
    ;
    ; Return:
    ;    UInt - current mana of the group member queried.
    groupMemberCurrentMana(position)
    {
       mana := this.class_mem.read(0x6DD490, "UInt", 0x340 + position * 0x12C)
       return mana
    }

    ; Method: groupMemberMaxMana(position)
    ;
    ; Parameters:
    ;    position - unsigned integer for the group member you want to read. Starts at 0 for first group member
    ;               (visually, in game it's highest to lowest)
    ;
    ; Example: Let's say there are 2 characters in a group:
    ;
    ;     Iph 100% Vita, 95% Mana - mana is 1.8k / 2k
    ;     Craftsman: 100% Vita, 100% Mana
    ;
    ;  If you run:
    ;  ```
    ;  nexus := new Nexus("warrior")
    ;  nexus.groupMemberMaxMana(0)
    ;  ```
    ;  You will get 2k, which is the max mana of iph.
    ;
    ; Return:
    ;    UInt - max mana of the group member queried.
    groupMemberMaxMana(position)
    {
       mana := this.class_mem.read(0x6DD490, "UInt", 0x33C + position * 0x12C)
       return mana
    }

    ; Method: groupMemberCurrentVita(position)
    ;
    ; Parameters:
    ;    position - unsigned integer for the group member you want to read. Starts at 0 for first group member
    ;               (visually, in game it's highest to lowest)
    ;
    ; Example: Let's say there are 2 characters in a group:
    ;
    ;     Iph 95% Vita, 100% mana, vita is 1.8k / 2k
    ;     Craftsman: 100% Vita, 100% Mana
    ;
    ;  If you run:
    ;  ```
    ;  nexus := new Nexus("warrior")
    ;  nexus.groupMemberCurrentVita(0)
    ;  ```
    ;  You will get 1.8k, which is the current vita of iph.
    ;
    ; Return:
    ;    UInt - current vita of the group member queried.
    groupMemberCurrentVita(position)
    {
       vita := this.class_mem.read(0x6DD490, "UInt", 0x338 + position * 0x12C)
       return vita
    }

    ; Method: groupMemberMaxVita(position)
    ;
    ; Parameters:
    ;    position - unsigned integer for the group member you want to read. Starts at 0 for first group member
    ;               (visually, in game it's highest to lowest)
    ;
    ; Example: Let's say there are 2 characters in a group:
    ;
    ;     Iph 95% Vita, 100% mana, vita is 1.8k / 2k
    ;     Craftsman: 100% Vita, 100% Mana
    ;
    ;  If you run:
    ;  ```
    ;  nexus := new Nexus("warrior")
    ;  nexus.groupMemberMaxVita(0)
    ;  ```
    ;  You will get 2k, which is the max vita of iph.
    ;
    ; Return:
    ;    UInt - max vita of the group member queried.
    groupMemberMaxVita(position)
    {
       vita := this.class_mem.read(0x6DD490, "UInt", 0x334 + position * 0x12C)
       return vita
    }

    ; Method: targetNpcUid()
    ;
    ; Author's Note: I have no clue what any "target" method does. Good luck.
    targetNpcUid()
    {
        count := this.class_mem.read(0x6FEC64, "UInt", 0)
        return count
    }

    ; Method: targetPlayerUid()
    ;
    ; Author's Note: I have no clue what any "target" method does. Good luck.
    targetPlayerUid()
    {
        count := this.class_mem.read(0x6FEC60, "UInt", 0)
        return count
    }

    ; Method: targetSpellUid()
    ;
    ; Author's Note: I have no clue what any "target" method does. Good luck.
    targetSpellUid()
    {
        count := this.class_mem.read(0x6FEC58, "UInt", 0)
        return count
    }

}vv