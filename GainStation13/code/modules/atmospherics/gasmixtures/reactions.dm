/datum/gas_reaction/lipoifium_formation
	priority = 7
	name = "Lipoifium Formation"
	id = "lipoifium_formation"

/datum/gas_reaction/lipoifium_formation/init_reqs()
	min_requirements = list(
		"MAX_TEMP" = 100,
		GAS_BZ = 15,
		GAS_TRITIUM = 15
	)

/datum/gas_reaction/lipoifium_formation/react(datum/gas_mixture/air)
	// TODO: make the reaction exothermic, and make it more efficient at lower temperatures
	var/temperature = air.return_temperature()
	var/reaction_efficiency = 0
	if (temperature <= 5)
		reaction_efficiency = 1
	else if (temperature >= 100)
		return NO_REACTION
	else
		reaction_efficiency = -((temperature - 5) / 95) + 1		// will equal 1 at 5 kelvin, and will linearly fall until 0 at 100k

	var/energy_released = reaction_efficiency*FIRE_CARBON_ENERGY_RELEASED
	air.adjust_moles(GAS_FAT, reaction_efficiency)
	air.adjust_moles(GAS_TRITIUM, -reaction_efficiency / 2)
	air.adjust_moles(GAS_BZ, -reaction_efficiency / 2)
	var/heat_capacity = air.heat_capacity()
	air.set_temperature(max(temperature + energy_released / heat_capacity, TCMB))

	return REACTING
