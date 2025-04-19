import nico
import std/random
import ./common
import ./particle
import ./line

type
  Config = object
    orgName: string = "Game"
    appName: string = "Game"
    screen: Dimensions = Dimensions(width: 800, height: 600)
    particleCount: int = 1000
    particleSpeedFactor: int = 2

type
  State = ref object
    particles: seq[Particle] = @[]
    lines: seq[Line] = @[]


const config = Config()
var state = State()


proc gameInit() =
  randomize()
  for i in 0..config.particleCount:
    var pos = RandomPosition(config.screen)
    var particle = NewParticle(pos, config.screen, config.particleSpeedFactor)
    state.particles.add(particle)


proc gameUpdate(dt: float32) =
  for particle in state.particles:
    particle.update()


proc gameDraw() =
  cls()

  for particle in state.particles:
    particle.render()



proc main() =
  nico.init(config.orgName, config.appName)
  nico.createWindow(config.appName, config.screen.width, config.screen.height, 1, false)
  nico.run(gameInit, gameUpdate, gameDraw)


when isMainModule:
  main()
