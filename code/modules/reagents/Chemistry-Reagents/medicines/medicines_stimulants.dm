/*
 * For our purposes, a "stimulant" is any medicine that reduces stuns, speeds you up, and generally makes you zoomy.
 * These can be very touchy for balance, which is why we categorize them so specifically.
 * Stimulants generally metabolize extremely slowly and have a low overdose threshold.
 */
/datum/reagent/medicine/stimulant
	metabolism = REM * 0.05
	overdose = REAGENTS_OVERDOSE * 0.5

/datum/reagent/medicine/stimulant/synaptizine
	name = "Synaptizine"
	description = "Synaptizine is a strong neuromuscular stimulant. It is potent, but also very toxic to the body, especially in doses higher than a few units."
	color = "#99ccff"
	overdose = REAGENTS_OVERDOSE / 6
	value = 4.6



/datum/reagent/medicine/stimulant/hyperzine
	name = "Hyperzine"
	description = "Hyperzine is a highly effective, long lasting muscle stimulant."
	taste_description = "acid"
	color = "#ff3300"
	metabolism = REM * 0.15
	value = 3.9
