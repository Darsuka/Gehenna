/obj/item/organ/cyberimp/arm
	name = "arm-mounted implant"
	desc = "You shouldn't see this! Adminhelp and report this as an issue on github!"
	zone = BODY_ZONE_R_ARM
	icon_state = "implant-toolkit"
	w_class = WEIGHT_CLASS_SMALL
	actions_types = list(/datum/action/item_action/organ_action/toggle)
	///A ref for the arm we're taking up. Mostly for the unregister signal upon removal
	var/obj/hand
	/// Used to store a list of all items inside, for multi-item implants.
	var/list/items_list = list()// I would use contents, but they shuffle on every activation/deactivation leading to interface inconsistencies.
	/// You can use this var for item path, it would be converted into an item on New().
	var/obj/item/active_item

/obj/item/organ/cyberimp/arm/Initialize()
	. = ..()
	if(ispath(active_item))
		active_item = new active_item(src)

	update_appearance()
	SetSlotFromZone()
	items_list = contents.Copy()

/obj/item/organ/cyberimp/arm/proc/SetSlotFromZone()
	switch(zone)
		if(BODY_ZONE_L_ARM)
			slot = ORGAN_SLOT_LEFT_ARM_AUG
		if(BODY_ZONE_R_ARM)
			slot = ORGAN_SLOT_RIGHT_ARM_AUG
		else
			CRASH("Invalid zone for [type]")

/obj/item/organ/cyberimp/arm/update_appearance()
	. = ..()
	transform = (zone == BODY_ZONE_R_ARM) ? null : matrix(-1, 0, 0, 0, 1, 0)

/obj/item/organ/cyberimp/arm/examine(mob/user)
	. = ..()
	. += "<span class='info'>[src] is assembled in the [zone == BODY_ZONE_R_ARM ? "right" : "left"] arm configuration. You can use a screwdriver to reassemble it.</span>"

/obj/item/organ/cyberimp/arm/screwdriver_act(mob/living/user, obj/item/I)
	. = ..()
	if(.)
		return TRUE
	I.play_tool_sound(src)
	if(zone == BODY_ZONE_R_ARM)
		zone = BODY_ZONE_L_ARM
	else
		zone = BODY_ZONE_R_ARM
	SetSlotFromZone()
	to_chat(user, "<span class='notice'>You modify [src] to be installed on the [zone == BODY_ZONE_R_ARM ? "right" : "left"] arm.</span>")
	update_appearance()

/obj/item/organ/cyberimp/arm/Insert(mob/living/carbon/M, special = FALSE, drop_if_replaced = TRUE)
	. = ..()
	var/side = zone == BODY_ZONE_R_ARM? RIGHT_HANDS : LEFT_HANDS
	hand = owner.hand_bodyparts[side]
	if(hand)
		RegisterSignal(hand, COMSIG_ITEM_ATTACK_SELF, PROC_REF(ui_action_click)) //If the limb gets an attack-self, open the menu. Only happens when hand is empty
		RegisterSignal(M, COMSIG_KB_MOB_DROPITEM_DOWN, PROC_REF(dropkey)) //We're nodrop, but we'll watch for the drop hotkey anyway and then stow if possible.

/obj/item/organ/cyberimp/arm/Remove(mob/living/carbon/M, special = 0)
	Retract()
	if(hand)
		UnregisterSignal(hand, COMSIG_ITEM_ATTACK_SELF)
		UnregisterSignal(M, COMSIG_KB_MOB_DROPITEM_DOWN)
	..()

/obj/item/organ/cyberimp/arm/emp_act(severity)
	. = ..()
	if(. & EMP_PROTECT_SELF)
		return
	if(prob(15/severity) && owner)
		to_chat(owner, "<span class='warning'>The electromagnetic pulse causes [src] to malfunction!</span>")
		// give the owner an idea about why his implant is glitching
		Retract()

/**
 * Called when the mob uses the "drop item" hotkey
 *
 * Items inside toolset implants have TRAIT_NODROP, but we can still use the drop item hotkey as a
 * quick way to store implant items. In this case, we check to make sure the user has the correct arm
 * selected, and that the item is actually owned by us, and then we'll hand off the rest to Retract()
**/
/obj/item/organ/cyberimp/arm/proc/dropkey(mob/living/carbon/host)
	if(!host)
		return //How did we even get here
	if(hand != host.hand_bodyparts[host.active_hand_index])
		return //wrong hand
	Retract()

/obj/item/organ/cyberimp/arm/proc/Retract()
	if(!active_item || (active_item in src))
		return

	owner.visible_message("<span class='notice'>[owner] retracts [active_item] back into [owner.p_their()] [zone == BODY_ZONE_R_ARM ? "right" : "left"] arm.</span>",
		"<span class='notice'>[active_item] snaps back into your [zone == BODY_ZONE_R_ARM ? "right" : "left"] arm.</span>",
		"<span class='hear'>You hear a short mechanical noise.</span>")

	owner.transferItemToLoc(active_item, src, TRUE)
	active_item = null
	playsound(get_turf(owner), 'code/modules/wod13/sounds/potence_deactivate.ogg', 50, TRUE)

