/*
Tajaran frontflip proof of concept

Design:

1) Using the inherent verbs, we'll create a proc that will be added to the Taajran
2) This allows him to move 3 squares in front of where he's facing, he'll be able to jump over determinate dense objects in the whole trajectory
3) Can crash against walls and dense objects by checking if a dense object or a dense turf is in it's way, if it is, it'll stop in the tile before it.

Possibilites:

1- Backflips too.

*/

/datum/species/tajaran
	heat_discomfort_level = 308
	slowdown = -0.2

	heat_level_1 = 292 //Default 330
	heat_level_2 = 380 //Default 380
	heat_level_3 = 800 //Default 800
