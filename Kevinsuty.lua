local lovely = require("lovely")
local nativefs = require("nativefs")

KEVINSUTY = {config_file = {unjank_flowey = false}, vars = {}, funcs = {}, content = SMODS.current_mod}
if nativefs.read(lovely.mod_dir.."/KevinsUTY/config.lua") then
    KEVINSUTY.config_file = STR_UNPACK(nativefs.read(lovely.mod_dir.."/KevinsUTY/config.lua"))
end
local filesystem = NFS or love.filesystem

local config = KEVINSUTY.content.config

-- Config

function KEVINSUTY.content.save_config(self)
    SMODS.save_mod_config(self)
end

function KEVINSUTY.content.config_tab()
    return {n = G.UIT.ROOT, config = {r = 0.1, minw = 4, align = "tm", padding = 0.2, colour = G.C.BLACK}, nodes = {
        {n = G.UIT.C, config = {r = 0.1, minw = 4, align = "tl", padding = 0.2, colour = G.C.BLACK}, nodes =
            {
                {
                    n = G.UIT.R,
                    config = {
                        align = "cm",
                        r = 0.1,
                        emboss = 0.1,
                        outline = 1,
                        padding = 0.14
                    },
                    nodes = {
                        create_toggle({
                            label = "Unjank Flowey",
							scale = 1,
                            info = {
                                'Disabled by default, Requires restart',
                                '',
                                "Enable this to replace Flowey with a less jank",
								"version that effectively does the same thing"
                            },
                            ref_table = KEVINSUTY.config_file,
                            ref_value = 'unjank_flowey',
                            callback = function(_set_toggle)
								nativefs.write(lovely.mod_dir .. "/KevinsUTY/config.lua", STR_PACK(KEVINSUTY.config_file))
                        end})
                    }
                }
            }
        }
    }}
end

-- Credits

