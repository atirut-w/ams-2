class_name AGLData
extends RefCounted


var events: Array[Event]


func load_log(file: FileAccess) -> void:
	var converted := _from_tis620(file.get_buffer(file.get_length()))
	
	for line in converted.split("\r\n", false):
		if line.begins_with("#"):
			pass # TODO: Metadata
		elif !line.begins_with("No"):
			var tokens := line.split("\t", false)
			assert(tokens.size() == 11, "bad data: " + line)
			
			var event := Event.new()
			event.employee_id = int(tokens[3])
			event.name = tokens[3].rstrip(" ")
			event.time = Time.get_unix_time_from_datetime_string(tokens[9].replace("  ", "T"))
			event.type = (Event.EventType.TimeIn if tokens[10] == "Time In" else Event.EventType.TimeOut)
			
			events.append(event)
	
	print("Loaded %d entries" % events.size())


func _from_tis620(bytes: PackedByteArray) -> String:
	var converted: PackedByteArray
	
	for byte in bytes:
		if byte >= 0xa0 && byte <= 0xff:
			converted.append(byte - 0xa0)
			converted.append(0xe)
		else:
			converted.append(byte)
			converted.append(0)
	
	return converted.get_string_from_utf16()


class Event:
	var employee_id: int
	var name: String
	var time: int
	var type: EventType
	
	enum EventType {
		TimeIn,
		TimeOut,
	}
