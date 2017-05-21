//Pont residentiel

/area/dreyfus/residentiel/dock/couloir
	name = "Sortie Amarrage"
	icon_state = "dark128"
	sound_env = HALLWAY

/area/dreyfus/residentiel/dock/toilettes
	name = "Toilettes Amarrage"
	icon_state = "toilet"
	sound_env = BATHROOM

/area/dreyfus/residentiel/hub/couloir
	name = "Couloir Hub Résidentiel"
	icon_state = "dark128"
	sound_env = HALLWAY

/area/dreyfus/residentiel/hub/concierge
	name = "Stockage Entretien"
	icon_state = "janitor"
	sound_env = SMALL_ENCLOSED

/area/dreyfus/residentiel/sejour/couloir
	name = "Couloir Séjour"
	icon_state = "dark128"
	sound_env = HALLWAY

/area/dreyfus/residentiel/sejour/cryo
	name = "Salle de Cryogénie"
	icon_state = "cryo"
	sound_env = SMALL_SOFTFLOOR

/area/dreyfus/residentiel/sejour/gym
	name = "Salle de Fitness"
	icon_state = "fitness"
	sound_env = MEDIUM_SOFTFLOOR

/area/dreyfus/residentiel/sejour/cafet
	name = "Cantine"
	icon_state = "cafeteria"
	sound_env = STANDARD_STATION

/area/dreyfus/residentiel/sejour/cuisine
	name = "Cuisine"
	icon_state = "kitchen"
	sound_env = MEDIUM_SOFTFLOOR

/area/dreyfus/residentiel/sejour/vestiaire
	name = "Vestiaires"
	icon_state = "crew_quarters"
	sound_env = MEDIUM_SOFTFLOOR

/area/dreyfus/residentiel/quartiers/couloir
	name = "Accés Quartiers"
	icon_state = "dark128"
	sound_env = TUNNEL_ENCLOSED

/area/dreyfus/residentiel/quartiers/chambre1
	name = "Chambre 1"
	icon_state = "crew_quarters"
	sound_env = SMALL_SOFTFLOOR

/area/dreyfus/residentiel/quartiers/chambre2
	name = "Chambre 2"
	icon_state = "crew_quarters"
	sound_env = SMALL_SOFTFLOOR

/area/dreyfus/residentiel/quartiers/chambre3
	name = "Chambre 3"
	icon_state = "crew_quarters"
	sound_env = SMALL_SOFTFLOOR

/area/dreyfus/residentiel/clinique/reception
	name = "Réception"
	icon_state = "medbay3"
	sound_env = SMALL_SOFTFLOOR

/area/dreyfus/residentiel/clinique/urgences
	name = "Accés Urgences"
	icon_state = "medbay4"
	sound_env = STANDARD_STATION

/area/dreyfus/residentiel/clinique/traitement
	name = "Salle de Traitement"
	icon_state = "medbay"
	sound_env = MEDIUM_SOFTFLOOR

/area/dreyfus/residentiel/clinique/laboratoire
	name = "Laboratoire Médicale"
	icon_state = "medbay2"
	sound_env = STANDARD_STATION

/area/dreyfus/residentiel/clinique/chirurgie
	name = "Salle d'Opération"
	icon_state = "medbay2"
	sound_env = STANDARD_STATION

/area/dreyfus/residentiel/clinique/patients
	name = "Salle de Repos"
	icon_state = "patients"
	sound_env = MEDIUM_SOFTFLOOR

/area/dreyfus/residentiel/clinique/vestiaire
	name = "Vestiaires Clinique"
	icon_state = "medbay"
	sound_env = STANDARD_STATION

/area/dreyfus/residentiel/clinique/repos
	name = "Salle de Détente"
	icon_state = "medbay2"
	sound_env = MEDIUM_SOFTFLOOR

/area/dreyfus/residentiel/clinique/morgue
	name = "Morgue"
	icon_state = "morgue"
	sound_env = SMALL_ENCLOSED

//Pont ingénierie

/area/dreyfus/ingenierie/moteur/atmos
	name = "Systemes de Survie"
	icon_state = "atmos"

/area/dreyfus/ingenierie/moteur
	name = "Generateur"
	icon_state = "engine"

/area/dreyfus/ingenierie/moteur/SMES
	name = "Stockage Energetique"
	icon_state = "engine_smes"

/area/dreyfus/ingenierie/moteur/controle
	name = "Salle de Controle Generateur"
	icon_state = "engine_monitoring"

/area/dreyfus/ingenierie/moteur/acces
	name = "Maintenance Generateur"
	icon_state = "maint_engine"

/area/dreyfus/ingenierie/maintenance
	name = "Maintenance Ingenierie"
	icon_state = "maint_engineering"

/area/dreyfus/ingenierie/acces
	name = "Accés Ingenierie"
	icon_state = "engineering_foyer"

/area/dreyfus/ingenierie/controle
	name = "Salle de Controle Station"
	icon_state = "engine_monitoring"

/area/dreyfus/ingenierie/equipement
	name = "Vestiaires Ingenierie"
	icon_state = "engineering_locker"

/area/dreyfus/ingenierie/EVA
	name = "Salle de stockage SEV"
	icon_state = "eva"

/area/dreyfus/ingenierie/quartiers
	name = "Quartiers Ingenierie"
	icon_state = "crew_quarters"

/area/dreyfus/ingenierie/telecomm
	name = "Telecommunications"
	icon_state = "tcomsatcham"

/area/dreyfus/ingenierie/detente
	name = "Salle de Detente Ingenierie"
	icon_state = "engineering_break"

//Turbolift
/area/turbolift
	name = "\improper Turbolift"
	icon_state = "shuttle"
	requires_power = 0
	lighting_use_dynamic = 1
	flags = AREA_RAD_SHIELDED

/area/turbolift/start
	name = "\improper Turbolift Start"

/area/turbolift/bridge
	name = "\improper bridge"
	base_turf = /turf/simulated/open

/area/turbolift/firstdeck
	name = "\improper first deck"
	base_turf = /turf/simulated/open

/area/turbolift/seconddeck
	name = "\improper second deck"
	base_turf = /turf/simulated/open

/area/turbolift/thirddeck
	name = "\improper third deck"
	base_turf = /turf/simulated/open

/area/turbolift/fourthdeck
	name = "\improper fourth deck"
	base_turf = /turf/simulated/floor/plating