extends Control


func _file_menu_id_pressed(id: int) -> void:
	match id:
		0:
			get_tree().quit()
		1:
			var agl := AGLData.new()
			agl.load_log(await ProgramManager.pick_file(["*.txt"]))
			ProgramManager.agl_data = agl


func _help_menu_id_pressed(id: int) -> void:
	match id:
		0:
			var dialog := AcceptDialog.new()
			dialog.title = "About"
			dialog.dialog_text = "AMS 2: Attendant Management System, rewritten.\rMade by Atirut Wattanamongkol"
			
			add_child(dialog)
			dialog.popup_centered()
			await dialog.confirmed
			remove_child(dialog)
