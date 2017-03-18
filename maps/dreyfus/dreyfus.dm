#if !defined(USING_MAP_DATUM)

	//CONTENT
	#include "items/storage.dm"
	#include "structures/airlock.dm"
	#include "structures/closet.dm"
	#include "structures/curtains.dm"
	#include "structures/flooring.dm"
	#include "structures/flooring_decals.dm"
	#include "structures/flooring_premades.dm"
	#include "structures/furniture.dm"
	#include "structures/gym.dm"
	#include "structures/tile_types.dm"
	#include "structures/wall_icons.dm"
	#include "structures/walls.dm"

	#define USING_MAP_DATUM /datum/map/dreyfus

#elif !defined(MAP_OVERRIDE)

	#warn A map has already been included, ignoring Dreyfus
#endif
