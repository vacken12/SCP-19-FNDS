/*
Contians the proc to handle radiation.
Specifically made to do radiation burns.
*/


/mob/living/carbon/apply_radiation(damage)
	..()

	if(species && !isSynthetic())

	updatehealth()
	return TRUE
