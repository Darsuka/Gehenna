#define BURNTTREE_ALLOWED_TRIBES list("Galestalkers", "Ghost Council", "Hart Wardens", "Get of Fenris", "Black Furies", "Silent Striders", "Red Talons", "Silver Fangs", "Stargazers")
#define PAINTED_CITY_TRIBES list("Glass Walkers", "Bone Gnawers", "Children of Gaia", "Shadow Lords")

/datum/job/vamp/garou/garounation/council
	title = "Burnt Tree Councillor"
	auto_deadmin_role_flags = DEADMIN_POSITION_HEAD|DEADMIN_POSITION_SECURITY
	department_head = list("The Litany")

	selection_color = "#69e430"
	faction = "Vampire"
	allowed_species = list("Werewolf")
	allowed_tribes = BURNTTREE_ALLOWED_TRIBES
	minimal_renownrank = 4

	total_positions = 3
	spawn_positions = 3
	supervisors = "The Litany and Yourself."

	req_admin_notify = 1
	minimal_player_age = 25
	exp_requirements = 180
	exp_type_department = EXP_TYPE_GAROUNATION

	outfit = /datum/outfit/job/garou/gladecouncil

	access = list() 			//See get_access()
	minimal_access = list() 	//See get_access()
	paycheck = PAYCHECK_COMMAND
	paycheck_department = ACCOUNT_SEC

	liver_traits = list(TRAIT_ROYAL_METABOLISM)

	display_order = JOB_DISPLAY_ORDER_GAROUNATION

	minimal_masquerade = 5

	known_contacts = null

	v_duty = "You, along with any of the other two council members present, oversee the fate of the Sept. Your duty is to ensure the Keeper, the Truthfinder, and the Warder are able to keep the peace in the Sept, and to do your utmost to keep your territory clean of banes."
	experience_addition = 25

/datum/outfit/job/garou/gladecouncil
	name = "Burnt Tree Councillor"
	jobtype = /datum/job/vamp/garou/garounation/council

	id = /obj/item/card/id/garou/glade/council
	uniform =  /obj/item/clothing/under/vampire/turtleneck_white
	suit = /obj/item/clothing/suit/vampire/coat/winter/alt
	shoes = /obj/item/clothing/shoes/vampire/jackboots/work
	l_pocket = /obj/item/vamp/phone
	backpack_contents = list(/obj/item/gun/ballistic/automatic/vampire/deagle=1, /obj/item/phone_book=1, /obj/item/passport=1, /obj/item/cockclock=1, /obj/item/flashlight=1, /obj/item/vamp/creditcard/rich=1)


	backpack = /obj/item/storage/backpack
	satchel = /obj/item/storage/backpack/satchel
	duffelbag = /obj/item/storage/backpack/duffelbag

/obj/effect/landmark/start/garou/glade/council
	name = "Burnt Tree Councillor"
	icon_state = "Prince"

/datum/job/vamp/garou/garounation/keeper
	title = "Burnt Tree Keeper"
	auto_deadmin_role_flags = DEADMIN_POSITION_HEAD|DEADMIN_POSITION_SECURITY
	department_head = list("The Litany")

	selection_color = "#69e430"
	faction = "Vampire"
	allowed_species = list("Werewolf")
	allowed_tribes = BURNTTREE_ALLOWED_TRIBES

	minimal_renownrank = 3
	total_positions = 1
	spawn_positions = 1
	supervisors = "The Litany and the Council."

	req_admin_notify = 1
	minimal_player_age = 25
	exp_requirements = 100
	exp_type_department = EXP_TYPE_GAROUNATION

	outfit = /datum/outfit/job/garou/gladekeeper

	access = list() 			//See get_access()
	minimal_access = list() 	//See get_access()
	paycheck = PAYCHECK_COMMAND
	paycheck_department = ACCOUNT_SEC

	liver_traits = list(TRAIT_ROYAL_METABOLISM)

	display_order = JOB_DISPLAY_ORDER_GAROUNATION

	minimal_masquerade = 5

	known_contacts = null

	v_duty = "If you are a keeper, your duty is to look after those with access to the caerns and bawns to ensure things remain pleasing to the spirits, and to ensure rites and rituals go well. Keep an eye on the land, and entrust your sept with keeping others in line. If you are a truthcatcher, your duty is to mediate in internal disputes, and work with the sept's Council to see deeds exonerated and punished. Keep an ear out to the people, and keep your heart a judge's balance"

