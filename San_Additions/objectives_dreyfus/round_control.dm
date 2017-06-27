
//hook/startup/proc/initialize_dreyfus_objectives() Los Hook de Startup no son para esto

/datum/controller/gameticker/setup()
	// After the game is setup, we begin the setup of the DreyfusObjectives
	..()
	DreyfusQuotas.times_quota_needed += rand(0,3)	// 0-3 times added to the quota times needed to get greentext
	DreyfusQuotas.new_Objective()

	// OBLIGATORIO poner un return 1 al final de los hooks de inicialización
	return 1

	// Adding at the end of the round - Sansaur
/datum/controller/gameticker/declare_completion()
	..()
	to_world("<br><br><H3> The station needed to complete [DreyfusQuotas.times_quota_needed] quotas for a profitable work day!</H3>")
	to_world("<br><H3> The station completed [DreyfusQuotas.times_quota_reached] quotas!</H3>")
	if(DreyfusQuotas.times_quota_needed > DreyfusQuotas.times_quota_reached)
		to_world("<H4><font color='red'><B>NanoTrasen is not pleased with it's profit.</B></font></H4>")
	else
		to_world("<H4><font color='green'><B>It was a good profitable day for NanoTrasen.</B></font></H4>")

	return 1

