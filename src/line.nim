import nico
import ./common

type
  Line* = ref object
    startPos: ref Vec2
    endPos: ref Vec2
    color: int = 3

func NewLine*(startPos, endPos: ref Vec2): Line =
  return Line(startPos: startPos, endPos: endPos)

func update*(self: Line, startPos, endPos: ref Vec2) =
  self.startPos = startPos
  self.endPos = endPos

proc render*(self: Line) =
  setColor(self.color)
  line(self.startPos.x, self.startPos.y, self.endPos.x, self.endPos.y)