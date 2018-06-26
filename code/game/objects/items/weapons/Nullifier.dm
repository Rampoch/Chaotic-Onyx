
/obj/item/weapon/Nullifier
	name = "Nullifier"
	desc = "Used to reduce personnel."
	icon = 'icons/obj/autopsy_scanner.dmi'
	icon_state = ""
	obj_flags = OBJ_FLAG_CONDUCTIBLE
	w_class = ITEM_SIZE_SMALL
	origin_tech = list(TECH_MAGNET = 4, TECH_ILLEGAL = 2, TECH_DATA = 4)


/obj/item/weapon/Nullifier/attack(mob/target as mob, mob/living/user as mob)
	if(istype(target, /mob/living/carbon/human))
		var/id = target.GetIdCard()
		if(id)
			to_chat(user, "<span class='notice'>ID card detected. Nullification is performed.</span>")
			test(id)
		else
			to_chat(user, "<span class='notice'>No ID card detected.</span>")
			return
	else
		to_chat(user,"<span class='notice'>No ID card detected.</span>")
		return


/obj/item/weapon/Nullifier/afterattack(var/obj/item/weapon/O as obj, mob/user as mob, proximity)
	if(!proximity) return
	if(istype(O, /obj/item/weapon/card/id))
		to_chat(user, "<span class='notice'>ID card detected. Nullification is performed.</span>")
		test(O)

/obj/item/weapon/Nullifier/proc/test(var/obj/item/weapon/card/id/id_card)
	id_card.access -= get_access_ids(ACCESS_TYPE_STATION|ACCESS_TYPE_CENTCOM)
	id_card.assignment = "Terminated"
	callHook("terminate_employee", list(id_card))
	id_card.SetName(text("[id_card.registered_name]'s ID Card ([id_card.assignment])"))
