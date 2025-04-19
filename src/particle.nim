import nico
import std/random
import ./common

type
  Particle* = ref object
    pos: Vec2
    color: int = 4
    radius: int = 3
    screenDimensions: Dimensions
    xSpeed: int
    ySpeed: int

proc NewParticle*(pos: Vec2, screenDimensions: Dimensions,
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

proc update*(self: Particle) =
  self.pos.x += self.xSpeed
  self.pos.y += self.ySpeed

  if self.pos.x < 0 or self.pos.x > self.screenDimensions.width:
    self.xSpeed *= -1

  if self.pos.y < 0 or self.pos.y > self.screenDimensions.height:
    self.ySpeed *= -1

proc render*(self: Particle) =
  setColor(self.color)
  circfill(self.pos.x, self.pos.y, self.radius)