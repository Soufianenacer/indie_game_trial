extends Node



# ========= audio resource oath ========= #
const default_resource_state_path: String = "res://global_scripts/audio/audio_res.tres"
# ========= preload ========= #
const audioPaths = preload("res://global_scripts/audio/audio_paths.gd")
var audio_paths = audioPaths.new()

# ========= local variables ========= #
var sounds: Dictionary[String, AudioStreamPlayer2D] = {}

func _ready() -> void:
	_create_pool()

func _create_pool() -> void:
	for audio_path in audio_paths.audios:
		var new_audio: AudioStreamPlayer2D = AudioStreamPlayer2D.new()
		new_audio.name = audio_path.get("audio_name")
		new_audio.stream = load(audio_path.get("audio_stream"))
		new_audio.bus = audio_path.get("audio_bus")
		new_audio.volume_db = audio_path.get("audio_volume_db")
		new_audio.pitch_scale = audio_path.get("audio_pitch_scale")
		
		sounds[audio_path.get("audio_name")] = new_audio
		add_child(new_audio)

func _play_sound(sound_name: String,is_random_pitch: bool ,target: Node2D = null) -> void:
	if not sounds.has(sound_name):
		print("no sound here ma nigga")
		return
	print("no sound here ma nigga")
	var player: AudioStreamPlayer2D = sounds[sound_name]
	
	if target:
		player.global_position = target.global_position
	else:
		var camera: Camera = get_tree().get_first_node_in_group("camera")
		if camera:
			player.global_position = camera.global_position
	if is_random_pitch:
		player.pitch_scale = randf_range(0.8, 1)
	player.play()
