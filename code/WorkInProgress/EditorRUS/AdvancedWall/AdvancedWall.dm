/turf/simulated/advanced_wall
	name = "Advanced wall"
	icon = 'advanced_wall.dmi'
	icon_state = "advanced_wall_plating"
	layer = TURF_LAYER + 0.5 //Almost all turfs under it
	density = 0
	opacity = 1 //Just effect
	var/turf/simulated/advanced_wall_tunnel/RT = list()

	New()
		..()
		for (var/turf/simulated/advanced_wall_tunnel/T in get_turf(src))
			RT += T

	Del()
		for (var/turf/simulated/advanced_wall_tunnel/T in RT)
			del(T)
		..()

	Enter(mob/O, atom/oldloc)
		Discover(O)

	proc/Discover(mob/O)
		var/turf/simulated/advanced_wall_tunnel/B = list()
		var/turf/simulated/advanced_wall/A = list()

		while(1)
			for(var/turf/simulated/advanced_wall/S in range(world.view, O.loc))
				A += S
			for(var/turf/simulated/advanced_wall/S in A)
				S.opacity = 0 //Tempolary
			for(var/turf/simulated/advanced_wall_tunnel/S in view(world.view, O.loc))
				B += S
			var/image/H
			for(var/turf/simulated/advanced_wall_tunnel/S in B)
				H += image(S)
				H.override = 1
				O << H
			break
/turf/simulated/advanced_wall_tunnel
	name = ""
	icon = 'advanced_wall.dmi'
	icon_state = "advanced_wall"
	density = 1
	opacity = 1
	mouse_opacity = 1
	flags = ON_BORDER

	CanPass(atom/movable/mover, turf/target, height=0, air_group=0)
		if(istype(mover) && mover.checkpass(PASSGLASS))
			return 1
		if(dir == SOUTHWEST || dir == SOUTHEAST || dir == NORTHWEST || dir == NORTHEAST)
			return 0	//full tile window, you can't move into it!
		if(get_dir(loc, target) == dir)
			return !density
		else
			return 1

