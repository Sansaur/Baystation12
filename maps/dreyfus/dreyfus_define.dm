
/datum/map/curie
	name = "Dreyfus"
	full_name = "SSNI Dreyfus"
	path = "dreyfus"

	lobby_icon = 'maps/dreyfus/dreyfus_lobby.dmi'

	station_name  = "SSNI Dreyfus"
	station_short = "Dreyfus"
	dock_name     = "Upsilon-4"
	boss_name     = "Central Headquarter"
	boss_short    = "CHQ"
	company_name  = "NanoTrasen Industries & Co"
	company_short = "NTI"

	shuttle_docked_message = "La navette de roulement arrivée de %Dock_name% s'est amarée à la station. Départ dans %ETD%"
	shuttle_leaving_dock = "La navette de roulement d'équipage s'est désamarée. Arrivé estimée dans %ETA%."
	shuttle_called_message = "Un roulement d'équipage vers %Dock_name% viens d'être planifié. Une navette de transfert a été appelée. Elle arrivera dans approximativement %ETA%"
	shuttle_recall_message = "Le roulement de l'équipage a été annulé."
	emergency_shuttle_docked_message = "La navette d'évacuation s'est amarrée à la station. Vous êtes prié d'évacuer d'ici %ETD%."
	emergency_shuttle_leaving_dock = "La navette d'évacuation s'est désamarée. Arrivé estimée dans %ETA%."
	emergency_shuttle_called_message = "La navette d'évacuation a été appelée. Elle arrivera dans approximativement %ETA%"
	emergency_shuttle_recall_message = "La navette d'évacuation a été rappelée. Le coût de cette manoevre sera déduit directement de vos salaires."

	evac_controller_type = /datum/evacuation_controller/shuttle