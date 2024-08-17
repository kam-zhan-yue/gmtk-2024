class_name TypeEntity
extends Node2D

@export var target: String
@onready var target_display := $Target as RichTextLabel
@onready var display := $Display as RichTextLabel
@onready var state_display := $State as RichTextLabel
@onready var index_display := $Index as RichTextLabel

var input: String = ""

enum TypeState {INACTIVE, ACTIVE, WRONG, COMPLETED}
var state := TypeState.INACTIVE
var index := 0
var incorrect := 0

func _ready() -> void:
	InputManager.on_key_pressed.connect(_on_key_pressed)
	InputManager.on_backspace.connect(_on_backspace);

func init(word: String) -> void:
	target = word
	input = ""
	update_state()

func _on_key_pressed(key: String) -> void:
	if index >= target.length() || state == TypeState.COMPLETED:
		return
	if state == TypeState.INACTIVE and key == target[0]:
		# If inactive and first key is correct, set active
		input = key
		index = 1
		incorrect = 0
		state = TypeState.ACTIVE
		check_complete()
	elif state == TypeState.ACTIVE:
		# If correct, then increase the index
		if target[index] == key:
			input += key
			index += 1
			check_complete()
		# If incorrect, then set to wrong
		else:
			input += key
			incorrect += 1
			state = TypeState.WRONG
	elif state == TypeState.WRONG:
		# If wrong and first key is correct, then set back to active
		if key == target[0]:
			input = key
			index = 1
			incorrect = 0
			state = TypeState.ACTIVE
		# If wrong and still wrong, then keep incrementing wrong
		else:
			input += key
			incorrect += 1
	update_state()

func _on_backspace() -> void:
	if state == TypeState.ACTIVE and index > 0:
		input = input.left(input.length() - 1)
		index -= 1
		if index == 0:
			state = TypeState.INACTIVE
	elif state == TypeState.WRONG:
		input = input.left(input.length() - 1)
		incorrect -= 1
		if incorrect == 0:
			state = TypeState.ACTIVE
			check_complete()
	update_state()


func update_state() -> void:
	display.text = input
	state_display.text = TypeState.keys()[state]
	target_display.text = target
	index_display.text = str(index)

func check_complete() -> void:
	if index == target.length():
		state = TypeState.COMPLETED
		queue_free()
