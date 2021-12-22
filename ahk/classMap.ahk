MAP_TRAVERSABLE := 0
MAP_BLOCKED := 1
MAP_OCCUPIED := 2

; MapTile is a basic internal class to figure out where the edge or block objects
; are. This helps the MapManager make correct decisions using A* to reach the tile.
class MapTile {
    static state, x, y
    __new(state, x, y)
    {
        this.state := state
        this.x := x
        this.y := y
    }
}

class Map {
    static map

    __new(nexus_class) {
        this.map := []
        i := 0

        ; I assume the max height / width
        loop 500 {
            inner_map := []
            i := 0
            loop 500 {
                inner_map.Push(0)
                i++
            }
            this.map.Push(inner_map)
            
        }
    }

    AddEntityData(uid, x, y) {
        if (this.entityMapper.HasKey(uid)) {
            positions := this.entityMapper[uid]

            if (positions.Length > 0) {
                last_datapoint := positions[positions.Length]
                if (last_datapoint.x == x && last_datapoint.y == y) {
                    ; This is the same data as the last entry, don't add to the ring.
                    return
                }
            }
        }

        positions := []
        positions.Push(new EntityPosition(uid, x, y))
        this.entityMapper[uid] = positions
        return
    }

    GetData(uid) {
        if (this.entityMapper.HasKey(uid)) {
            return this.entityMapper[uid]
        }

        return Null
    }
}