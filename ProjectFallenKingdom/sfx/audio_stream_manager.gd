extends Node

var num_players : int = 32
var bus : String = "master"

var available : Array[AudioStreamPlayer]= []  # The available players.
var queue : Array[String] = []  # The queue of sounds to play.


func _ready():
	# Create the pool of AudioStreamPlayer nodes.
	for i in num_players:
		var player : AudioStreamPlayer = AudioStreamPlayer.new()
		add_child(player)
		available.append(player)
		player.finished.connect(_on_stream_finished.bind(player))
		player.bus = bus

func _on_stream_finished(stream: AudioStreamPlayer ) -> void:
	# When finished playing a stream, make the player available again.
	available.append(stream)

func play(sound_path : String)-> void :
	queue.append(sound_path)

func _process(delta) -> void:
	# Play a queued sound if any players are available.
	if not queue.is_empty() and not available.is_empty():
		available[0].stream = load(queue.pop_front())
		available[0].play()
		available.pop_front()
