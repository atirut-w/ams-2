extends Node


func _ready() -> void:
	get_viewport().gui_embed_subwindows = false


func open_file(filters: Array[String]) -> FileAccess:
	var dialog := FileDialog.new()
	dialog.access = FileDialog.ACCESS_FILESYSTEM
	dialog.file_mode = FileDialog.FILE_MODE_OPEN_FILE
	dialog.filters = filters
	
	add_child(dialog)
	dialog.popup_centered(Vector2i(800, 600))
	var path := await dialog.file_selected as String
	
	return FileAccess.open(path, FileAccess.READ)
