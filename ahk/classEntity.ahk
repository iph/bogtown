class EntityPosition {
    static uid, x, y
    __new(uid, x, y)
    {
        this.uid := uid
        this.x := x
        this.y := y
    }
}

class PositionTracker {
    static entityMapper, nexusClient, nameMapper

    __new(nexusClient)
    {
        this.entityMapper := {}
        this.nameMapper := {}
        this.nexusClient = nexusClient
        this.refresh()
    }

    Refresh()
    {
        i := 0
        loop
        {
            entityName := nexus.entityName(i)
            uid := nexus.entityUid(i)
            position := new EntityPosition(uid, x, y)
            this.entityMapper[uid] := position

            if entityName != Null
            {
                this.nameMapper[name] := position
            }
            ; There is no suc thing as a guid of 0, it means you have hit "null space"
            ; and have exceeded the entity system
            if (uid < 1)
            {
                break
            }

            i++
        }
     return ; not found
    }


    playerX(name)
    {
         if (this.nameMapper.HasKey(name)) {
             return this.nameMapper[name].x
         }

         return 0
    }

    playerY(name)
    {
         if (this.nameMapper.HasKey(name)) {
             return this.nameMapper[name].y
         }

         return 0
    }
    FindUidX(uid)
    {
         if (this.entityMapper.HasKey(uid)) {
             return this.nameMapper[uid].x
         }

         return 0
    }

    FindUidY(uid)
    {
         if (this.entityMapper.HasKey(uid)) {
             return this.nameMapper[uid].y
         }

         return 0
    }


}