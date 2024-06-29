extends Node2D

# GDquest colors
var colors = {
	WHITE = Color(1.0, 1.0, 1.0),
	YELLOW = Color(1.0, .757, .027),
	GREEN = Color(.282, .757, .255),
	BLUE = Color(.098, .463, .824),
	PINK = Color(.914, .118, .388)
}

const WIDTH = 2

const MUL = 1

var parent = null

var is_active = true

func _ready():
	parent = get_parent()
	set_physics_process(true)
	queue_redraw()


func _draw():
	if !is_active:
		return
	draw_vector(parent.direction, Vector2(), colors.GREEN,10)



func draw_vector(vector, offset, _color,MUL = 1):
	if vector == Vector2():
		return
	draw_line(offset, vector * MUL + offset, _color, WIDTH)
	var dir = vector.normalized()
	draw_triangle_equilateral(offset +vector*MUL, dir, 5, _color)
	draw_circle(offset, 3, _color)


func draw_triangle_equilateral(center=Vector2(), direction=Vector2(), radius=5, _color="WHITE"):
	var point_1 = center + direction * radius
	var point_2 = center + direction.rotated(2*PI/3) * radius
	var point_3 = center + direction.rotated(4*PI/3) * radius

	var points = PackedVector2Array([point_1, point_2, point_3])
	draw_polygon(points, PackedColorArray([_color]))


func _physics_process(delta: float) -> void:
	queue_redraw()
