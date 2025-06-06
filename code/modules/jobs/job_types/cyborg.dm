/datum/job/cyborg
	title = "Cyborg"
	flag = CYBORG
	auto_deadmin_role_flags = DEADMIN_POSITION_SILICON
	department_flag = ENGSEC
	faction = "Station"
	total_positions = 1 //GS13 Edit: latejoining borgs
	spawn_positions = 3
	supervisors = "your laws and the AI"	//Nodrak
	selection_color = "#ddffdd"
	minimal_player_age = 21
	exp_requirements = 120
	exp_type = EXP_TYPE_CREW
	considered_combat_role = TRUE
	random_spawns_possible = FALSE
	starting_modifiers = list(/datum/skill_modifier/job/level/wiring/basic)

	display_order = JOB_DISPLAY_ORDER_CYBORG
	departments = DEPARTMENT_BITFLAG_SILICON

/datum/job/cyborg/equip(mob/living/carbon/human/H, visualsOnly = FALSE, announce = TRUE, latejoin = FALSE, datum/outfit/outfit_override = null, client/preference_source = null)
	if(visualsOnly)
		CRASH("dynamic preview is unsupported")
	return H.Robotize(FALSE, latejoin)

/datum/job/cyborg/after_spawn(mob/living/silicon/robot/R, client/player_client)
	. = ..()
	if(!istype(R))
		return
	R.updatename(player_client)
	R.gender = NEUTER

/datum/job/cyborg/radio_help_message(mob/M)
	to_chat(M, "<b>Prefix your message with :b to speak with other cyborgs and AI.</b>")
