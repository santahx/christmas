-- farming/init.lua

-- Load support for MT game translation.
local S = minetest.get_translator("farming")
local B = minetest.get_translator("bucket")
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
	on_use = minetest.item_eat(0),
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

--Register baking craft recipe
minetest.register_craft({
	type = "cooking",
	cooktime = 15,
	output = "farming:bread",
	recipe = "farming:flour"
})

--Register Craft Recipe string
minetest.register_craft({
	output = "farming:string 2",
	recipe = {
		{"farming:cotton"},
		{"farming:cotton"},
	}
})



-- olivebush

--Plant registration
farming.register_plant("farming:olivebush", {
	description = S("olivebush Seed"),
	harvest_description = S("Olive"),
	inventory_image = "farming_olivebush_seed.png",
	steps = 8,
	minlight = 13,
	maxlight = default.LIGHT_MAX,
	fertility = {"grassland", "desert"},
	groups = {flammable = 4},
})

--Register Decoration 
minetest.register_decoration({
	name = "farming:olivebush_wild",
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
	decoration = "farming:olivebush_wild",
})

--Register Item bakedolive
minetest.register_craftitem("farming:bakedolive", {
	description = S("Baked Olive"),
	inventory_image = "farming_bakedolive.png",
	groups = {flammable = 1},
})

--Register bake craft recipe
minetest.register_craft({
	type = "cooking",
	cooktime = 20,
	output = "farming:bakedolive",
	recipe = "farming:olivebush"
})

--Register Craft Recipe string
minetest.register_craft({
	output = "farming:oliveoil_bucket",
	recipe = {
		{"farming:olivebush"},
		{"group:stone"},
		{"bucket:bucket_empty"},
	}
})


--oliveoil

minetest.register_node("farming:oliveoil_source", {
	description = S("Oliveoil Source"),
	drawtype = "liquid",
	waving = 2,
	tiles = {
		{
			name = "farming_oliveoil_source_animated.png",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 2.0,
			},
		},
		{
			name = "farming_oliveoil_source_animated.png",
			backface_culling = true,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 2.0,
			},
		},
	},
	use_texture_alpha = "blend",
	paramtype = "light",
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	is_ground_content = false,
	drop = "",
	drowning = 1,
	liquidtype = "source",
	liquid_alternative_flowing = "farming:oliveoil_flowing",
	liquid_alternative_source = "farming:oliveoil_source",
	liquid_viscosity = 1,
	post_effect_color = {a = 103, r = 30, g = 60, b = 90},
	groups = {liquid = 2, cools_lava = 3},
	sounds = default.node_sound_water_defaults(),
})

minetest.register_node("farming:oliveoil_flowing", {
	description = S("Flowing Oliveoil"),
	drawtype = "flowingliquid",
	waving = 2,
	tiles = {"farming_oliveoil.png"},
	special_tiles = {
		{
			name = "farming_oliveoil_flowing_animated.png",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 0.5,
			},
		},
		{
			name = "farming_oliveoil_flowing_animated.png",
			backface_culling = true,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 0.5,
			},
		},
	},
	use_texture_alpha = "blend",
	paramtype = "light",
	paramtype2 = "flowingliquid",
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	is_ground_content = false,
	drop = "",
	drowning = 1,
	liquidtype = "flowing",
	liquid_alternative_flowing = "farming:oliveoil_flowing",
	liquid_alternative_source = "farming:oliveoil_source",
	liquid_viscosity = 1,
	post_effect_color = {a = 103, r = 30, g = 60, b = 90},
	groups = {liquid = 2, not_in_creative_inventory = 1,
		cools_lava = 3},
	sounds = default.node_sound_water_defaults(),
})

--Register Olive Oil bucket
bucket.register_liquid(
	"farming:oliveoil_source",
	"farming:oliveoil_flowing",
	"farming:oliveoil_bucket",
	"bucket_oliveoil.png",
	S("Olive Oil Bucket"),
	{tool = 1, water_bucket = 1}
)

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

--olivebush
minetest.register_craft({
	type = "fuel",
	recipe = "farming:olivebush",
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
		{name = "farming:seed_olivebush", chance = 0.4, count = {1, 4}},
		{name = "farming:seed_olivebush", chance = 0.4, count = {1, 4},
			types = {"normal"}},
	})
