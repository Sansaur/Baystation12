/*
Descomentado para hacer la prueba.
*/
/mob/verb/barra_do_verb(message as text)
	set name = "Do"
	set category = "IC"

	if(typing_indicator)
		qdel(typing_indicator)

	// Jajajajaj, esto se puede usar hasta durmiendo xD lol
	if(message)
		src.visible_message("<font color='#005500'><B>\[[src]\]</B> [message]</font>")
