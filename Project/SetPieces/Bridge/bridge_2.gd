extends Node2D

# --- Day toggles ---
@export var sunday_enabled := false
@export var monday_enabled := true
@export var tuesday_enabled := true
@export var wednesday_enabled := true
@export var thursday_enabled := true
@export var friday_enabled := true
@export var saturday_enabled := false

# --- Time windows where the bridge should remain open ---
@export var schedule_windows: Array[Dictionary] = [
	{
		"open": {"hour": 4, "minute": 20, "second": 0},
		"close": {"hour": 4, "minute": 30, "second": 0}
	}
]

@export var use_12_hour_cycle := false

# --- Manual override ---
@export var override_enabled := false
@export var override_open := false

# --- Internal ---
var bridge_angle := 1
var is_open := false

func _process(_delta):
	var now = Time.get_time_dict_from_system()
	var weekday = Time.get_date_dict_from_system().weekday

	if override_enabled:
		is_open = override_open
	else:
		if is_day_enabled(weekday):
			is_open = is_within_any_window(now)
		else:
			is_open = false

	update_bridge()


func is_day_enabled(day: int) -> bool:
	match day:
		0: return sunday_enabled
		1: return monday_enabled
		2: return tuesday_enabled
		3: return wednesday_enabled
		4: return thursday_enabled
		5: return friday_enabled
		6: return saturday_enabled
	return false


func is_within_any_window(current_time: Dictionary) -> bool:
	var now_seconds = time_to_seconds(current_time)

	for window in schedule_windows:
		var open_time = time_to_seconds(window["open"])
		var close_time = time_to_seconds(window["close"])

		if open_time <= now_seconds and now_seconds <= close_time:
			return true

	return false


func time_to_seconds(t: Dictionary) -> int:
	var hour = t.hour
	if use_12_hour_cycle:
		hour = hour % 12  # strip AM/PM
	return hour * 3600 + t.minute * 60 + t.second


func update_bridge():
	if is_open:
		open_bridge()
	else:
		close_bridge()


func open_bridge():
	if bridge_angle <= 90:
		bridge_angle += 1
		$LeftBridge.rotation_degrees -= 1
		$RightBridge.rotation_degrees += 1


func close_bridge():
	if bridge_angle >= 2:
		bridge_angle -= 1
		$LeftBridge.rotation_degrees += 1
		$RightBridge.rotation_degrees -= 1