/datum/outfit/job/garou/gladekeeper
	name = "Burnt Tree Keeper"
	jobtype = /datum/job/vamp/garou/garounation/keeper

	id = /obj/item/card/id/garou/glade/keeper
	uniform =  /obj/item/clothing/under/vampire/mechanic
	suit = /obj/item/clothing/suit/vampire/labcoat
	gloves = /obj/item/clothing/gloves/vampire/work
	shoes = /obj/item/clothing/shoes/vampire/jackboots/work
	l_pocket = /obj/item/vamp/phone
	backpack_contents = list(/obj/item/phone_book=1, /obj/item/passport=1, /obj/item/cockclock=1, /obj/item/flashlight=1, /obj/item/vamp/creditcard/rich=1)


	backpack = /obj/item/storage/backpack
	satchel = /obj/item/storage/backpack/satchel
	duffelbag = /obj/item/storage/backpack/duffelbag

/obj/effect/landmark/start/garou/glade/keeper
	name = "Burnt Tree Keeper"
	icon_state = "Clerk"

/datum/job/vamp/garou/garounation/guardian
	title = "Burnt Tree Guardian"
	auto_deadmin_role_flags = DEADMIN_POSITION_SECURITY
	department_head = list("The Litany")

	selection_color = "#69e430"
	faction = "Vampire"
	allowed_species = list("Werewolf")
	allowed_tribes = BURNTTREE_ALLOWED_TRIBES

	total_positions = 5
	spawn_positions = 5
	supervisors = "The Litany and the Council."

	req_admin_notify = 1
	minimal_player_age = 25
	exp_requirements = 50
	exp_type_department = EXP_TYPE_GAROUNATION

	outfit = /datum/outfit/job/garou/gladeguardian

	access = list(ACCESS_MAINT_TUNNELS, ACCESS_SECURITY, ACCESS_SEC_DOORS, ACCESS_BRIG, ACCESS_COURT, ACCESS_MAINT_TUNNELS, ACCESS_MECH_SECURITY, ACCESS_MORGUE, ACCESS_WEAPONS, ACCESS_FORENSICS_LOCKERS, ACCESS_MINERAL_STOREROOM)
	minimal_access = list(ACCESS_SECURITY, ACCESS_SEC_DOORS, ACCESS_BRIG, ACCESS_COURT, ACCESS_WEAPONS, ACCESS_MECH_SECURITY, ACCESS_MINERAL_STOREROOM)
	paycheck = PAYCHECK_HARD
	paycheck_department = ACCOUNT_SEC

	mind_traits = list(TRAIT_DONUT_LOVER)
	liver_traits = list(TRAIT_LAW_ENFORCEMENT_METABOLISM)

	display_order = JOB_DISPLAY_ORDER_GAROUNATION

	minimal_masquerade = 3

	known_contacts = null

	v_duty = "You have put yourself forward as a force for the Sept. Working under the Warder, your duty is to defend and protect the sacred grounds of Gaia, and assist in bringing to heel those who have breached the veil for the Truthcatcher."

/datum/outfit/job/garou/gladeguardian
	name = "Burnt Tree Guardian"
	jobtype = /datum/job/vamp/garou/garounation/guardian

	id = /obj/item/card/id/garou/glade/guardian
	uniform =  /obj/item/clothing/under/vampire/biker
	shoes = /obj/item/clothing/shoes/vampire/jackboots
	head = /obj/item/clothing/head/vampire/baseballcap
	belt = /obj/item/melee/classic_baton/vampire
	gloves = /obj/item/clothing/gloves/vampire/leather
	suit = /obj/item/clothing/suit/vampire/jacket
	l_pocket = /obj/item/vamp/phone
	backpack_contents = list(/obj/item/passport=1, /obj/item/cockclock=1, /obj/item/flashlight=1, /obj/item/vamp/creditcard=1)


	backpack = /obj/item/storage/backpack
	satchel = /obj/item/storage/backpack/satchel
	duffelbag = /obj/item/storage/backpack/duffelbag

