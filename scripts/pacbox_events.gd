class_name Events extends Node

func call_event(id: String) -> void:
	match id:
		"demo_event_go_room1":
			
			PACBox.switch_room("demo_room_1")
			
		"demo_event_go_room2":
			
			PACBox.switch_room("demo_room_2")
			
		"demo_event_dialog_1":
			
			print("This is a text box! You're in the starting room right now.")
			
		"demo_event_dialog_2":
			
			print("You've moved to a new room with different events! Isn't that nifty?")
			
		"DEFAULT":
			
			print("Default event invoked! Define a custom event ID!")
			
		_:
			
			print("ERROR! Invalid event ID called!")
			
