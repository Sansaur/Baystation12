/datum/map/dreyfus
	branch_types = list(
		/datum/mil_branch/ouvrier,
		/datum/mil_branch/contractuel,
		/datum/mil_branch/administration
	)

	spawn_branch_types = list(
		/datum/mil_branch/ouvrier,
		/datum/mil_branch/contractuel,
		/datum/mil_branch/administration
	)

	species_to_branch_whitelist = list(
		/datum/species/vox     = list()
	)

	species_to_branch_blacklist = list(
		/datum/species/machine = list(/datum/mil_branch/administration),
		/datum/species/diona   = list(/datum/mil_branch/administration),
		/datum/species/tajaran   = list(/datum/mil_branch/administration),
		/datum/species/unathi   = list(/datum/mil_branch/administration)
	)

/datum/mil_branch/ouvrier
	name = "Obrero"
	name_short = "OBR"
	email_domain = "extraposte.free.nt"

	assistant_job = "Pasajero"

/datum/mil_branch/contractuel
	name = "Contratista"
	name_short = "CTRAT"
	email_domain = "gocourriel.uni.nt"

	assistant_job = "Aprendiz"

/datum/mil_branch/administration
	name = "Ejecutivos"
	name_short = "ADMIN"
	email_domain = "intranet.nano"

	assistant_job = "Secretario"