/obj/effect/landmark/start/garou/glade/guardian
	name = "Burnt Tree Guardian"
	icon_state = "Hound"

/datum/job/vamp/garou/garounation/paintedcouncil
	title = "Painted City Councillor"
	auto_deadmin_role_flags = DEADMIN_POSITION_HEAD|DEADMIN_POSITION_SECURITY
	department_head = list("The Litany")

	selection_color = "#69e430"
	faction = "Vampire"
	allowed_species = list("Werewolf")
	allowed_tribes = PAINTED_CITY_TRIBES

	total_positions = 3
	spawn_positions = 3
	supervisors = "The Litany and Yourself."

	minimal_renownrank = 4
	req_admin_notify = 1
	minimal_player_age = 25
	exp_requirements = 180
	exp_type_department = EXP_TYPE_GAROUNATION

	outfit = /datum/outfit/job/garou/citycouncil

	access = list() 			//See get_access()
	minimal_access = list() 	//See get_access()
	paycheck = PAYCHECK_COMMAND
	paycheck_department = ACCOUNT_SEC

	liver_traits = list(TRAIT_ROYAL_METABOLISM)

	display_order = JOB_DISPLAY_ORDER_GAROUNATION

	minimal_masquerade = 5

	known_contacts = null

	v_duty = "You, along with any of the other two council members present, oversee the fate of the Sept. Your duty is to ensure the Keeper, the Truthfinder, and the Warder are able to keep the peace in the Sept, and to do your utmost to keep your territory clean of banes."
	experience_addition = 25

/datum/outfit/job/garou/citycouncil
	name = "Painted City Councillor"
	jobtype = /datum/job/vamp/garou/garounation/paintedcouncil

	id = /obj/item/card/id/garou/city/council
	uniform =  /obj/item/clothing/under/vampire/office
	shoes = /obj/item/clothing/shoes/vampire
	l_pocket = /obj/item/vamp/phone
	r_pocket = /obj/item/vamp/keys/children_of_gaia
	backpack_contents = list(/obj/item/gun/ballistic/automatic/vampire/deagle=1, /obj/item/phone_book=1, /obj/item/passport=1, /obj/item/cockclock=1, /obj/item/flashlight=1, /obj/item/vamp/creditcard/rich=1)


	backpack = /obj/item/storage/backpack
	satchel = /obj/item/storage/backpack/satchel
	duffelbag = /obj/item/storage/backpack/duffelbag

/obj/effect/landmark/start/garou/painted/council
	name = "Painted City Councillor"
	icon_state = "Prince"

/datum/job/vamp/garou/garounation/paintedkeeper
	title = "Painted City Keeper"
	auto_deadmin_role_flags = DEADMIN_POSITION_HEAD|DEADMIN_POSITION_SECURITY
	department_head = list("The Litany")

	selection_color = "#69e430"
	faction = "Vampire"
	allowed_species = list("Werewolf")
	allowed_tribes = PAINTED_CITY_TRIBES

	minimal_renownrank = 3
	total_positions = 1
	spawn_positions = 1
	supervisors = "The Litany and the Council."

	req_admin_notify = 1
	minimal_player_age = 25
	exp_requirements = 100
	exp_type_department = EXP_TYPE_GAROUNATION

	outfit = /datum/outfit/job/garou/citykeeper

	access = list() 			//See get_access()
	minimal_access = list() 	//See get_access()
	paycheck = PAYCHECK_COMMAND
	paycheck_department = ACCOUNT_SEC

	liver_traits = list(TRAIT_ROYAL_METABOLISM)

	display_order = JOB_DISPLAY_ORDER_GAROUNATION

	minimal_masquerade = 5

	known_contacts = null

	v_duty = "If you are a keeper, your duty is to look after those with access to the caerns and bawns to ensure things remain pleasing to the spirits, and to ensure rites and rituals go well. Keep an eye on the land, and entrust your sept with keeping others in line. If you are a truthcatcher, your duty is to mediate in internal disputes, and work with the sept's Council to see deeds exonerated and punished. Keep an ear out to the people, and keep your heart a judge's balance"

