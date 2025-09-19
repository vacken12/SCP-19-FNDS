// Reagents that put people to sleep, slow them down, or otherwise directly impair their functions.
// This doesn't include things like cryptobiolin and impedrezene - sedatives are strictly for sleepiness and slowing, even if they're also toxic.

/datum/reagent/soporific
	name = "Soporific"
	description = "An effective hypnotic used to treat insomnia."
	taste_description = "bitterness"
	reagent_state = LIQUID
	color = "#009ca8"
	metabolism = REM * 0.5
	overdose = REAGENTS_OVERDOSE
	value = 2.5
	scannable = TRUE
	should_admin_log = TRUE




/datum/reagent/vecuronium_bromide
	name = "Vecuronium Bromide"
	description = "A powerful paralytic."
	taste_description = "metallic"
	reagent_state = SOLID
	color = "#ff337d"
	metabolism = REM * 0.5
	overdose = REAGENTS_OVERDOSE * 0.5
	value = 2.6
	should_admin_log = TRUE
/datum/reagent/chloral_hydrate
	name = "Chloral Hydrate"
	description = "A powerful sedative."
	taste_description = "bitterness"
	reagent_state = SOLID
	color = "#000067"
	metabolism = REM * 0.5
	overdose = REAGENTS_OVERDOSE * 0.5
	value = 2.6
	should_admin_log = TRUE


/// Chloral hydrate disguised as beer, for use by emagged/traitor service robots.
/datum/reagent/chloral_hydrate/beer
	name = "Beer"
	description = "An alcoholic beverage made from malted grains, hops, yeast, and water. The fermentation appears to be incomplete." //If the players manage to analyze this, they deserve to know something is wrong.
	taste_description = "shitty piss water"
	reagent_state = LIQUID
	color = "#ffd300"

	glass_name = "beer"
	glass_desc = "A freezing pint of beer"



/datum/reagent/toxin/zombie_powder
	name = "Zombie Powder"
	description = "A strong neurotoxin that puts the subject into a death-like state."
	taste_description = "death"
	reagent_state = SOLID
	color = "#669900"
	metabolism = REM
	strength = 3
	target_organ = BP_BRAIN
	heating_message = "melts into a liquid slurry."
	heating_products = list(/datum/reagent/toxin/carpotoxin, /datum/reagent/soporific, /datum/reagent/copper)
	heating_prod_english = "<span codexlink='carpotoxin (chemical)'>carpotoxin</span>, <span codexlink='soporific (chemical)'>soporific</span>, and <span codexlink='copper (chemical)'>copper</span>"
/datum/reagent/toxin/zombie_powder/Destroy()
	if (holder && holder.my_atom && ismob(holder.my_atom))
		var/mob/M = holder.my_atom
		M.status_flags &= ~FAKEDEATH
	. = ..()