SMODS.current_mod.extra_tabs = function()
    local text_scale = 0.6
	return {
		{
			label = G.localization.misc.dictionary.b_credits,
			tab_definition_function = function()
				return {n = G.UIT.ROOT, config = {r = 0.1, minw = 4, align = "tm", padding = 0.2, colour = G.C.BLACK}, nodes = {
                {n=G.UIT.R, config={align = "cm", padding = 0.1, outline_colour = G.C.JOKER_GREY, r = 0.1, outline = 1}, nodes={
                    {n=G.UIT.R, config={align = "cm", padding = 0}, nodes={
                        {n=G.UIT.T, config={text = 'Credits', scale = text_scale*1, colour = G.C.ORANGE, shadow = true}},
                    }},
                    {n=G.UIT.R, config={align = "tm", padding = 0}, nodes={
                        {n=G.UIT.C, config={align = "tl", padding = 0.05, minw = 2.0}, nodes={
                            {n=G.UIT.R, config={align = "cm", padding = 0}, nodes={
                                {n=G.UIT.T, config={text = 'Coding/Art:', scale = text_scale*0.6, colour = G.C.UI.TEXT_DARK, shadow = true}},
                            }},
							{n=G.UIT.R, config={align = "cm", padding = 0}, nodes={
                                {n=G.UIT.T, config={text = 'SurelyNotClover', scale = text_scale*0.75, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
                            }},
							{n=G.UIT.R, config={align = "cm", padding = 0}, nodes={
                                {n=G.UIT.T, config={text = 'Major Coding Help:', scale = text_scale*0.6, colour = G.C.UI.TEXT_DARK, shadow = true}},
                            }},
							{n=G.UIT.R, config={align = "cm", padding = 0}, nodes={
                                {n=G.UIT.T, config={text = 'Balatro Modding Discord', scale = text_scale*0.75, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
                            }},
							{n=G.UIT.R, config={align = "cm", padding = 0}, nodes={
                                {n=G.UIT.T, config={text = 'Friends Of Kevin Skins:', scale = text_scale*0.6, colour = G.C.UI.TEXT_DARK, shadow = true}},
                            }},
                        }},
                    }},
                    }}
				}}
			end,
		}
	}
end

-- SMODS optional features

SMODS.current_mod.optional_features = {
    retrigger_joker = true
}

-- Loading Jokers/Challenges

assert(SMODS.load_file('src/1main.lua'))()
assert(SMODS.load_file('src/2ruins.lua'))()
assert(SMODS.load_file('src/3snowdin.lua'))()
assert(SMODS.load_file('src/4dunes.lua'))()
assert(SMODS.load_file('src/5steamworks.lua'))()
assert(SMODS.load_file('src/challenges.lua'))()
assert(SMODS.load_file('src/7kevin.lua'))()

if KEVINSUTY.config_file.kevin_self_insert then
	
end

-- Loading Sprites


SMODS.Atlas{
	key = 'Main',
	path = '1Main.png',
	px = 71,
	py = 95
}

SMODS.Atlas{
	key = 'Ruins',
	path = '2Ruins.png',
	px = 71,
	py = 95
}

SMODS.Atlas{
	key = 'Snowdin',
	path = '3Snowdin.png',
	px = 71,
	py = 95
}

SMODS.Atlas{
	key = 'Dunes',
	path = '4Dunes.png',
	px = 71,
	py = 95
}

SMODS.Atlas{
	key = 'Steamworks',
	path = '5Steamworks.png',
	px = 71,
	py = 95
}

SMODS.Atlas {
    key = "modicon",
    path = "icon.png",
    px = 34,
    py = 34
}

-- Token Rarity

SMODS.Rarity{
	key = "token",
	loc_txt = {
		name = "Token"
	},
	default_weight = 0,
	badge_colour = HEX("00C800"),
	pools = {["Joker"] = false},
	get_weight = function(self, weight, object_type)
			return weight
	end,
}

SMODS.Joker{
	key = 'token_joker',
	loc_txt = {
		name = 'Token Joker',
		text = {
		'Must be created',
		'by another {C:attention}Joker{}',
		}
	},
	rarity = 'sncuty_token',
	unlocked = true,
	discovered = true,
	no_collection = true,
	pos = {x = 4, y = 4}
}

-- Irretriggerable Joker

SMODS.Joker{
	key = 'irretriggerable',
	loc_txt = {
		name = 'Irretriggerable',
		text = {
		'This Joker',
		'{C:attention}cannot{} be',
		'retriggered',
		}
	},
	rarity = 'sncuty_token',
	unlocked = true,
	discovered = true,
	no_collection = true,
	pos = {x = 4, y = 4}
}

-- Mod Compatabilities

if JokerDisplay then
    SMODS.load_file("compatibility/joker_display_definitions.lua")()
end

if (SMODS.Mods["partner"] or {}).can_load then
	SMODS.load_file("compatibility/partner.lua")()
end

-- Secret Hand Detection (yoinked from Undertale Mod)

function played_secret_hand(played_hands)
	local base = false
	local problematic = false
	local cryptid = false
	local bunco = false
	local sixsuits = false
	
	if next(played_hands["Five of a Kind"]) or
	next(played_hands["Flush Five"]) or
	next(played_hands["Flush House"]) then
		base = true
	end
	
	if (SMODS.Mods["TWT"] or {}).can_load then
		if next(played_hands["TWT_greaterpolycule"]) then
			 problematic = true
		end
	end
	if (SMODS.Mods["Cryptid"] or {}).can_load then
		if next(played_hands["cry_Bulwark"]) or
		next(played_hands["cry_Clusterfuck"]) or
		next(played_hands["cry_UltPair"]) or
		next(played_hands["cry_WholeDeck"]) then
			cryptid = true
		end
	end
	
	if (SMODS.Mods["Bunco"] or {}).can_load then
		if next(played_hands["bunc_Spectrum"]) or
		next(played_hands["bunc_Straight Spectrum"]) or
		next(played_hands["bunc_Spectrum House"]) or
		next(played_hands["bunc_Spectrum Five"]) then
			bunco = true
		end
	end
	
	if (SMODS.Mods["SixSuits"] or {}).can_load then
		if next(played_hands["six_Spectrum House"]) or
		next(played_hands["six_Spectrum Five"]) then
			sixsuits = true
		end
	end
	
	return uty or base or problematic or cryptid or bunco or sixsuits
end

-- Tag adding code shamelessly stolen from Paperback mod

if not (SMODS.Mods["Paperback"] or {}).can_load then
	PB_UTIL = {}

	function PB_UTIL.poll_tag(seed, options)
	
	local pool = options or get_current_pool('Tag')
	local tag_key = pseudorandom_element(pool, pseudoseed(seed))
	
	while tag_key == 'UNAVAILABLE' do
	  tag_key = pseudorandom_element(pool, pseudoseed(seed))
	end
	
	local tag = Tag(tag_key)
	
	if tag_key == "tag_orbital" then
	  local available_hands = {}
	
	  for k, hand in pairs(G.GAME.hands) do
		if hand.visible then
		  available_hands[#available_hands + 1] = k
		end
	  end
	
	  tag.ability.orbital_hand = pseudorandom_element(available_hands, pseudoseed(seed .. '_orbital'))
	end
	
	return tag
	end

	function PB_UTIL.add_tag(tag, event, silent)
		local func = function()
		  add_tag(type(tag) == 'string' and Tag(tag) or tag)
		  if not silent then
			play_sound('generic1', 0.9 + math.random() * 0.1, 0.8)
			play_sound('holo1', 1.2 + math.random() * 0.1, 0.4)
		  end
		  return true
		end
	  
		if event then
		  G.E_MANAGER:add_event(Event {
			func = func
		  })
		else
		  func()
		end
	  end
end

-- Setting up values for jokers on starting a run

local gigo = Game.init_game_object
function Game:init_game_object()
	local g = gigo(self)
	g.jokers_sold = {}
	g.last_used_tarot = nil
	g.extra_pack_size = 0
	g.stones_ignore_selection = false
	g.uty_heist = false
	return g
end

--[[

-----TODO:----- 

0 - top-priority:
update the self-ship challenge (add no_planets rule, maybe)
unjank flowey (specifically context.repetition (only triggering message) and context.individual (triggering before the card)) (soft fix in a form of an old Flowey)
new idea: retrigger all 7s (played or not)
change Ace (XMult per ace drawn instead not played)

0 - mid-priority:
fix Pedla soft-locking if retriggered too much (fixed?)
ask around for people willing to contribute to 'friends of kevin'
figure out malverk

0 - low-priority:
redraw Jandroid, Penilla
add JokerDisplay compatibility for Pops

]]
