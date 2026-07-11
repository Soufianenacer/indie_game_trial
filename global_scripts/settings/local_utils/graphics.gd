extends Node
# ============= ENUMS =============
enum VSyncMode {
	DISABLED = 0,
	ENABLED = 1,
	ADAPTIVE = 2,
	MAILBOX = 3,
}

enum MaxFPS {
	UNLIMITED = 0,
	FPS_30 = 1,
	FPS_60 = 2,
	FPS_120 = 3,
	FPS_144 = 4,
	FPS_240 = 5,
}

enum ResolutionPreset {
	RES_1280_720 = 0,
	RES_1366_768 = 1,
	RES_1920_1080 = 2,
	RES_2560_1440 = 3,
}

enum ScreenModePreset {
	EXCLUSIVE_FULLSCREEN = 0,
	BORDERLESS = 1,
	WINDOWED = 2,
}

# ============= CONSTANTS & DICTS =============
const RESOLUTION_VALUES = {
	ResolutionPreset.RES_1280_720: Vector2i(1280, 720),
	ResolutionPreset.RES_1366_768: Vector2i(1366, 768),
	ResolutionPreset.RES_1920_1080: Vector2i(1920, 1080),
	ResolutionPreset.RES_2560_1440: Vector2i(2560, 1440),
}

const RESOLUTION_LABELS = {
	ResolutionPreset.RES_1280_720: "1280 x 720",
	ResolutionPreset.RES_1366_768: "1366 x 768",
	ResolutionPreset.RES_1920_1080: "1920 x 1080",
	ResolutionPreset.RES_2560_1440: "2560 x 1440",
}

const SCREEN_MODE_VALUES = {
	ScreenModePreset.EXCLUSIVE_FULLSCREEN: DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN,
	ScreenModePreset.BORDERLESS: DisplayServer.WINDOW_MODE_FULLSCREEN,
	ScreenModePreset.WINDOWED: DisplayServer.WINDOW_MODE_WINDOWED,
}

const SCREEN_MODE_LABELS = {
	ScreenModePreset.EXCLUSIVE_FULLSCREEN: "Fullscreen",
	ScreenModePreset.BORDERLESS: "Borderless",
	ScreenModePreset.WINDOWED: "Windowed",
}

const VSYNC_DIC = {
	"Disabled": VSyncMode.DISABLED,
	"Enabled": VSyncMode.ENABLED,
	"Adaptive": VSyncMode.ADAPTIVE,
	"Mailbox": VSyncMode.MAILBOX,
}

const MAX_FPS_DIC = {
	"Unlimited": MaxFPS.UNLIMITED,
	"30": MaxFPS.FPS_30,
	"60": MaxFPS.FPS_60,
	"120": MaxFPS.FPS_120,
	"144": MaxFPS.FPS_144,
	"240": MaxFPS.FPS_240,
}

const FPS_VALUES = {
	MaxFPS.UNLIMITED: 0,
	MaxFPS.FPS_30: 30,
	MaxFPS.FPS_60: 60,
	MaxFPS.FPS_120: 120,
	MaxFPS.FPS_144: 144,
	MaxFPS.FPS_240: 240,
}

const FPS_LABELS = {
	MaxFPS.UNLIMITED: "Unlimited",
	MaxFPS.FPS_30: "30",
	MaxFPS.FPS_60: "60",
	MaxFPS.FPS_120: "120",
	MaxFPS.FPS_144: "144",
	MaxFPS.FPS_240: "240",
}
