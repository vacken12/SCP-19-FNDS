// Medicines that deviate from the norm in their effects. They might manipulate the immune system, or so on.

// Adrenaline is technically a stimulant, but it's special because humans produce it on their own when taking high damage.
/datum/reagent/medicine/adrenaline
	name = "Adrenaline"
	description = "Adrenaline is a hormone used as a drug to treat cardiac arrest and other cardiac dysrhythmias resulting in diminished or absent cardiac output."
	taste_description = "rush"
	color = "#c8a5dc"
	metabolism = REM * 0.5
	value = 2



/datum/reagent/lactic_acid
	name = "Lactic Acid"
	description = "Also called lactate, lactic acid is produced by the body during strenuous exercise. It often correlates with elevated heart rate, shortness of breath, and general exhaustion."
	taste_description = "sourness"
	color = "#eeddcc"



/datum/reagent/medicine/penicillin
	name = "Penicillin"
	description = "An all-purpose antiviral agent. Prevents most diseases from progressing further."
	color = "#c1c1c1"
	metabolism = REM * 0.1
	overdose = REAGENTS_OVERDOSE * 0.5
	value = 2.5
	var/antiviral_multiplier = 1

/datum/reagent/medicine/penicillin/affect_blood(mob/living/carbon/M, alien, removed)
	M.immunity = max(M.immunity - 0.1, 0)
	M.add_chemical_effect(CE_ANTIVIRAL, ANTIVIRAL_WEAK * antiviral_multiplier)
	M.add_chemical_effect(CE_ANTIBIOTIC, 1)
	if (volume > 10)
		M.immunity = max(M.immunity - 0.3, 0)
		M.add_chemical_effect(CE_ANTIVIRAL, ANTIVIRAL_MEDIUM * antiviral_multiplier)
	if (M.chem_doses[type] > 15)
		M.immunity = max(M.immunity - 0.25, 0)

/datum/reagent/medicine/penicillin/overdose(mob/living/carbon/M, alien)
	..()
	M.immunity = max(M.immunity - 0.25, 0)
	M.add_chemical_effect(CE_ANTIVIRAL, ANTIVIRAL_STRONG * antiviral_multiplier)
	if (prob(2))
		M.immunity_norm = max(M.immunity_norm - 1, 0)

// Uncraftable silly chemical that stops pretty much every disease
/datum/reagent/medicine/penicillin/spaceacillin
	name = "Spaceacillin"
	description = "A powerful antiviral agent derived from unknown reagents. This seems rather futuristic"
	color = "#b6d9db"
	value = 4
	antiviral_multiplier = 2


/datum/reagent/medicine/immunobooster
	name = "Immunobooster"
	description = "A drug that helps restore the immune system. Will not replace a normal immunity, and is toxic when taken with penicillin."
	taste_description = "chalk"
	color = "#ffc0cb"
	value = 1.5
/datum/reagent/medicine/immunobooster/overdose(mob/living/carbon/M, alien)
	..()
	M.add_chemical_effect(CE_TOXIN, 1)
	M.immunity -= 0.5 // inverse effects when abused


/datum/reagent/medicine/leporazine
	name = "Leporazine"
	description = "Leporazine can be use to stabilize an individuals body temperature."
	color = "#c8a5dc"
	chilling_products = list(/datum/reagent/medicine/leporazine/cold)
	chilling_prod_english = "<span codexlink='cryogenic leporazine (chemical)'>cryogenic leporazine</span>"
	chilling_point = -10 CELSIUS
	chilling_message = "Takes on the consistency of slush."
	heating_products = list(/datum/reagent/medicine/leporazine/hot)
	heating_prod_english = "<span codexlink='pyrogenic leporazine (chemical)'>pyrogenic leporazine</span>"
	heating_point = 110 CELSIUS
	heating_message = "starts swirling, glowing occasionally."
	value = 2

/datum/reagent/medicine/leporazine/affect_blood(mob/living/carbon/M, alien, removed)
	if (M.bodytemperature > 310)
		M.bodytemperature = max(310, M.bodytemperature - (40 * TEMPERATURE_DAMAGE_COEFFICIENT))
	else if (M.bodytemperature < 311)
		M.bodytemperature = min(310, M.bodytemperature + (40 * TEMPERATURE_DAMAGE_COEFFICIENT))

/datum/reagent/medicine/leporazine/hot
	name = "Pyrogenic Leporazine"
	chilling_products = list(/datum/reagent/medicine/leporazine)
	chilling_prod_english = "<span codexlink='leporazine (chemical)'>leporazine</span>"
	chilling_point = 0 CELSIUS
	chilling_message = "Stops swirling and glowing."
	heating_products = null
	heating_point = null
	heating_message = null

/datum/reagent/medicine/leporazine/hot/affect_blood(mob/living/carbon/M, alien, removed)
	if (M.bodytemperature < 330)
		M.bodytemperature = min(330, M.bodytemperature + (40 * TEMPERATURE_DAMAGE_COEFFICIENT))

/datum/reagent/medicine/leporazine/cold
	name = "Cryogenic Leporazine"
	chilling_products = null
	chilling_point = null
	chilling_message = null
	heating_products = list(/datum/reagent/medicine/leporazine)
	heating_prod_english = "<span codexlink='leporazine (chemical)'>leporazine</span>"
	heating_point = 100 CELSIUS
	heating_message = "Becomes clear and smooth."

/datum/reagent/medicine/leporazine/cold/affect_blood(mob/living/carbon/M, alien, removed)
	if (M.bodytemperature > 290)
		M.bodytemperature = max(290, M.bodytemperature - (40 * TEMPERATURE_DAMAGE_COEFFICIENT))



/datum/reagent/medicine/ryetalyn
	name = "Ryetalyn"
	description = "Ryetalyn can cure all genetic abnomalities via a catalytic process."
	taste_description = "acid"
	reagent_state = SOLID
	color = "#004000"
	value = 3.6

/datum/reagent/medicine/ryetalyn/affect_blood(mob/living/carbon/M, alien, removed)
	var/needs_update = M.mutations.len > 0

	M.disabilities = 0
	M.sdisabilities = 0

	if (needs_update && ishuman(M))
		M.dna.ResetUI()
		M.dna.ResetSE()
		domutcheck(M, null, MUTCHK_FORCED)



/datum/reagent/medicine/rezadone
	name = "Rezadone"
	description = "A powder with almost magical properties, this substance can effectively treat genetic damage in humanoids, though excessive consumption has side effects."
	taste_description = "sickness"
	reagent_state = SOLID
	color = "#669900"
	value = 5

/datum/reagent/medicine/rezadone/affect_blood(mob/living/carbon/M, alien, removed)
	M.adjustCloneLoss(-20 * removed)
	M.adjustOxyLoss(-2 * removed)
	M.heal_organ_damage(20 * removed, 20 * removed)
	M.adjustToxLoss(-20 * removed)
	if (M.chem_doses[type] > 3 && ishuman(M))
		var/mob/living/carbon/human/H = M
		for (var/obj/item/organ/external/E in H.organs)
			E.status |= ORGAN_DISFIGURED //currently only matters for the head, but might as well disfigure them all.
	if (M.chem_doses[type] > 10)
		M.adjust_dizzy(5 SECONDS)
		M.adjust_jitter(5 SECONDS * removed)
