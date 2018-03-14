module Geometry
(
	sphereVolume,
	sphereArea,
	cubeVolume,
	cubeArea,
	cuboiArea,
	cuboiVolume
) where

sphereVolume:: Float -> Float
sphereVolume radius = (4.0 / 3.0) * pi * (radius^3)

sphereArea:: Float -> Float
sphereArea radius = 4 * pi * (radius^2)

cubeVolume:: Float -> Float
cubeVolume side = cuboiVolume side side side

cubeArea:: Float -> Float
cubeArea side = cuboiArea side side side

cuboiVolume:: Float -> Float -> Float -> Float
cuboiVolume a b c = rectArea a b * c

cuboiArea:: Float -> Float -> Float -> Float
cuboiArea a b c = rectArea a b * 2 + rectArea b c * 2 + rectArea c a * 2

rectArea:: Float -> Float -> Float
rectArea a b = a * b
