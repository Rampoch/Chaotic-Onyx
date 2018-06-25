// Checks whether or not the target can be affected by a vampire's abilities.
/mob/proc/vampire_can_affect_target(var/mob/living/carbon/human/T, var/notify = 1, var/account_loyalty_implant = 0)
	if (!T || !istype(T))
		return 0

	if (T.isSynthetic())
		if (notify)
			src << SPAN_WARN("You lack the power interact with mechanical constructs.")
		return 0

	return 1


/mob/living/carbon/human/proc/finish_chang_timeout(chang_flags = 0)
	if (!usr.mind || !usr.mind.changeling)
		return FALSE

	if (chang_flags && !(usr.mind.changeling & chang_flags))
		return FALSE

	return TRUE

/obj/item/organ/internal/brain
	var/decoy_override = 0
