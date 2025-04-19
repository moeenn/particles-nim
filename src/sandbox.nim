import nico
import std/random
import ./common
import ./particle
import ./line


const APP_NAME = "Game"
const SCREEN_SIZE = Dimensions(width: 800, height: 600)
const PARTICLE_COUNT = 1500
const PARTICLE_SPEED_FACTOR = 1
const LINE_DISTANCE_THRESHOLD = 50
var particles: seq[Particle] = @[]


proc gameInit() =
  randomize()
  for i in 0..PARTICLE_COUNT:
    var pos = randomPosition(SCREEN_SIZE)
    var particle = newParticle(pos, SCREEN_SIZE, PARTICLE_SPEED_FACTOR)
    particles.add(particle)


proc gameUpdate(dt: float32) =
  for particle in particles:
    particle.update()


proc gameDraw() =
  cls()
  renderPromixityLines(particles, LINE_DISTANCE_THRESHOLD)
  for particle in particles:
    particle.render()


proc main() =
  nico.init(APP_NAME, APP_NAME)
  nico.createWindow(APP_NAME, SCREEN_SIZE.width, SCREEN_SIZE.height, 1, false)
  nico.run(gameInit, gameUpdate, gameDraw)


when isMainModule:
  main()
