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

class Entity {
    static x, y, uid, name
    __new(uid, name, x, y)
    {
        this.uid := uid
        this.name := name
        this.x := x
        this.y := y
    }
}

class Point {
    static x, y
    __new(x, y)
    {
        this.x := x
        this.y := y

    }
}


class Path {
   static positions, cost

   __new(pos, c)
   {
      this.positions := pos
      this.cost := c
   }

   add(position)
   {
      this.positions.Push(position)
      this.cost += 1
   }

   latest()
   {
      return this.positions[this.positions.Length()]
   }

   clone()
   {
      newPositions := []
      for index, item in this.positions
      {
          newPositions.Push(new Point(item.x, item.y))
      }

      newPath := new Path(newPositions, this.cost)
      return newPath
   }
}

class MapManager {
    static map, entities, maxWidth, maxHeight

    __new(maxWidth, maxHeight) {
        this.maxWidth := maxWidth
        this.maxHeight := maxHeight
        ; I assume the max height / width
        this.map := []
        loop %maxWidth% {
            inner_map := []
            i := 0
            loop %maxHeight% {
                inner_map.Push(0)
                i++
            }
            this.map.Push(inner_map)
        }
    }

    newEntityMap() {
        map := []
        ; I assume the max height / width
        i := 1
        maxWidth := this.maxWidth
        maxHeight := this.maxHeight
        loop %maxWidth% {
            inner_map := []
            j := 1
            loop %maxHeight% {
               val := this.map[i][j]
               inner_map.Push(val)
               j++
            }
            map.Push(inner_map)
            i++
        }
        return map
    }

    printMap(map, x, y)
    {
        i := 1
        maxWidth := this.maxWidth
        maxHeight := this.maxHeight
        loop %maxWidth% {
            j := 1
            loop %maxHeight% {
                if (x = i && y = j) {
                   LV_Add("", i, j, 9999)
                } else
                {
                    LV_Add("", i, j, map[i][j])
                }

                j++
            }
            i++
        }
    }

    UpdatePosition(x, y, value) {
        self.map[x][y] = value
    }

    FindBestPath(currentX, currentY, goalX, goalY)
    {
        map := this.newEntityMap()
        ;this.printMap(map, currentX, currentY)
        currentCost := this.ManhattenCost(currentX, currentY, goalX, goalY)
        point := new Point(currentX, currentY)

        points := [point]
        path := new Path(points, 0)

        queue := [path]
        map[currentX][currentY] := 1
        loop
        {
           LV_Delete()

           if (queue.Length() == 0)
           {
              break ; found nothing, not possible
           }

           index := this.FindLowestCost(queue)

           ; current lowest cost movement.
           lowestPath := queue.RemoveAt(index)

           latest := lowestPath.latest()
           ;this.printMap(map, latest.x, latest.y)
           ; if not at goal, add possible entries.
           if(latest.x = goalX and latest.y = goalY)
           {
              ; we found the lowest path
              return lowestPath
           }

           ; check to move left
           proposedX := latest.x-1
           proposedY := latest.y
           if (proposedX != 0 and map[proposedX][proposedY] = 0)
           {
               map[proposedX][proposedY] := 1
               path := lowestPath.clone()
               path.add(new Point(proposedX, proposedY))
               queue.Push(path)
           }

           ; check to move right
           proposedX := latest.x+1
           proposedY := latest.y
           if (proposedX <= this.maxWidth and map[proposedX][proposedY] = 0)
           {
               map[proposedX][proposedY] := 1
               path := lowestPath.clone()
               path.add(new Point(proposedX, proposedY))
               queue.Push(path)
           }

           ; check to move up
           proposedX := latest.x
           proposedY := latest.y -1
           if (proposedY != 0 and map[proposedX][proposedY] = 0)
           {
               map[proposedX][proposedY] := 1
               path := lowestPath.clone()
               path.add(new Point(proposedX, proposedY))
               queue.Push(path)
           }

           ; check to move down
           proposedX := latest.x
           proposedY := latest.y + 1
           if (proposedY <= this.maxHeight and map[proposedX][proposedY] = 0)
           {
               map[proposedX][proposedY] := 1
               path := lowestPath.clone()
               path.add(new Point(proposedX, proposedY))
               queue.Push(path)
           }
        }

    }


    ManhattenCost(x,y, x2, y2)
    {
        xDistance := Abs(entity.x-x)
        yDistance := Abs(entity.y-y)
        totalCost := xDistance + yDistance
        return totalCost
    }

    FindLowestCost(queue)
    {
        lowestCost := 9999
        lowestPosition := -1
        For index, element in queue
        {
            if (element.cost < lowestCost)
            {
               lowestPosition := index
               lowestCost := element.cost
            }
        }

        return lowestPosition
    }

    FindClosestPosition(x,y, entities)
    {
        i := 1
        minDistance := 9999
        bestPosition := 0
        len := entities.Length()-1
        loop %len%
        {
            entity := entities[i]

            ; There is no such thing as a guid of 0, it means you have hit "null space"
            ; and have exceeded the entity system
            xDistance := Abs(entity.x-x)
            yDistance := Abs(entity.y-y)

            if (minDistance > xDistance + yDistance)
            {
                minDistance := xDistance+yDistance
                bestPosition := i
            }

            i++

        }
        return bestPosition
    }

}