/obj/item/organ/cyberimp/arm/proc/Extend(obj/item/item)
	if(!(item in src))
		return

	active_item = item

	active_item.resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF
	ADD_TRAIT(active_item, TRAIT_NODROP, HAND_REPLACEMENT_TRAIT)
	active_item.slot_flags = null
	active_item.set_custom_materials(null)

	var/side = zone == BODY_ZONE_R_ARM? RIGHT_HANDS : LEFT_HANDS
	var/hand = owner.get_empty_held_index_for_side(side)
	if(hand)
		owner.put_in_hand(active_item, hand)
	else
		var/list/hand_items = owner.get_held_items_for_side(side, all = TRUE)
		var/success = FALSE
		var/list/failure_message = list()
		for(var/i in 1 to hand_items.len) //Can't just use *in* here.
			var/I = hand_items[i]
			if(!owner.dropItemToGround(I))
				failure_message += "<span class='warning'>Your [I] interferes with [src]!</span>"
				continue
			to_chat(owner, "<span class='notice'>You drop [I] to activate [src]!</span>")
			success = owner.put_in_hand(active_item, owner.get_empty_held_index_for_side(side))
			break
		if(!success)
			for(var/i in failure_message)
				to_chat(owner, i)
			return
	owner.visible_message("<span class='notice'>[owner] extends [active_item] from [owner.p_their()] [zone == BODY_ZONE_R_ARM ? "right" : "left"] arm.</span>",
		"<span class='notice'>You extend [active_item] from your [zone == BODY_ZONE_R_ARM ? "right" : "left"] arm.</span>",
		"<span class='hear'>You hear a short mechanical noise.</span>")
	playsound(get_turf(owner), 'code/modules/wod13/sounds/potence_activate.ogg', 50, TRUE)

/obj/item/organ/cyberimp/arm/ui_action_click()
	if((organ_flags & ORGAN_FAILING) || (!active_item && !contents.len))
		to_chat(owner, "<span class='warning'>The implant doesn't respond. It seems to be broken...</span>")
		return

	if(!active_item || (active_item in src))
		active_item = null
		if(contents.len == 1)
			Extend(contents[1])
		else
			var/list/choice_list = list()
			for(var/obj/item/I in items_list)
				choice_list[I] = image(I)
			var/obj/item/choice = show_radial_menu(owner, owner, choice_list)
			if(owner && owner == usr && owner.stat != DEAD && (src in owner.internal_organs) && !active_item && (choice in contents))
				// This monster sanity check is a nice example of how bad input is.
				Extend(choice)
	else
		Retract()


/obj/item/organ/cyberimp/arm/gun/emp_act(severity)
	. = ..()
	if(. & EMP_PROTECT_SELF)
		return
	if(prob(30/severity) && owner && !(organ_flags & ORGAN_FAILING))
		Retract()
		owner.visible_message("<span class='danger'>A loud bang comes from [owner]\'s [zone == BODY_ZONE_R_ARM ? "right" : "left"] arm!</span>")
		playsound(get_turf(owner), 'sound/weapons/flashbang.ogg', 100, TRUE)
		to_chat(owner, "<span class='userdanger'>You feel an explosion erupt inside your [zone == BODY_ZONE_R_ARM ? "right" : "left"] arm as your implant breaks!</span>")
		owner.adjust_fire_stacks(20)
		owner.IgniteMob()
		owner.adjustFireLoss(25)
		organ_flags |= ORGAN_FAILING


/obj/item/organ/cyberimp/arm/gun/laser
	name = "arm-mounted laser implant"
	desc = "A variant of the arm cannon implant that fires lethal laser beams. The cannon emerges from the subject's arm and remains inside when not in use."
	icon_state = "arm_laser"
	contents = newlist(/obj/item/gun/energy/laser/mounted)

/obj/item/organ/cyberimp/arm/gun/laser/l
	zone = BODY_ZONE_L_ARM

/obj/item/organ/cyberimp/arm/gun/laser/Initialize()
	. = ..()
	var/obj/item/organ/cyberimp/arm/gun/laser/laserphasergun = locate(/obj/item/gun/energy/laser/mounted) in contents
	laserphasergun.icon = icon //No invisible laser guns kthx
	laserphasergun.icon_state = icon_state

/obj/item/organ/cyberimp/arm/gun/taser
	name = "arm-mounted taser implant"
	desc = "A variant of the arm cannon implant that fires electrodes and disabler shots. The cannon emerges from the subject's arm and remains inside when not in use."
	icon_state = "arm_taser"
	contents = newlist(/obj/item/gun/energy/e_gun/advtaser/mounted)

