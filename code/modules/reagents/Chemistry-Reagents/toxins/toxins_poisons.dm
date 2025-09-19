// Poisons are chemicals aimed primarily at hurting or killing people by directly damaging their body.
// This file also includes venoms, because they're also technically poisons.

/datum/reagent/toxin/venom
	name = "Spider Venom"
	description = "A deadly necrotic toxin produced by giant spiders to disable their prey."
	taste_description = "absolutely vile"
	color = "#91d895"
	target_organ = BP_LIVER
	strength = 5

/datum/reagent/toxin/venom/affect_blood(mob/living/carbon/M, alien, removed)
	if (prob(volume*2))
		M.set_confusion_if_lower(5 SECONDS)
	..()

/// Amatoxin is a delayed action poison. On its own, all it does is the Amaspores reagent to its holder mob.
/datum/reagent/toxin/amatoxin
	name = "Amatoxin"
	description = "A powerful poison derived from certain species of mushroom."
	taste_description = "mushroom"
	reagent_state = LIQUID
	metabolism = REM * 0.5
	color = "#792300"

/// Sister reagent to Amatoxin. Does nothing at first, but causes very rapid damage once no Amatoxin is left in the body.
/datum/reagent/toxin/amaspores
	name = "Amaspores"
	description = "The secondary component to amatoxin poisoning, remaining dormant for a time before causing rapid organ and tissue decay."
	taste_description = "dusty dirt"
	reagent_state = LIQUID
	metabolism = REM * 4 // Extremely quick to act once the amatoxin has left the body
	color = "#330e00"



/datum/reagent/toxin/carpotoxin
	name = "Sharkotoxin"
	description = "A neurotoxin found in the flesh of selachians. It causes artery blockages that disrupt blood circulation."
	taste_description = "fish"
	reagent_state = LIQUID
	color = "#003333"
	target_organ = BP_BRAIN // heads up: this doesn't actually get run due to lack of a ..() call in affect_blood. this should be fixed in its own PR
	strength = 10

/datum/reagent/toxin/cyanide
	name = "Cyanide"
	description = "An extremely toxic chemical that causes rapid heart failure in most humanoids."
	taste_mult = 0.6
	reagent_state = LIQUID
	color = "#cf3600"
	strength = 20
	metabolism = REM * 2
	target_organ = BP_HEART
	heating_point = null
	heating_products = null

/datum/reagent/toxin/cyanide/affect_blood(mob/living/carbon/M, alien, removed)
	..()
	M.sleeping += 1



/datum/reagent/toxin/taxine
	name = "Taxine"
	description = "A potent cardiotoxin found in nearly every part of the common yew."
	taste_description = "intense bitterness"
	color = "#6b833b"
	strength = 16
	overdose = REAGENTS_OVERDOSE / 3
	metabolism = REM * 2
	target_organ = BP_HEART
	heating_point = null
	heating_products = null

/datum/reagent/toxin/taxine/affect_blood(mob/living/carbon/M, alien, removed)
	..()
	M.adjust_confusion(1.5 SECONDS)

/datum/reagent/toxin/taxine/overdose(mob/living/carbon/M, alien)
	..()
	if (ishuman(M))
		var/mob/living/carbon/human/H = M
		if (H.stat != UNCONSCIOUS)
			H.Weaken(8)
		M.add_chemical_effect(CE_NOPULSE, 1)



/datum/reagent/toxin/potassium_chloride
	name = "Potassium Chloride"
	description = "A delicious salt that stops the heart in high doses."
	taste_description = "salt"
	reagent_state = SOLID
	color = "#ffffff"
	strength = 0
	overdose = REAGENTS_OVERDOSE
	heating_point = null
	heating_products = null

/datum/reagent/toxin/potassium_chloride/overdose(mob/living/carbon/M, alien)
	..()
	if (ishuman(M))
		var/mob/living/carbon/human/H = M
		if (H.stat != UNCONSCIOUS)
			if (H.losebreath >= 10)
				H.losebreath = max(10, H.losebreath - 10)
			H.adjustOxyLoss(2)
			H.Weaken(10)
		M.add_chemical_effect(CE_NOPULSE, 1)



/datum/reagent/toxin/potassium_chlorophoride
	name = "Potassium Chlorophoride"
	description = "A specific chemical based on potassium chloride to stop the heart for surgery. Not safe to eat!"
	taste_description = "salt"
	reagent_state = SOLID
	color = "#ffffff"
	strength = 10
	overdose = 20
	heating_point = null
	heating_products = null

/datum/reagent/toxin/potassium_chlorophoride/affect_blood(mob/living/carbon/M, alien, removed)
	..()
	if (ishuman(M))
		var/mob/living/carbon/human/H = M
		if (H.stat != UNCONSCIOUS)
			if (H.losebreath >= 10)
				H.losebreath = max(10, M.losebreath-10)
			H.adjustOxyLoss(2)
			H.Weaken(10)
		M.add_chemical_effect(CE_NOPULSE, 1)



/datum/reagent/lexorin
	name = "Lexorin"
	description = "Lexorin temporarily stops respiration, and causes heavy tissue damage."
	taste_description = "acid"
	reagent_state = LIQUID
	color = "#c8a5dc"
	metabolism = REM * 0.5
	overdose = REAGENTS_OVERDOSE
	value = 2.4

/datum/reagent/lexorin/affect_blood(mob/living/carbon/M, alien, removed)
	if (alien == IS_VOX) // Lexorin focuses on removing oxygen from the blood, it wouldn't make sense that these two races are affected
		return
	if (alien == IS_SKRELL)
		M.take_organ_damage(8 * removed, 0, ORGAN_DAMAGE_FLESH_ONLY)
		if (prob(10))
			M.visible_message(
				SPAN_WARNING("\The [M]'s skin fizzles and flakes away!"),
				SPAN_DANGER("Your skin fizzles and flakes away!")
			)
		if (M.losebreath < 45)
			M.losebreath++
	else
		M.take_organ_damage(10 * removed, 0, ORGAN_DAMAGE_FLESH_ONLY)
		if (prob(10))
			M.visible_message(
				SPAN_WARNING("\The [M]'s skin fizzles and flakes away!"),
				SPAN_DANGER("Your skin fizzles and flakes away!")
			)
		if (M.losebreath < 30)
			M.losebreath++
	M.adjustOxyLoss(15 * removed)
/datum/reagent/slime_jelly
	name = "Slime Jelly"
	description = "A gooey semi-liquid produced from one of the deadliest lifeforms in existence. SO REAL."
	taste_description = "slime"
	taste_mult = 1.3
	reagent_state = LIQUID
	color = "#801e28"
	value = 1.2
	should_admin_log = TRUE
