var/const/NETWORK_COUPOLE      = "Coupole"
var/const/NETWORK_ADMINISTRATION      = "Administration"
var/const/NETWORK_RESIDENTIELLE     = "Residentielle"
var/const/NETWORK_INDUSTRIELLE  = "Industrielle"
var/const/NETWORK_INGENIERIE  = "Ingenierie"
var/const/NETWORK_SYNTHETIQUE  = "Synthetique"

/datum/map/dreyfus
	// Networks that will show up as options in the camera monitor program
	station_networks = list(
		NETWORK_COUPOLE,
		NETWORK_ADMINISTRATION,
		NETWORK_RESIDENTIELLE,
		NETWORK_INDUSTRIELLE,
		NETWORK_INGENIERIE,
		NETWORK_SYNTHETIQUE,
	)

//
// Cameras
//

// Networks
/obj/machinery/camera/network/coupole
	network = list(NETWORK_COUPOLE)

/obj/machinery/camera/network/administration
	network = list(NETWORK_ADMINISTRATION)

/obj/machinery/camera/network/residentielle
	network = list(NETWORK_RESIDENTIELLE)

/obj/machinery/camera/network/industrielle
	network = list(NETWORK_INDUSTRIELLE)

/obj/machinery/camera/network/ingenierie
	network = list(NETWORK_INGENIERIE)

/obj/machinery/camera/network/synthetique
	network = list(NETWORK_SYNTHETIQUE)
