extends Control


func _load_agl() -> void:
	var file := await ProgramManager.open_file(["*.txt"])
	var data := AGLData.new()
	data.load_log(file)
