class_name AGLData
extends RefCounted


var events: Array


func load_log(file: FileAccess) -> void:
	var converted := _from_tis620(file.get_buffer(1024))
	
	breakpoint


func _from_tis620(bytes: PackedByteArray) -> String:
	var converted: PackedByteArray
	
	for byte in bytes:
		if byte >= 0xa0 && byte <= 0xff:
			converted.append(byte & 0xf)
			converted.append(0xe0)
		else:
			converted.append(byte)
			converted.append(0)
	
	return converted.get_string_from_utf16()


class Event:
	var name: String
