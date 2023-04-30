extends Control

var my_curve     : Curve 


# Called when the node enters the scene tree for the first time.
func _ready():
	my_curve = Curve.new()
	my_curve.add_point(Vector2(0.0,  0), 000, 000, Curve.TANGENT_FREE,Curve.TANGENT_FREE)
	my_curve.add_point(Vector2(0.1,  1), 020, 020, Curve.TANGENT_FREE,Curve.TANGENT_FREE)
	my_curve.add_point(Vector2(0.2,  4), 040, 040, Curve.TANGENT_FREE,Curve.TANGENT_FREE)
	my_curve.add_point(Vector2(0.3,  9), 060, 060, Curve.TANGENT_FREE,Curve.TANGENT_FREE)
	my_curve.add_point(Vector2(0.4, 16), 080, 080, Curve.TANGENT_FREE,Curve.TANGENT_FREE)
	my_curve.add_point(Vector2(0.5, 25), 100, 100, Curve.TANGENT_FREE,Curve.TANGENT_FREE)
	my_curve.add_point(Vector2(0.6, 36), 120, 120, Curve.TANGENT_FREE,Curve.TANGENT_FREE)
	my_curve.add_point(Vector2(0.7, 49), 140, 140, Curve.TANGENT_FREE,Curve.TANGENT_FREE)
	my_curve.add_point(Vector2(0.8, 64), 160, 160, Curve.TANGENT_FREE,Curve.TANGENT_FREE)
	my_curve.add_point(Vector2(0.9, 81), 180, 180, Curve.TANGENT_FREE,Curve.TANGENT_FREE)
	my_curve.add_point(Vector2(1.0,100), 200, 200, Curve.TANGENT_FREE,Curve.TANGENT_FREE)
	$VBoxContainer/ItemList.select(1)
	refresh()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func refresh():
	var bake_resolution  = $VBoxContainer/BakeResolution.value
	my_curve.bake_resolution = bake_resolution
	var sample_points = $VBoxContainer/SamplePoints.value
	var sample_interval = 1 / (sample_points -1)
	var distance_between_points = sample_interval * get_viewport().get_visible_rect().size.x
	var use_baked = $VBoxContainer/ItemList.is_selected(1)
	#var use_baked = $VBoxContainer/CheckBox.button_pressed
	var curve_line : Line2D = $CurveLine
	curve_line.clear_points()
	if use_baked:
		$VBoxContainer/CheckBox.text = "sample_baked"
		for i in sample_points:
			curve_line.add_point(Vector2(i * distance_between_points, 500 - (2 * my_curve.sample_baked(i * sample_interval))))
			
	else:
		$VBoxContainer/CheckBox.text = "sample"
		for i in sample_points:
			curve_line.add_point(Vector2(i * distance_between_points, 500 - (2 * my_curve.sample(i * sample_interval))))


func _on_check_box_toggled(button_pressed):
	refresh()


func _on_bake_resolution_value_changed(value):
	refresh()


func _on_sample_points_value_changed(value):
	refresh()


func _on_item_list_item_selected(index):
	refresh()
