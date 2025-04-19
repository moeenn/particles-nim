import ./common

type
  Config* = object
    appName*: string = "Game"
    screenSize*: Dimensions = Dimensions(width: 800, height: 600)
    particleCount*: int = 1500
    particleSpeedFactor*: int = 1
    lineDistanceThreshold*: int = 50
