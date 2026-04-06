extends Node

func call_event(id: String) -> void:
	match id:
		"test1":
			
			print("Test #1!")
			
		"test2":
			
			print("Test #2!")
			
		"DEFAULT":
			
			print("Default event invoked! Define a custom event ID!")
			
		_:
			
			print("ERROR! Invalid event ID called!")
			
