import std/random

type
  Dimensions* = object
    width*: int
    height*: int

type
  Vec2* = object
    x*: int
    y*: int

proc randomPosition*(screenDimensions: Dimensions): Vec2 =
  var x = rand(screenDimensions.width)
  var y = rand(screenDimensions.height)
  return Vec2(x: x, y: y)
