extends Resource
class_name PlayerVitals

@export var health: float = 100
@export var hunger: float = 100
@export var stamina: float = 100

# Increase or decrease the value of one of the player's vitals. 
func modify_vital(vital_name: StringName, amount: float):
	match vital_name.to_lower():
		"health":
			health += amount
		"hunger":
			hunger += amount
		"stamina":
			stamina += amount
		_:
			print("Vital not found. Vital name given: " + vital_name)
