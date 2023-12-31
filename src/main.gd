extends Node

@export var show_splash_screen := true ## Flag indicating if Splash Screen should be shown.


# Called when the node enters the scene tree for the first time.
func _ready():
	if not show_splash_screen:
		$SplashScreen.queue_free()


## Frees Splash Screen on animation end.
func _on_splash_screen_animation_ended():
	$SplashScreen.queue_free()
