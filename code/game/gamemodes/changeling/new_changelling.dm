/mob/proc/gib_self()
	set category = "Changeling"
	set name = "Body disjunction (40)"
	set desc = "Tear apart your human disguise, revealing your little form."

	var/datum/changeling/changeling = changeling_power(40,0,0)
	if(!changeling)	return 0
	src.mind.changeling.chem_charges -= 40

	var/mob/living/carbon/M = src

	M.visible_message("<span class='danger'>You hear a loud cracking sound coming from \the [M].</span>", \
						"<span class='danger'>We begin disjunction of our body to form a pack of autonomous organisms.</span>")
	if(!do_after(src,60))
		M.visible_message("<span class='danger'>[M]'s transformation abruptly reverts itself!</span>", \
							"<span class='danger'>Our transformation has been interrupted!</span>")
		return 0

	M.visible_message("<span class='danger'>[M] begins to fall apart, their limbs forming a gross monstrosities!</span>")
	playsound(loc, 'sound/effects/greaterling.ogg', 100, 1)
	var/obj/item/organ/internal/biostructure/Bio = M.internal_organs_by_name[BP_CHANG]
	var/organ_chang_type = Bio.parent_organ
	var/mob/living/simple_animal/hostile/little_changeling/leg_chan/leg_ling1 = new (get_turf(M))
	var/mob/living/simple_animal/hostile/little_changeling/arm_chan/arm_ling1 = new (get_turf(M))
	var/new_mob1 = /mob/living/simple_animal/hostile/little_changeling/leg_chan/
	new new_mob1(get_turf(M))
	var/new_mob2 = /mob/living/simple_animal/hostile/little_changeling/arm_chan/
	new new_mob2(get_turf(M))
	var/mob/living/simple_animal/hostile/little_changeling/head_chan/head_ling = new (get_turf(M))
	var/mob/living/simple_animal/hostile/little_changeling/chest_chan/chest_ling = new (get_turf(M))
	gibs(loc, dna)
	if(istype(M,/mob/living/carbon/human))
		for(var/obj/item/I in M.contents)
			if(isorgan(I))
				continue
			M.drop_from_inventory(I)
	if(organ_chang_type == BP_L_FOOT || organ_chang_type == BP_R_FOOT || organ_chang_type == BP_L_LEG || organ_chang_type == BP_R_LEG)
		if(M.mind)
			M.mind.transfer_to(leg_ling1)
		else
			leg_ling1.key = M.key
		leg_ling1.forceMove(get_turf(M))
	else if(organ_chang_type == BP_L_HAND || organ_chang_type == BP_R_HAND || organ_chang_type == BP_L_ARM || organ_chang_type == BP_R_ARM)
		if(M.mind)
			M.mind.transfer_to(arm_ling1)
		else
			arm_ling1.key = M.key
		arm_ling1.forceMove(get_turf(M))
	else if(organ_chang_type == BP_HEAD)
		if(M.mind)
			M.mind.transfer_to(head_ling)
		else
			head_ling.key = M.key
		head_ling.forceMove(get_turf(M))
	else if(organ_chang_type == BP_CHEST || organ_chang_type == BP_GROIN)
		if(M.mind)
			M.mind.transfer_to(chest_ling)
		else
			chest_ling.key = M.key
		chest_ling.forceMove(get_turf(M))
		qdel(M)
	M.mind.assigned_role = "Changeling"
	var/atom/movable/overlay/effect = new /atom/movable/overlay(get_turf(M))
	effect.density = 0
	effect.anchored = 1
	effect.icon = 'icons/effects/effects.dmi'
	effect.layer = 3
	flick("summoning",effect)
	QDEL_IN(effect, 10)