return {
	-- Active theme (loads on startup)
	{
		"rebelot/kanagawa.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("kanagawa").setup({
				compile = false,
				undercurl = true,
				commentStyle = { italic = true },
				functionStyle = { bold = true },
				keywordStyle = { bold = true },
				statementStyle = { bold = true },
				typeStyle = {},
				transparent = false,
				dimInactive = false,
				terminalColors = true,
				colors = {
					theme = {
						all = {
							ui = {
								bg_gutter = "none",
							},
						},
					},
				},
				background = {
					dark = "wave",
					light = "lotus",
				},
			})
			vim.cmd.colorscheme("kanagawa")
		end,
	},

	-- Theme collection
	{ "slugbyte/lackluster.nvim", lazy = true },
	{ "catppuccin/nvim", name = "catppuccin", lazy = true },
	{ "folke/tokyonight.nvim", lazy = true },
	{ "rose-pine/neovim", name = "rose-pine", lazy = true },
	{ "sainnhe/gruvbox-material", lazy = true },
	{ "EdenEast/nightfox.nvim", lazy = true },
	{ "navarasu/onedark.nvim", lazy = true },
	{ "sainnhe/everforest", lazy = true },
	{ "bluz71/vim-nightfly-colors", name = "nightfly", lazy = true },
	{ "bluz71/vim-moonfly-colors", name = "moonfly", lazy = true },
	{ "projekt0n/github-nvim-theme", lazy = true },
	{ "Mofiqul/dracula.nvim", lazy = true },
	{ "blazkowolf/gruber-darker.nvim", lazy = true },
	{ "sainnhe/sonokai", lazy = true },
	{ "nyoom-engineering/oxocarbon.nvim", lazy = true },
	{ "ellisonleao/gruvbox.nvim", lazy = true },
	{ "scottmckendry/cyberdream.nvim", lazy = true },
	{ "Mofiqul/vscode.nvim", lazy = true },
	{ "nordtheme/vim", name = "nord", lazy = true },
	{ "shaunsingh/solarized.nvim", lazy = true },
	{ "marko-cerovac/material.nvim", lazy = true },
	{ "AlexvZyl/nordic.nvim", lazy = true },
	{ "neanias/everforest-nvim", name = "everforest-nvim", lazy = true },
	{ "craftzdog/solarized-osaka.nvim", lazy = true },
	{ "0xstepit/flow.nvim", lazy = true },
	{ "HoNamDuong/hybrid.nvim", lazy = true },
	{ "ribru17/bamboo.nvim", lazy = true },
	{ "kepano/flexoki-neovim", name = "flexoki", lazy = true },
	{ "savq/melange-nvim", lazy = true },
	{ "mcchrish/zenbones.nvim", dependencies = "rktjmp/lush.nvim", lazy = true },
	{ "ramojus/mellifluous.nvim", lazy = true },
	{ "dgox16/oldworld.nvim", lazy = true },
	{ "olivercederborg/poimandres.nvim", lazy = true },
	{ "miikanissi/modus-themes.nvim", lazy = true },
	{ "sainnhe/edge", lazy = true },
	{ "tanvirtin/monokai.nvim", lazy = true },
	{ "shaunsingh/moonlight.nvim", lazy = true },
	{ "ray-x/aurora", lazy = true },
	{ "tiagovla/tokyodark.nvim", lazy = true },
	{ "Shatur/neovim-ayu", lazy = true },
	{ "kvrohit/rasmus.nvim", lazy = true },
	{ "lewpoly/sherbet.nvim", lazy = true },
	{ "dasupradyumna/midnight.nvim", lazy = true },
	{ "Abstract-IDE/Abstract-cs", lazy = true },
	{ "rockyzhang24/arctic.nvim", dependencies = "rktjmp/lush.nvim", lazy = true },
	{ "decaycs/decay.nvim", name = "decay", lazy = true },
	{ "kaiuri/nvim-juliana", lazy = true },
	{ "lmburns/kimbox", lazy = true },
	{ "maxmx03/fluoromachine.nvim", lazy = true },
	{ "uloco/bluloco.nvim", dependencies = "rktjmp/lush.nvim", lazy = true },
	{ "loctvl842/monokai-pro.nvim", lazy = true },
	{ "olimorris/onedarkpro.nvim", lazy = true },
	{ "Tsuzat/NeoSolarized.nvim", lazy = true },
	{ "water-sucks/darkrose.nvim", lazy = true },
	{ "titanzero/zephyrium", lazy = true },
	{ "2nthony/vitesse.nvim", dependencies = "MunifTanjim/nui.nvim", lazy = true },
	{ "xero/miasma.nvim", lazy = true },
	{ "ficcdaf/ashen.nvim", lazy = true },
	{ "comfysage/evergarden", lazy = true },
	{ "eldritch-theme/eldritch.nvim", lazy = true },
	{ "sho-87/kanagawa-paper.nvim", lazy = true },
	{ "nyngwang/nvimgelion", lazy = true },
	{ "luisiacc/gruvbox-baby", lazy = true },
	{ "sam4llis/nvim-tundra", lazy = true },
	{ "zootedb0t/citruszest.nvim", lazy = true },
	{ "Yazeed1s/oh-lucy.nvim", lazy = true },
	{ "AlphaTechnolog/pywal.nvim", name = "pywal", lazy = true },
	{ "kartikp10/noctis.nvim", dependencies = "rktjmp/lush.nvim", lazy = true },
	{ "RRethy/base16-nvim", lazy = true },
	{ "kdheepak/monochrome.nvim", lazy = true },
	{ "mhartington/oceanic-next", lazy = true },
	{ "rafamadriz/neon", lazy = true },
	{ "yashguptaz/calvera-dark.nvim", lazy = true },
	{ "Everblush/nvim", name = "everblush", lazy = true },
	{ "kvrohit/substrata.nvim", lazy = true },
	{ "fenetikm/falcon", lazy = true },
	{ "embark-theme/vim", name = "embark", lazy = true },
	{ "jim-at-jibba/ariake.nvim", lazy = true },
	{ "adisen99/apprentice.nvim", dependencies = "rktjmp/lush.nvim", lazy = true },
	{ "rmehri01/onenord.nvim", lazy = true },
	{ "cpea2506/one_monokai.nvim", lazy = true },
	{ "AstroNvim/astrotheme", lazy = true },
	{ "Mofiqul/adwaita.nvim", lazy = true },
	{ "hardhackerlabs/theme-vim", name = "hardhacker", lazy = true },
	{ "metalelf0/jellybeans-nvim", dependencies = "rktjmp/lush.nvim", lazy = true },
	{ "NTBBloodbath/doom-one.nvim", lazy = true },
	{ "jesseleite/nvim-noirbuddy", dependencies = "tjdevries/colorbuddy.nvim", lazy = true },
	{ "mellow-theme/mellow.nvim", lazy = true },
	{ "Yazeed1s/minimal.nvim", lazy = true },

	-- Theme switcher
	{
		"zaldih/themery.nvim",
		lazy = false,
		keys = {
			{ "<leader>tt", "<cmd>Themery<cr>", desc = "Theme switcher" },
		},
		opts = {
			themes = {
				-- Kanagawa
				{ name = "Kanagawa Wave", colorscheme = "kanagawa-wave" },
				{ name = "Kanagawa Dragon", colorscheme = "kanagawa-dragon" },
				{ name = "Kanagawa Lotus", colorscheme = "kanagawa-lotus" },
				-- Lackluster
				{ name = "Lackluster", colorscheme = "lackluster" },
				{ name = "Lackluster Hack", colorscheme = "lackluster-hack" },
				{ name = "Lackluster Mint", colorscheme = "lackluster-mint" },
				-- Catppuccin
				{ name = "Catppuccin Mocha", colorscheme = "catppuccin-mocha" },
				{ name = "Catppuccin Macchiato", colorscheme = "catppuccin-macchiato" },
				{ name = "Catppuccin Frappe", colorscheme = "catppuccin-frappe" },
				{ name = "Catppuccin Latte", colorscheme = "catppuccin-latte" },
				-- Tokyo Night
				{ name = "Tokyo Night", colorscheme = "tokyonight-night" },
				{ name = "Tokyo Night Storm", colorscheme = "tokyonight-storm" },
				{ name = "Tokyo Night Moon", colorscheme = "tokyonight-moon" },
				{ name = "Tokyo Night Day", colorscheme = "tokyonight-day" },
				-- Rose Pine
				{ name = "Rose Pine", colorscheme = "rose-pine-main" },
				{ name = "Rose Pine Moon", colorscheme = "rose-pine-moon" },
				{ name = "Rose Pine Dawn", colorscheme = "rose-pine-dawn" },
				-- Gruvbox Material
				{ name = "Gruvbox Material", colorscheme = "gruvbox-material" },
				-- Nightfox
				{ name = "Nightfox", colorscheme = "nightfox" },
				{ name = "Dawnfox", colorscheme = "dawnfox" },
				{ name = "Carbonfox", colorscheme = "carbonfox" },
				{ name = "Nordfox", colorscheme = "nordfox" },
				-- OneDark
				{ name = "OneDark", colorscheme = "onedark" },
				-- Everforest
				{ name = "Everforest", colorscheme = "everforest" },
				-- Nightfly / Moonfly
				{ name = "Nightfly", colorscheme = "nightfly" },
				{ name = "Moonfly", colorscheme = "moonfly" },
				-- GitHub
				{ name = "GitHub Dark", colorscheme = "github_dark" },
				{ name = "GitHub Dark Dimmed", colorscheme = "github_dark_dimmed" },
				{ name = "GitHub Light", colorscheme = "github_light" },
				-- Dracula
				{ name = "Dracula", colorscheme = "dracula" },
				-- Gruber Darker
				{ name = "Gruber Darker", colorscheme = "gruber-darker" },
				-- Sonokai
				{ name = "Sonokai", colorscheme = "sonokai" },
				-- Oxocarbon
				{ name = "Oxocarbon", colorscheme = "oxocarbon" },
				-- Gruvbox
				{ name = "Gruvbox Dark", colorscheme = "gruvbox" },
				-- Cyberdream
				{ name = "Cyberdream", colorscheme = "cyberdream" },
				{ name = "Cyberdream Light", colorscheme = "cyberdream-light" },
				-- VSCode
				{ name = "VSCode Dark", colorscheme = "vscode" },
				-- Nord
				{ name = "Nord", colorscheme = "nord" },
				-- Solarized
				{ name = "Solarized", colorscheme = "solarized" },
				-- Material
				{ name = "Material Deep Ocean", colorscheme = "material-deep-ocean" },
				{ name = "Material Oceanic", colorscheme = "material-oceanic" },
				{ name = "Material Palenight", colorscheme = "material-palenight" },
				{ name = "Material Darker", colorscheme = "material-darker" },
				-- Nordic
				{ name = "Nordic", colorscheme = "nordic" },
				-- Solarized Osaka
				{ name = "Solarized Osaka", colorscheme = "solarized-osaka" },
				-- Flow
				{ name = "Flow", colorscheme = "flow" },
				-- Hybrid
				{ name = "Hybrid", colorscheme = "hybrid" },
				-- Bamboo
				{ name = "Bamboo", colorscheme = "bamboo" },
				-- Flexoki
				{ name = "Flexoki Dark", colorscheme = "flexoki-dark" },
				{ name = "Flexoki Light", colorscheme = "flexoki-light" },
				-- Melange
				{ name = "Melange", colorscheme = "melange" },
				-- Zenbones
				{ name = "Zenbones", colorscheme = "zenbones" },
				{ name = "Tokyobones", colorscheme = "tokyobones" },
				{ name = "Rosebones", colorscheme = "rosebones" },
				-- Mellifluous
				{ name = "Mellifluous", colorscheme = "mellifluous" },
				-- Old World
				{ name = "Old World", colorscheme = "oldworld" },
				-- Poimandres
				{ name = "Poimandres", colorscheme = "poimandres" },
				-- Modus
				{ name = "Modus Vivendi", colorscheme = "modus_vivendi" },
				{ name = "Modus Operandi", colorscheme = "modus_operandi" },
				-- Edge
				{ name = "Edge", colorscheme = "edge" },
				-- Monokai
				{ name = "Monokai", colorscheme = "monokai" },
				{ name = "Monokai Soda", colorscheme = "monokai_soda" },
				{ name = "Monokai Pro", colorscheme = "monokai-pro" },
				{ name = "Monokai Pro Machine", colorscheme = "monokai-pro-machine" },
				{ name = "Monokai Pro Octagon", colorscheme = "monokai-pro-octagon" },
				{ name = "Monokai Pro Spectrum", colorscheme = "monokai-pro-spectrum" },
				{ name = "Monokai Pro Ristretto", colorscheme = "monokai-pro-ristretto" },
				{ name = "Monokai Pro Classic", colorscheme = "monokai-pro-classic" },
				-- Moonlight
				{ name = "Moonlight", colorscheme = "moonlight" },
				-- Aurora
				{ name = "Aurora", colorscheme = "aurora" },
				-- Tokyo Dark
				{ name = "Tokyo Dark", colorscheme = "tokyodark" },
				-- Ayu
				{ name = "Ayu Dark", colorscheme = "ayu-dark" },
				{ name = "Ayu Mirage", colorscheme = "ayu-mirage" },
				{ name = "Ayu Light", colorscheme = "ayu-light" },
				-- Rasmus
				{ name = "Rasmus", colorscheme = "rasmus" },
				-- Sherbet
				{ name = "Sherbet", colorscheme = "sherbet" },
				-- Midnight
				{ name = "Midnight", colorscheme = "midnight" },
				-- Abstract
				{ name = "Abstract", colorscheme = "abstract_cs" },
				-- Arctic
				{ name = "Arctic", colorscheme = "arctic" },
				-- Decay
				{ name = "Decay", colorscheme = "decay" },
				-- Juliana
				{ name = "Juliana", colorscheme = "juliana" },
				-- Kimbox
				{ name = "Kimbox", colorscheme = "kimbox" },
				-- Fluoromachine
				{ name = "Fluoromachine", colorscheme = "fluoromachine" },
				-- Bluloco
				{ name = "Bluloco Dark", colorscheme = "bluloco-dark" },
				{ name = "Bluloco Light", colorscheme = "bluloco-light" },
				-- OneDarkPro
				{ name = "OneDark Pro", colorscheme = "onedark" },
				{ name = "OneDark Pro Vivid", colorscheme = "onedark_vivid" },
				{ name = "OneDark Pro Dark", colorscheme = "onedark_dark" },
				-- NeoSolarized
				{ name = "NeoSolarized", colorscheme = "NeoSolarized" },
				-- Darkrose
				{ name = "Darkrose", colorscheme = "darkrose" },
				-- Zephyrium
				{ name = "Zephyrium", colorscheme = "zephyrium" },
				-- Vitesse
				{ name = "Vitesse", colorscheme = "vitesse" },
				-- Miasma
				{ name = "Miasma", colorscheme = "miasma" },
				-- Ashen
				{ name = "Ashen", colorscheme = "ashen" },
				-- Evergarden
				{ name = "Evergarden", colorscheme = "evergarden" },
				-- Eldritch
				{ name = "Eldritch", colorscheme = "eldritch" },
				-- Kanagawa Paper
				{ name = "Kanagawa Paper", colorscheme = "kanagawa-paper" },
				-- Nvimgelion
				{ name = "Nvimgelion", colorscheme = "nvimgelion" },
				-- Gruvbox Baby
				{ name = "Gruvbox Baby", colorscheme = "gruvbox-baby" },
				-- Tundra
				{ name = "Tundra", colorscheme = "tundra" },
				-- Citruszest
				{ name = "Citruszest", colorscheme = "citruszest" },
				-- Oh Lucy
				{ name = "Oh Lucy", colorscheme = "oh-lucy" },
				{ name = "Oh Lucy Evening", colorscheme = "oh-lucy-evening" },
				-- Pywal
				{ name = "Pywal", colorscheme = "pywal" },
				-- Noctis
				{ name = "Noctis", colorscheme = "noctis" },
				-- Monochrome
				{ name = "Monochrome", colorscheme = "monochrome" },
				-- Oceanic Next
				{ name = "Oceanic Next", colorscheme = "OceanicNext" },
				-- Neon
				{ name = "Neon", colorscheme = "neon" },
				-- Calvera
				{ name = "Calvera Dark", colorscheme = "calvera" },
				-- Everblush
				{ name = "Everblush", colorscheme = "everblush" },
				-- Substrata
				{ name = "Substrata", colorscheme = "substrata" },
				-- Falcon
				{ name = "Falcon", colorscheme = "falcon" },
				-- Embark
				{ name = "Embark", colorscheme = "embark" },
				-- Ariake
				{ name = "Ariake Dark", colorscheme = "ariake-dark" },
				-- Apprentice
				{ name = "Apprentice", colorscheme = "apprentice" },
				-- OneNord
				{ name = "OneNord", colorscheme = "onenord" },
				-- One Monokai
				{ name = "One Monokai", colorscheme = "one_monokai" },
				-- AstroTheme
				{ name = "AstroDark", colorscheme = "astrodark" },
				{ name = "AstroLight", colorscheme = "astrolight" },
				{ name = "AstroMars", colorscheme = "astromars" },
				-- Adwaita
				{ name = "Adwaita Dark", colorscheme = "adwaita" },
				-- HardHacker
				{ name = "HardHacker", colorscheme = "hardhacker" },
				-- Jellybeans
				{ name = "Jellybeans", colorscheme = "jellybeans-nvim" },
				-- Doom One
				{ name = "Doom One", colorscheme = "doom-one" },
				-- Noirbuddy
				{ name = "Noirbuddy", colorscheme = "noirbuddy" },
				-- Mellow
				{ name = "Mellow", colorscheme = "mellow" },
				-- Minimal
				{ name = "Minimal", colorscheme = "minimal" },
				{ name = "Minimal Base16", colorscheme = "minimal-base16" },
			},
			livePreview = true,
		},
	},
}
