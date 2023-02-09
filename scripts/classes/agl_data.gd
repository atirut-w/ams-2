class_name AGLData
extends RefCounted


var device_model: String
var device_uid: String
var data_type: DataType

enum DataType {
	AttendLog,
}


func load_log(file: FileAccess) -> void:
	pass
