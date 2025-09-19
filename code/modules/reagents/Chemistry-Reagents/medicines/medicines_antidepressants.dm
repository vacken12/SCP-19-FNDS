#define ANTIDEPRESSANT_MESSAGE_DELAY (5 MINUTES)
/**
 * Antidepressants are meant to primarily heal sanity damage dealt to one's mind
 * although over some time.
 * Other effects depend on subtype.
 */

/datum/reagent/medicine/antidepressant
	ingest_met = REM
	metabolism = REM
	overdose = 10


/datum/reagent/medicine/antidepressant/citalopram
	name = "Citalopram"
	description = "Stabilizes the mind a little."
	color = "#ff80ff"
	value = 6

/datum/reagent/medicine/antidepressant/paroxetine
	name = "Paroxetine"
	description = "Stabilizes the mind greatly, but has a chance of adverse effects."
	color = "#ff80bf"
	value = 3.5
/datum/reagent/medicine/antidepressant/methylphenidate
	name = "Methylphenidate"
	description = "Improves the ability to concentrate."
	taste_description = "sourness"
	color = "#bf80bf"
	value = 6
/datum/reagent/medicine/antidepressant/anomalous_happiness
	name = "Anomalous happiness"
	description = "Poorly-understood parachemicals produced while around certain anomalies."
	taste_description = "happiness"
	color = "#f7f97a"
	value = 10
	hidden_from_codex = TRUE

/datum/reagent/medicine/antidepressant/anomalous_happiness/affect_blood(mob/living/carbon/M, alien, removed)
	M.add_chemical_effect(CE_SANITY, 2)
	if (world.time > data + 1 MINUTE)
		data = world.time
		M.emote(pick("smile","grin"))
