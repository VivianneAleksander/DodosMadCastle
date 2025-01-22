// NOTE: Shader automatically converted from Godot Engine 4.3.stable's CanvasItemMaterial.

shader_type canvas_item;
render_mode blend_mix;

uniform float radius = 1.0;
uniform float alpha = 1.0;

void fragment(){
	COLOR.w = (1.0 - smoothstep(0.0, length(vec2(0.5) - UV.xy), (1.0 / radius))) * alpha;
}