/obj/item/organ/cyberimp/arm/gun/taser/l
	zone = BODY_ZONE_L_ARM

/obj/item/organ/cyberimp/arm/toolset
	name = "integrated toolset implant"
	desc = "A stripped-down version of the engineering cyborg toolset, designed to be installed on subject's arm. Contain advanced versions of every tool."
	contents = newlist(/obj/item/screwdriver/cyborg, /obj/item/wrench/cyborg, /obj/item/weldingtool/largetank/cyborg,
		/obj/item/crowbar/cyborg, /obj/item/wirecutters/cyborg, /obj/item/multitool/cyborg)

/obj/item/organ/cyberimp/arm/toolset/l
	zone = BODY_ZONE_L_ARM

/obj/item/organ/cyberimp/arm/toolset/emag_act(mob/user)
	if(!(locate(/obj/item/kitchen/knife/combat/cyborg) in items_list))
		to_chat(user, "<span class='notice'>You unlock [src]'s integrated knife!</span>")
		items_list += new /obj/item/kitchen/knife/combat/cyborg(src)
		return 1
	return 0

/obj/item/organ/cyberimp/arm/esword
	name = "arm-mounted energy blade"
	desc = "An illegal and highly dangerous cybernetic implant that can project a deadly blade of concentrated energy."
	contents = newlist(/obj/item/melee/transforming/energy/blade/hardlight)

/obj/item/organ/cyberimp/arm/medibeam
	name = "integrated medical beamgun"
	desc = "A cybernetic implant that allows the user to project a healing beam from their hand."
	contents = newlist(/obj/item/gun/medbeam)
	zone = BODY_ZONE_L_ARM


/obj/item/organ/cyberimp/arm/flash
	name = "integrated high-intensity photon projector" //Why not
	desc = "An integrated projector mounted onto a user's arm that is able to be used as a powerful flash."
	contents = newlist(/obj/item/assembly/flash/armimplant)

/obj/item/organ/cyberimp/arm/flash/Initialize()
	. = ..()
	if(locate(/obj/item/assembly/flash/armimplant) in items_list)
		var/obj/item/assembly/flash/armimplant/F = locate(/obj/item/assembly/flash/armimplant) in items_list
		F.I = src

/obj/item/organ/cyberimp/arm/flash/Extend()
	. = ..()
	active_item.set_light_range(7)
	active_item.set_light_on(TRUE)

/obj/item/organ/cyberimp/arm/flash/Retract()
	active_item.set_light_on(FALSE)
	return ..()

/obj/item/organ/cyberimp/arm/baton
	name = "arm electrification implant"
	desc = "An illegal combat implant that allows the user to administer disabling shocks from their arm."
	contents = newlist(/obj/item/borg/stun)

/obj/item/organ/cyberimp/arm/combat
	name = "combat cybernetics implant"
	desc = "A powerful cybernetic implant that contains combat modules built into the user's arm."
	contents = newlist(/obj/item/melee/transforming/energy/blade/hardlight, /obj/item/gun/medbeam, /obj/item/borg/stun, /obj/item/assembly/flash/armimplant)

/obj/item/organ/cyberimp/arm/combat/Initialize()
	. = ..()
	if(locate(/obj/item/assembly/flash/armimplant) in items_list)
		var/obj/item/assembly/flash/armimplant/F = locate(/obj/item/assembly/flash/armimplant) in items_list
		F.I = src

/obj/item/organ/cyberimp/arm/surgery
	name = "surgical bones"
	desc = "A set of surgical tools hidden behind a concealed flesh on the user's arm."
	contents = newlist(/obj/item/retractor/augment, /obj/item/hemostat/augment, /obj/item/cautery/augment, /obj/item/surgicaldrill/augment, /obj/item/scalpel/augment, /obj/item/circular_saw/augment, /obj/item/surgical_drapes)

/obj/item/organ/cyberimp/arm/tzimisce
	name = "armblade implant"
	desc = "A concealed serrated bone blade."
	icon = 'code/modules/wod13/weapons.dmi'
	icon_state = "armblade"
	zone = BODY_ZONE_L_ARM
	contents = newlist(/obj/item/melee/vampirearms/tzimisce)

/obj/item/organ/cyberimp/arm/tzimisce/venom
	name = "nematocyst whip implant"
	desc = "A concealed venomous whip."
	icon_state = "lasombra"
	contents = newlist(/obj/item/melee/vampirearms/tzimisce/venom)

/obj/item/organ/cyberimp/arm/tzimisce/shock
	name = "electrocyte whip implant"
	desc = "A concealed electrical whip."
	icon_state = "lasombra"
	contents = newlist(/obj/item/melee/vampirearms/tzimisce/shock)