end



--Additional Grow size after placing fence over plant

-- Funktion zur Überprüfung, ob ein Seil über der Pflanze ist
local function check_rope_under(pos, nodename)
    local under_pos = {x = pos.x, y = pos.y - 1, z = pos.z}
    local under_node = minetest.get_node(under_pos)

    --checks if a wheat seed is under it
    if (under_node.name == 
	"farming:seed_wheat") or
	(under_node.name ==
	"farming:seed_hemp") or
	(under_node.name ==
	"farming:seed_olivebush")
	then

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

-- oil extractor

minetest.register_node("farming:oilextractor", {
    description = "Oil Extractor",  -- Beschreibung im Inventar
    tiles = {"farming_oilextractor_top.png", "farming_oilextractor_bottom.png", "farming_oilextractor_side.png"},  -- Texturen für oben, unten und Seiten
    groups = {cracky = 2},  -- Eigenschaften des Blocks, z.B. Werkzeugbeständigkeit
    sounds = default.node_sound_stone_defaults(),  -- Töne für den Block festlegen
    on_construct = function(pos)
        local meta = minetest.get_meta(pos)
        meta:set_string("formspec", "size[8,9]"..
            "list[current_name;input;2,1;1,1;]"..
            "list[current_name;fuel;2,3;1,1;]"..
            "list[current_name;output;5,2;1,1;]"..
            "list[current_player;main;0,5;8,4;]")
        meta:set_string("infotext", "Ofen")
        local inv = meta:get_inventory()
        inv:set_size("input", 1)
        inv:set_size("fuel", 1)
        inv:set_size("output", 1)
    end,
    on_metadata_inventory_put = function(pos, listname, index, stack, player)
        -- Funktion wird aufgerufen, wenn ein Gegenstand in das Inventar gelegt wird
        -- Hier können Sie die Logik für das Schmelzen von Gegenständen hinzufügen
        if listname == "input"
		 then
            local meta = minetest.get_meta(pos)
            meta:set_string("infotext", "Oil Extractor rohstoff bereit \n zum abbauen Spizhacke nutzen.")
            -- Hier können Sie die Schmelzlogik implementieren
        end
		if listname == "fuel"
		 then
            local meta = minetest.get_meta(pos)
            meta:set_string("infotext", "Oil Extractor brennstoff bereit \n zum abbauen Spizhacke nutzen.")
            -- Hier können Sie die Schmelzlogik implementieren
        end
    end,
})

-- Handwerksrezept für den Ofen registrieren
minetest.register_craft({
    output = "farming:oilextractor",
    recipe = {
        {"default:cobble", "", "default:cobble"},
        {"default:cobble", "default:furnace", "default:cobble"},
        {"default:cobble", "default:cobble", "default:cobble"},
    },
})

-- Ereignisregistrierung für den Punsch des Ofens
minetest.register_on_punchnode(function(pos, node, puncher)
    if node.name == "farming:oilextractor" then
        local meta = minetest.get_meta(pos)
        local inv = meta:get_inventory()
        
        -- Überprüfe, ob der Ofen Gegenstände im Eingabeinventar hat
        if not inv:is_empty("input") and 
		not inv:is_empty("fuel")
		then
			meta:set_string("infotext", "Oil Extractor arbeitet\n zum abbauen Spizhacke nutzen.")
            -- In diesem Beispiel wird der Gegenstand einfach ins Ausgabeinventar verschoben
            local input_stack = inv:get_stack("input", 1)
            local output_stack = inv:get_stack("output", 1)
            local fuel_stack = inv:get_stack("fuel", 1)
         -- Im Beispiel wird der Eingangsgegenstand einfach ins Ausgabeinventar verschoben
			local input_item = input_stack:take_item(1)  -- Item vom Input-Stack nehmen
			fuel_stack:take_item(1)
			output_stack:add_item(input_item)  -- Item dem Ausgabe-Stack hinzufügen
			inv:set_stack("output", 1, output_stack)
			inv:set_stack("input", 1, input_stack)
			inv:set_stack("fuel", 1, fuel_stack)
        else
            meta:set_string("infotext", "Oil extractor ist leer\n zum abbauen Spizhacke nutzen.")
        end
    end
end)
