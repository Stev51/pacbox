class_name Events extends Node

func call_event(id: String) -> void:
	match id:
		"demo_event_go_room1":
			
			PACBox.fade_to_room("demo_room_1")
			
		"demo_event_go_room2":
			
			PACBox.fade_to_room("demo_room_2")
			
		"demo_event_dialog_1":
			
			print("This is a text box! You're in the starting room right now.")
			
		"demo_event_dialog_2":
			
			print("You've moved to a new room with different events! Isn't that nifty?")
			PACBox.set_flag("demo_flag")
			
		"demo_event_dialog_3":
			
			print("You've unlocked a new event by exploring! Pretty cool!")
			
		"DEFAULT":
			
			print("Default event invoked! Define a custom event ID!")
			
		_:
			
			print("ERROR! Invalid event ID called!")
			
