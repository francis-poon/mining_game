
extends Node2D

i need to have a system where the teleport has a destination map and location.
i can save the map and location as an object called an Point? a teleport point will 
have an area that will teleport the player

what i want:
	player walked onto a pad and it teleports them to another pad on another map

when player enters
	tell level manager the map and teleport point that you want the player to tp to.
	tp points are going to have an id, and when going to the next map, the level manager
	is going to look for a tp point with the same id? or the tp point can just have a destination
	id and by default it should be the same as its own id so that in the future i can have
	multiple tp points for randomized spawning.
