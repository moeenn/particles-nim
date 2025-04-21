import nico
import std/random
import common
import particle
import line
import config

type 
  State = object
    particles: seq[Particle] = @[]

type 
  Game* = ref object
    config*: Config = Config()
    state: State = State()

proc gameInit(self: Game): proc() = 
  randomize()
  for i in 0..self.config.particleCount:
    var pos = randomPosition(self.config.screenSize)
    var particle = newParticle(pos, self.config.screenSize, self.config.particleSpeedFactor)
    self.state.particles.add(particle)

  return proc () = discard

proc gameUpdate(self: Game): proc(dt: float32) = 
  return proc (dt: float32) =
    for i in 0..<self.state.particles.len:
      self.state.particles[i].update()

proc gameDraw(self: Game): proc() = 
  return proc () =
    cls()
    renderPromixityLines(self.state.particles, self.config.lineDistanceThreshold)
    for particle in self.state.particles:
      particle.render()    

proc run*(self: Game) =
  nico.init(self.config.appName, self.config.appName)
  nico.createWindow(self.config.appName, self.config.screenSize.width, self.config.screenSize.height, 1, false)
  nico.run(self.gameInit(), self.gameUpdate(), self.gameDraw())


export Game
export run
export Config
export configFromCommandLineFlags