/datum/outfit/job/garou/citykeeper
	name = "City Sept Keeper"
	jobtype = /datum/job/vamp/garou/garounation/paintedkeeper

	id = /obj/item/card/id/garou/city/keeper
	uniform =  /obj/item/clothing/under/vampire/office
	suit = /obj/item/clothing/suit/vampire/jacket
	shoes = /obj/item/clothing/shoes/vampire/jackboots
	l_pocket = /obj/item/vamp/phone
	r_pocket = /obj/item/vamp/keys/children_of_gaia
	backpack_contents = list(/obj/item/phone_book=1, /obj/item/passport=1, /obj/item/cockclock=1, /obj/item/flashlight=1, /obj/item/vamp/creditcard/rich=1)


	backpack = /obj/item/storage/backpack
	satchel = /obj/item/storage/backpack/satchel
	duffelbag = /obj/item/storage/backpack/duffelbag

/obj/effect/landmark/start/garou/painted/keeper
	name = "Painted City Keeper"
	icon_state = "Clerk"

/datum/job/vamp/garou/garounation/paintedguardian
	title = "Painted City Guardian"
	auto_deadmin_role_flags = DEADMIN_POSITION_SECURITY
	department_head = list("The Litany")

	selection_color = "#69e430"
	faction = "Vampire"
	allowed_species = list("Werewolf")
	allowed_tribes = PAINTED_CITY_TRIBES

	total_positions = 5
	spawn_positions = 5
	supervisors = "The Litany and the Council."

	req_admin_notify = 1
	minimal_player_age = 25
	exp_requirements = 50
	exp_type_department = EXP_TYPE_GAROUNATION

	outfit = /datum/outfit/job/garou/cityguardian

	access = list(ACCESS_MAINT_TUNNELS, ACCESS_SECURITY, ACCESS_SEC_DOORS, ACCESS_BRIG, ACCESS_COURT, ACCESS_MAINT_TUNNELS, ACCESS_MECH_SECURITY, ACCESS_MORGUE, ACCESS_WEAPONS, ACCESS_FORENSICS_LOCKERS, ACCESS_MINERAL_STOREROOM)
	minimal_access = list(ACCESS_SECURITY, ACCESS_SEC_DOORS, ACCESS_BRIG, ACCESS_COURT, ACCESS_WEAPONS, ACCESS_MECH_SECURITY, ACCESS_MINERAL_STOREROOM)
	paycheck = PAYCHECK_HARD
	paycheck_department = ACCOUNT_SEC

	mind_traits = list(TRAIT_DONUT_LOVER)
	liver_traits = list(TRAIT_LAW_ENFORCEMENT_METABOLISM)

	display_order = JOB_DISPLAY_ORDER_GAROUNATION

	minimal_masquerade = 3

	known_contacts = null

	v_duty = "You have put yourself forward as a force for the Sept. Working under the Warder, your duty is to defend and protect the sacred grounds of Gaia, and assist in bringing to heel those who have breached the veil for the Truthcatcher."

/datum/outfit/job/garou/cityguardian
	name = "City Sept Guardian"
	jobtype = /datum/job/vamp/garou/garounation/paintedguardian

	id = /obj/item/card/id/garou/city/guardian
	uniform =  /obj/item/clothing/under/vampire/bouncer
	shoes = /obj/item/clothing/shoes/vampire/jackboots
	belt = /obj/item/melee/classic_baton/vampire
	gloves = /obj/item/clothing/gloves/vampire/leather
	suit = /obj/item/clothing/suit/vampire/jacket
	l_pocket = /obj/item/vamp/phone
	r_pocket = /obj/item/vamp/keys/children_of_gaia
	backpack_contents = list(/obj/item/passport=1, /obj/item/cockclock=1, /obj/item/flashlight=1, /obj/item/vamp/creditcard=1)


	backpack = /obj/item/storage/backpack
	satchel = /obj/item/storage/backpack/satchel
	duffelbag = /obj/item/storage/backpack/duffelbag

/obj/effect/landmark/start/garou/painted/guardian
	name = "Painted City Guardian"
	icon_state = "Hound"

#undef BURNTTREE_ALLOWED_TRIBES
#undef PAINTED_CITY_TRIBES
