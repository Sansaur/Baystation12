/obj/machinery/drone_fabricator/dreyfus
	fabricator_tag = "Entretien SSNI Dreyfus"

/obj/machinery/drone_fabricator/dreyfus/adv
	name = "advanced drone fabricator"
	fabricator_tag = "Entretien SSNI Dreyfus"
	drone_type = /mob/living/silicon/robot/drone/construction

/obj/machinery/telecomms/relay/preset/coupole
	id = "Relais Coupole"
	autolinkers = list("c_relay")

/obj/machinery/telecomms/relay/preset/administration
	id = "Relais Administration"
	autolinkers = list("a_relay")

/obj/machinery/telecomms/relay/preset/residentiel
	id = "Relais Residentiel"
	autolinkers = list("r_relay")

/obj/machinery/telecomms/relay/preset/industriel
	id = "Relais Industriel"
	autolinkers = list("i_relay")

/obj/machinery/telecomms/relay/preset/fauxpont
	id = "Relais Synthetique"
	autolinkers = list("s_relay")