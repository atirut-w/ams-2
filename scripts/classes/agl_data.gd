class_name AGLData
extends RefCounted


var device_model: String
var device_uid: String
var data_type: DataType

enum DataType {
	AttendLog,
}


func load_log(file: FileAccess) -> void:
	while file.get_position() < file.get_length():
		var line := file.get_csv_line(PackedByteArray([0x09]).get_string_from_ascii())
		if not (line[0].begins_with("#") || line[0].begins_with("No")):
			breakpoint
