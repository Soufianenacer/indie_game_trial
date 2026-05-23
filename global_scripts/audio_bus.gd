extends Node



# ========= audio resource oath ========= #
const default_resource_state_path: String = \
"res://global_scripts/resources/audio_res.tres"

# ========= preload ========= #
const audioPaths = \
preload("res://global_scripts/resources/audio_paths.gd")
var audio_paths = audioPaths.new()

# ========= local variables ========= #
const POOL_SIZE: int = 10
var _pool: Array[AudioStreamPlayer2D] = []
var sounds: Dictionary[String, Audio] = {}
var audios: Array[Dictionary] = []

func _ready() -> void:
	audios = audio_paths.audios
	_audio_loader()
	_create_pool()


func _create_pool() -> void:
	for i in POOL_SIZE:
		var player: AudioStreamPlayer2D = AudioStreamPlayer2D.new()
		add_child(player)
		_pool.append(player)

func _play_sound_at(target: Node, audio_name: String, volume_db: float = 0.0, pitch: float = 1.0) -> void:
	if not sounds.has(audio_name):
		printerr("sound not found: " + audio_name)
		return
		
	var player: AudioStreamPlayer2D = _get_free_player()
	if not player:
		return
	
	var current_sound: Audio = sounds[audio_name]
	
	player.bus = current_sound.audio_bus
	player.stream = current_sound.audio_stream
	player.global_position = target.global_position
	
	player.volume_db = volume_db
	player.pitch_scale = pitch
	
	player.playing = true
	player.play()

func _audio_loader() -> void:
	for audio in audios:
		var path: String = audio["audio_stream"]
		
		if not ResourceLoader.exists(path):
			printerr(audio["audio_name"] + " does not exist at path: " + path)
			continue
		
		var new_resource: Audio = Audio.new()
		
		new_resource.sound_name = audio["audio_name"]
		new_resource.audio_bus = audio["audio_bus"]
		new_resource.audio_stream = load(path)
		
		sounds[audio["audio_name"]] = new_resource

func _get_free_player() -> AudioStreamPlayer2D:
	for player in _pool:
		if not player.playing:
			return player
	return _pool[0]

# WARNING here are the functions that you can use in the menu settings ui
# i didnt want to add things to the menu ui khelithalk lik

# -> AudioManager.set_bus_volume(-10.0, "Master")    # lower master volume
# -> AudioManager.set_bus_mute(true, "Music")        # mute music bus
# -> AudioManager.stop_sound("explosion")            # stop specific sound
# -> AudioManager.pause_all()                        # pause on game pause
# -> AudioManager.stop_all()                         # clear everything
# -> AudioManager.is_playing("footstep")             # check before re-triggering

# ========= public API ========= #
# stop a specific sound by name (stops first matching player)
func stop_sound(audio_name: String) -> void:
	for player in _pool:
		if player.playing and player.stream == sounds.get(audio_name, Audio.new()).audio_stream:
			player.stop()
			return

# stop all currently playing sounds
func stop_all() -> void:
	for player in _pool:
		if player.playing:
			player.stop()

# pause / resume all sounds (useful for pausing the game)
func pause_all() -> void:
	for player in _pool:
		player.stream_paused = true
func resume_all() -> void:
	for player in _pool:
		player.stream_paused = false

# set volume on a specific bus (master by default)
func set_bus_volume(volume_db: float, bus_name: String = "Master") -> void:
	var idx: int = AudioServer.get_bus_index(bus_name)
	if idx == -1:
		printerr("AudioManager: bus not found: " + bus_name)
		return
	
	# WARNING Offset custom volume range to Godot's dB bus range (50 -> 0 dB).
	# this constant need to be the same number as the number in the option slinder
	AudioServer.set_bus_volume_db(idx, volume_db - 50)

# get current volume of a bus
func get_bus_volume(bus_name: String = "Master") -> float:
	var idx: int = AudioServer.get_bus_index(bus_name)
	if idx == -1:
		printerr("AudioManager: bus not found: " + bus_name)
		return 0.0
	return AudioServer.get_bus_volume_db(idx)

# mute / unmute a bus
func set_bus_mute(muted: bool, bus_name: String = "Master") -> void:
	var idx: int = AudioServer.get_bus_index(bus_name)
	if idx == -1:
		printerr("AudioManager: bus not found: " + bus_name)
		return
	AudioServer.set_bus_mute(idx, muted)

func is_bus_muted(bus_name: String = "Master") -> bool:
	var idx: int = AudioServer.get_bus_index(bus_name)
	if idx == -1:
		return false
	return AudioServer.is_bus_mute(idx)

# check if a specific sound is currently playing
func is_playing(audio_name: String) -> bool:
	if not sounds.has(audio_name):
		return false
	for player in _pool:
		if player.playing and player.stream == sounds[audio_name].audio_stream:
			return true
	return false

# how many pool slots are currently in use
func get_active_count() -> int:
	var count: int = 0
	for player in _pool:
		if player.playing:
			count += 1
	return count

# TODO: add a pitch randomizer and controller









	
