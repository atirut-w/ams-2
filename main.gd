extends Control


func _load_agl() -> void:
	var file := await ProgramManager.open_file(["*.txt"])
