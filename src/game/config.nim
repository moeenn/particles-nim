import parseopt
from std/strutils import parseInt
import ./common


type
  Config* = object
    appName*: string = "Game"
    screenSize*: Dimensions = Dimensions(width: 800, height: 600)
    particleCount*: int = 1500
    particleSpeedFactor*: int = 1
    lineDistanceThreshold*: int = 50


proc printHelp() = 
  echo "Arguments:"
  echo "\t-p, --particles\tNumber of particles to simulate"
  echo "\t-s, --speed\tParticle speed factor"
  echo "\t-d, --distance\tDistance threshold for line rendering"
  echo "\nExample: particles -p=500 -s=2 -d=50"


proc configFromCommandLineFlags*(): Config =
  var 
    config = Config()
    particles = 100
    speed = 1
    distance = 50

  try:
    for kind, key, value in getOpt():
      case kind
        of cmdArgument:
          discard     

        of cmdLongOption, cmdShortOption:
          case key
            of "p", "particles":
              particles = parseInt(value)
            of "s", "speed":
              speed = parseInt(value)
            of "d", "distance":
              distance = parseInt(value)
            of "h", "help":
              printHelp()
              quit(0)

        of cmdEnd:
          discard

  except Exception as e:
    echo "info: invalid command line argument: ", e.msg
    echo "info: ignoring input and using default value"

  config.particleCount = particles
  config.particleSpeedFactor = speed
  config.lineDistanceThreshold = distance
  return config
