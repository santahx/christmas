-- farming/init.lua

-- Load support for MT game translation.
local S = minetest.get_translator("farming")

-- Global farming namespace

farming = {}
farming.path = minetest.get_modpath("farming")
farming.get_translator = S

-- Load files

dofile(farming.path .. "/api.lua")
dofile(farming.path .. "/nodes.lua")
dofile(farming.path .. "/hoes.lua")


--variables
	local wheatSize = 8


-- Wheat

--Plant registration
farming.register_plant("farming:wheat", {
	description = S("Wheat Seed"), 
	harvest_description = S("Wheat"),
	paramtype2 = "meshoptions",
	inventory_image = "farming_wheat_seed.png",
	steps = wheatSize,
	minlight = 13,
	maxlight = default.LIGHT_MAX,
	fertility = {"grassland"},
	groups = {food_wheat = 1, flammable = 4},
	place_param2 = 3,
})

--Register of item flour
minetest.register_craftitem("farming:flour", {
	description = S("Flour"),
	inventory_image = "farming_flour.png",
	groups = {food_flour = 1, flammable = 1},
})

--Register Item Bread
minetest.register_craftitem("farming:bread", {
	description = S("Bread"),
	inventory_image = "farming_bread.png",
	on_use = minetest.item_eat(5),
	groups = {food_bread = 1, flammable = 2},
})

--Register Craft recipe flour
minetest.register_craft({
	type = "shapeless",
	output = "farming:flour",
	recipe = {"farming:wheat", "farming:wheat", "farming:wheat", "farming:wheat"}
})

--Register baking craft recipe
minetest.register_craft({
	type = "cooking",
	cooktime = 15,
	output = "farming:bread",
	recipe = "farming:flour"
})


-- Hemp

--Plant registration
farming.register_plant("farming:hemp", {
	description = S("Hemp Seed"),
	harvest_description = S("Bud"),
	paramtype2 = "meshoptions",
	inventory_image = "farming_hemp_seed.png",
	steps = wheatSize,
	minlight = 13,
	maxlight = default.LIGHT_MAX,
	fertility = {"grassland"},
	groups = {food_wheat = 1, flammable = 4},
	place_param2 = 3,
})

--Register of item Grinded Weed
minetest.register_craftitem("farming:grinded_weed", {
	description = S("Grinded Weed"),
	inventory_image = "farming_grinded_bud.png",
	groups = {food_flour = 1, flammable = 1},
})

--Register of item Joint
minetest.register_craftitem("farming:joint", {
	description = S("Joint"),
	inventory_image = "farming_joint.png",
	on_use = minetest.item_eat(5),
	groups = {food_bread = 1, flammable = 2},
})

--Register Craft recipe Grinded Weed
minetest.register_craft({
	type = "shapeless",
	output = "farming:grinded_weed 3",
	recipe = {"farming:hemp", "farming:hemp"}
})

--Register Craft recipe Joint
minetest.register_craft({
	type = "shapeless",
	output = "farming:joint",
	recipe = {"farming:grinded_weed","default:paper"}
})


-- Cotton

--Plant registration
farming.register_plant("farming:cotton", {
	description = S("Cotton Seed"),
	harvest_description = S("Cotton"),
	inventory_image = "farming_cotton_seed.png",
	steps = 8,
	minlight = 13,
	maxlight = default.LIGHT_MAX,
	fertility = {"grassland", "desert"},
	groups = {flammable = 4},
})

--Register Decoration 
minetest.register_decoration({
	name = "farming:cotton_wild",
	deco_type = "simple",
	place_on = {"default:dry_dirt_with_dry_grass"},
	sidelen = 16,
	--Platzierungs Parameter
	noise_params = {
		offset = -0.1,
		scale = 0.1,
		spread = {x = 50, y = 50, z = 50},
		seed = 4242,
		octaves = 3,
		persist = 0.7
	},
	-- Biome
	biomes = {"savanna"},
	y_max = 31000,
	y_min = 1,
	decoration = "farming:cotton_wild",
})


--Register Item string
minetest.register_craftitem("farming:string", {
	description = S("String"),
	inventory_image = "farming_string.png",
	groups = {flammable = 2},
})

--Register Craft Recipe whool
minetest.register_craft({
	output = "wool:white",
	recipe = {
		{"farming:cotton", "farming:cotton"},
		{"farming:cotton", "farming:cotton"},
	}
})

--Register Craft Recipe string
minetest.register_craft({
	output = "farming:string 2",
	recipe = {
		{"farming:cotton"},
		{"farming:cotton"},
	}
})


-- Straw

--Plant registration
minetest.register_craft({
	output = "farming:straw 3",
	recipe = {
		{"farming:wheat", "farming:wheat", "farming:wheat"},
		{"farming:wheat", "farming:wheat", "farming:wheat"},
		{"farming:wheat", "farming:wheat", "farming:wheat"},
	}
})

--Register Craft recipe Wheat
minetest.register_craft({
	output = "farming:wheat 3",
	recipe = {
		{"farming:straw"},
	}
})


-- Fuels

--Wheat 
minetest.register_craft({
	type = "fuel",
	recipe = "farming:wheat",
	burntime = 1,
})

--Cotton
minetest.register_craft({
	type = "fuel",
	recipe = "farming:cotton",
	burntime = 1,
})

--String
minetest.register_craft({
	type = "fuel",
	recipe = "farming:string",
	burntime = 1,
})

--Hemp
minetest.register_craft({
	type = "fuel",
	recipe = "farming:hemp",
	burntime = 2,
})

--Wood
minetest.register_craft({
	type = "fuel",
	recipe = "farming:hoe_wood",
	burntime = 5,
})


-- Register farming items as dungeon loot

if minetest.global_exists("dungeon_loot") then
	dungeon_loot.register({
		{name = "farming:string", chance = 0.5, count = {1, 8}},
		{name = "farming:wheat", chance = 0.5, count = {2, 5}},
		{name = "farming:seed_cotton", chance = 0.4, count = {1, 4}},
		{name = "farming:seed_cotton", chance = 0.4, count = {1, 4},
			types = {"normal"}},
	})
end



--Additional Grow size after placing fence over plant

-- Funktion zur Überprüfung, ob ein Seil über der Pflanze ist
local function check_rope_under(pos, nodename)
    local under_pos = {x = pos.x, y = pos.y - 1, z = pos.z}
    local under_node = minetest.get_node(under_pos)

    --checks if a wheat seed is under it
    if under_node.name == "farming:seed_wheat" then

		--gives a log outpoot when detected
    	minetest.log("detected")
    end
end

-- Registrieren einer on_placenode-Rückruffunktion für Pflanzenknoten
minetest.register_on_placenode(function(pos, newnode, placer, oldnode, itemstack, pointed_thing)

	--default 
	if (newnode.name == "default:fence_acacia_wood") 
	or (newnode.name=="default:fence_aspen_wood")
	or (newnode.name=="default:fence_junglewood") 
	or (newnode.name=="default:fence_wood") 
	or (newnode.name=="default:fence_pine_wood") 

	--Everness support
	or (newnode.name=="everness:fence_bamboo_wood") 
	or (newnode.name=="everness:fence_crystal_wood") 
	or (newnode.name=="everness:fence_dry_wood") 
	or (newnode.name=="everness:fence__wood") 
	then
		--starts the check of node under it
        check_rope_under(pos, newnode.name)
	end
end)