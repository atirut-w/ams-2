extends VBoxContainer


var agl: AGLData
@onready var table := %table_view


func _load_agl_log() -> void:
	agl = AGLData.new()
	agl.load_log(await ProgramManager.pick_file(["*.txt"]))
	_draw_table()


func _draw_table() -> void:
	var text := "[table=4][cell]Employee ID[/cell][cell]Employee name[/cell][cell]Time[/cell][cell]Type[/cell]"
	
	for event in agl.events:
		for key in ["employee_id", "name", "time", "type"]:
			text += "[cell]%s[/cell]" % event[key]
	
	text += "[/table]"
	table.text = text
