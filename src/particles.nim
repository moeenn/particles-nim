import ./game/game
import ./game/config


proc main() =
  var config = Config(
    particleCount: 100,
    particleSpeedFactor: 1,
    lineDistanceThreshold: 50,
  )

  var game = Game(config: config)
  game.run()


when isMainModule:
  main()
