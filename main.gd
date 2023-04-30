extends Control

var my_curve     : Curve 


# Called when the node enters the scene tree for the first time.
func _ready():
	my_curve = Curve.new()
	switch_curve("x ^ 2")
	$VBoxContainer/ItemList.select(1)
	refresh()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func switch_curve(curve_name):
	my_curve.clear_points()
	match curve_name:
		"x ^ 2":
			my_curve.add_point(Vector2(0.0, 0.00), 0.0, 0.0, Curve.TANGENT_FREE,Curve.TANGENT_FREE)
			my_curve.add_point(Vector2(0.1, 0.01), 0.2, 0.2, Curve.TANGENT_FREE,Curve.TANGENT_FREE)
			my_curve.add_point(Vector2(0.2, 0.04), 0.4, 0.4, Curve.TANGENT_FREE,Curve.TANGENT_FREE)
			my_curve.add_point(Vector2(0.3, 0.09), 0.6, 0.6, Curve.TANGENT_FREE,Curve.TANGENT_FREE)
			my_curve.add_point(Vector2(0.4, 0.16), 0.8, 0.8, Curve.TANGENT_FREE,Curve.TANGENT_FREE)
			my_curve.add_point(Vector2(0.5, 0.25), 1.0, 1.0, Curve.TANGENT_FREE,Curve.TANGENT_FREE)
			my_curve.add_point(Vector2(0.6, 0.36), 1.2, 1.2, Curve.TANGENT_FREE,Curve.TANGENT_FREE)
			my_curve.add_point(Vector2(0.7, 0.49), 1.4, 1.4, Curve.TANGENT_FREE,Curve.TANGENT_FREE)
			my_curve.add_point(Vector2(0.8, 0.64), 1.6, 1.6, Curve.TANGENT_FREE,Curve.TANGENT_FREE)
			my_curve.add_point(Vector2(0.9, 0.81), 1.8, 1.8, Curve.TANGENT_FREE,Curve.TANGENT_FREE)
			my_curve.add_point(Vector2(1.0, 1.00), 2.0, 2.0, Curve.TANGENT_FREE,Curve.TANGENT_FREE)
		
		"sawtooth 1": # Taken from test_curve.h
			my_curve.add_point(Vector2(0.00, 0.0))
			my_curve.add_point(Vector2(0.25, 1.0))
			my_curve.add_point(Vector2(0.50, 0.0))
			my_curve.add_point(Vector2(0.75, 1.0))

		"sawtooth 2": # Taken from test_curve.h
			my_curve.add_point(Vector2(0.00, 0.0), 0.0, 0.0, Curve.TANGENT_LINEAR, Curve.TANGENT_LINEAR)
			my_curve.add_point(Vector2(0.25, 1.0), 0.0, 0.0, Curve.TANGENT_LINEAR, Curve.TANGENT_LINEAR)
			my_curve.add_point(Vector2(0.50, 0.0), 0.0, 0.0, Curve.TANGENT_LINEAR, Curve.TANGENT_LINEAR)
			my_curve.add_point(Vector2(0.75, 1.0), 0.0, 0.0, Curve.TANGENT_LINEAR, Curve.TANGENT_LINEAR)
		

func refresh():
	var bake_resolution  = $VBoxContainer/BakeResolution.value
	my_curve.bake_resolution = bake_resolution
	var sample_points = $VBoxContainer/SamplePoints.value
	var sample_interval = 1 / (sample_points -1)
	var distance_between_points = sample_interval * get_viewport().get_visible_rect().size.x
	var use_baked = $VBoxContainer/ItemList.is_selected(1)
	#var use_baked = $VBoxContainer/CheckBox.button_pressed
	var curve_line : Line2D = $CurveLine
	var curve_height = 150
	curve_line.clear_points()
	if use_baked:
		$VBoxContainer/CheckBox.text = "sample_baked"
		for i in sample_points:
			curve_line.add_point(Vector2(i * distance_between_points, 500 - (curve_height * my_curve.sample_baked(i * sample_interval))))
			
	else:
		$VBoxContainer/CheckBox.text = "sample"
		for i in sample_points:
			curve_line.add_point(Vector2(i * distance_between_points, 500 - (curve_height * my_curve.sample(i * sample_interval))))


func _on_check_box_toggled(button_pressed):
	refresh()


func _on_bake_resolution_value_changed(value):
	refresh()


func _on_sample_points_value_changed(value):
	refresh()


func _on_item_list_item_selected(index):
	refresh()


func _on_curve_list_item_selected(index):
	switch_curve($VBoxContainer/CurveList.get_item_text(index))
	refresh()
