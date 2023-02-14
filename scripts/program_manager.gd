extends Node


const late_limit := {
	"hour": 7,
	"minute": 30,
	"second": 0,
}


func _ready() -> void:
	get_viewport().gui_embed_subwindows = false


func pick_file(filters: Array[String]) -> FileAccess:
	var dialog := FileDialog.new()
	dialog.access = FileDialog.ACCESS_FILESYSTEM
	dialog.file_mode = FileDialog.FILE_MODE_OPEN_FILE
	dialog.filters = filters
	
	add_child(dialog)
	dialog.popup_centered(Vector2i(800, 600))
	var path := await dialog.file_selected as String
	
	return FileAccess.open(path, FileAccess.READ)


func is_late(time: int) -> bool:
	var t_dict := Time.get_time_dict_from_unix_time(time)
	
	if t_dict.hour > late_limit.hour:
		return true
	elif t_dict.minute > late_limit.minute:
		return true
	elif t_dict.second > late_limit.second:
		return true
	
	return false
