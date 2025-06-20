extends Node

var tea: Array[int] = Array([], TYPE_INT, "", null) # Flavor of boba (frame id)
var cup_size: Array[int] = Array([], TYPE_INT, "", null) # 0 - small; 1 - medium; 2 - large; 3 - infinicup
var boba_type: Array = Array([], TYPE_ARRAY, "", null) # Type of boba (0-6 being popping and 7-10 being jelly)
var boba_taste: Array = Array([], TYPE_ARRAY, "", null) # Taste of boba (frame id)
var cups_count: int = 0 # How many cups will there be
var cup_name: Array[String] = Array([], TYPE_STRING, "", null) # Names on labels of cups

func clear() -> void:
	tea = Array([], TYPE_INT, "", null)
	cup_size = Array([], TYPE_INT, "", null)
	boba_type = Array([], TYPE_ARRAY, "", null)
	boba_taste = Array([], TYPE_ARRAY, "", null)
	cups_count = 0
	cup_name = Array([], TYPE_STRING, "", null)
