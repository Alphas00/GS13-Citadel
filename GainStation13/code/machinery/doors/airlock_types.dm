//GS13 Port - stuckage code
/obj/machinery/door/airlock/Crossed(mob/living/carbon/L)
	if(!istype(L))
		return ..()

	var/stuckage_weight = L?.client?.prefs?.stuckage
	if(isnull(stuckage_weight) || (stuckage_weight < 10))
		return ..() // They aren't able to get stuck

	if(L.fatness > (stuckage_weight * 2))
		if(rand(1, 3) == 1)
			L.doorstuck = 1
			L.visible_message("<span class'danger'>[L] gets stuck in the doorway!</span>")
			to_chat(L, "<span class='danger'>As you attempt to pass through  \the [src], your ample curves get wedged in the narrow opening. You find yourself stuck in the [src] frame, struggling to free yourself from the tight squeeze.</span>")
			L.Stun(100, updating = TRUE, ignore_canstun = TRUE)
			sleep(100)
			L.doorstuck = 0
			L.Knockdown(1)
		return ..()

	else if(L.fatness > stuckage_weight)
		if(rand(1, 5) == 1)
			L.doorstuck = 1
			L.visible_message("<span class'danger'>[L] gets stuck in the doorway!</span>")
			to_chat(L, "<span class='danger'>As you attempt to pass through  \the [src], your ample curves get wedged in the narrow opening. You find yourself stuck in the [src] frame, struggling to free yourself from the tight squeeze.</span>")
			L.Stun(55, updating = TRUE, ignore_canstun = TRUE)
			sleep(55)
			L.doorstuck = 0
			L.Knockdown(1)
			return ..()
		if(rand(1, 5) == 5)
			to_chat(L, "<span class='danger'>With great effort, you manage to squeeze your massive form through  \the [src]. It's a tight fit, but you successfully navigate the narrow opening, barely avoiding getting stuck.</span>")
			return ..()

	else if(L.fatness > (stuckage_weight / 2))
		if(rand(1, 5) == 1)
			L.visible_message("<span class'danger'>[L]'s hips brush against the doorway...</span>")
			to_chat(L, "<span class='danger'>As you pass through  \the [src], you feel a slight brushing against your hips. The [src] frame accommodates your form, but it's a close fit..</span>")
			return ..()

	return ..()
