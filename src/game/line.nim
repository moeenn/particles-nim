import nico
import ./particle
import ./common

proc renderLine(startPos, endPos: Vec2, color: int = 3) =
  setColor(color)
  line(startPos.x, startPos.y, endPos.x, endPos.y)

proc renderPromixityLines*(particles: seq[Particle], distanceThreshold: int) =
  if particles.len == 0:
    return

  var i = 0
  var j = 1
  var a, b: Particle

  while i < j:
    a = particles[i]
    b = particles[j]

    if a.distance(b) <= distanceThreshold:
      renderLine(a.getPos(), b.getPos())

    j += 1
    if j == particles.len:
      i += 1
      j = i + 1

    if i == particles.len-1:
      break
