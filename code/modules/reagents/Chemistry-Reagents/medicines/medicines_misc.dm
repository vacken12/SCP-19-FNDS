// Medicines in this file have no obvious other place to go.
// It differs from medicines_special.dm in that they just don't have a place, instead of being very unique.

/datum/reagent/medicine/noexcutite
	name = "Noexcutite"
	description = "A thick, syrupy liquid that has a lethargic effect. Used to cure cases of jitteriness."
	taste_description = "numbing coldness"
	color = "#bc018a"

/datum/reagent/medicine/ethylredoxrazine
	name = "Ethylredoxrazine"
	description = "A powerful oxidizer that reacts with ethanol."
	reagent_state = SOLID
	color = "#605048"
	value = 3.1

/datum/reagent/medicine/naltrexone
	name = "Naltrexone"
	description = "A medication primarily used to manage alcohol, opioid and other minor drug addictions. Should not be taken in cases of liver damage."
	reagent_state = LIQUID
	color = "#f0e962"
	value = 3.1
	/// List of addiction type paths and amount of points it will remove from them per unit
	var/list/affected_addictions = list(
		/datum/addiction/alcohol = 3,
		/datum/addiction/opiate = 3,
		/datum/addiction/hallucinogens = 3,
		)
/datum/reagent/medicine/varenicline
	name = "Varenicline"
	description = "A medication used for smoking cessation and for the treatment of blurry vision."
	reagent_state = LIQUID
	color = "#c0e1ed"
	value = 3.1

/datum/reagent/medicine/imidazoline
	name = "Imidazoline"
	description = "A compound that treats damage to the eyes and ocular nerves. Since it treats the underlying tissue, it can heal synthetic eyes as well as organic ones."
	taste_description = "dull toxin"
	color = "#c8a5dc"
	value = 4.2

/datum/reagent/medicine/imidazoline/affect_blood(mob/living/carbon/M, alien, removed)
	M.adjust_eye_blur(-5 SECONDS * removed)
	M.adjust_temp_blindness(-5 SECONDS)
	if (ishuman(M))
		var/mob/living/carbon/human/H = M
		var/obj/item/organ/internal/eyes/E = H.internal_organs_by_name[BP_EYES]
		if (E && istype(E))
			if (E.damage > 0)
				E.damage = max(E.damage - 5 * removed, 0)
