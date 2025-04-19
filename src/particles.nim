import game/game


proc main() =
  let config = game.configFromCommandLineFlags()
  var game = game.Game(config: config)
  game.run()


when isMainModule:
  main()
