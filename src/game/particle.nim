import nico
import std/random
import math
import ./common


type
  Particle* = object
    pos: Vec2
    color: int = 4
    radius: int = 2
    screenDimensions: Dimensions
    xSpeed: int
    ySpeed: int

proc newParticle*(pos: Vec2, screenDimensions: Dimensions,
    speedFactor: int): Particle =
  var xSpeed = rand(speedFactor)
  var ySpeed = rand(speedFactor)

  var xDirection = rand(2)
  var yDirection = rand(2)

  while xSpeed == 0:
    xSpeed = rand(speedFactor)

  while ySpeed == 0:
    ySpeed = rand(speedFactor)

  return Particle(
    pos: pos,
    screenDimensions: screenDimensions,
    xSpeed: if xDirection mod 2 == 0: xSpeed else: xSpeed * -1,
    ySpeed: if yDirection mod 2 == 0: ySpeed else: ySpeed * -1,
  )

proc update*(self: var Particle) =
  self.pos.x += self.xSpeed
  self.pos.y += self.ySpeed

  if self.pos.x < 0 or self.pos.x > self.screenDimensions.width:
    self.xSpeed *= -1

  if self.pos.y < 0 or self.pos.y > self.screenDimensions.height:
    self.ySpeed *= -1

proc render*(self: Particle) =
  setColor(self.color)
  circfill(self.pos.x, self.pos.y, self.radius)

func getPos*(self: Particle): Vec2 = self.pos

func distance*(self: Particle, other: Particle): int =
  let xDelta = (self.pos.x - other.pos.x) ^ 2
  let yDelta = (self.pos.y - other.pos.y) ^ 2
  return sqrt(float32(xDelta + yDelta)).toInt()
