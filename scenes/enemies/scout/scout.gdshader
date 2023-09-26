shader_type canvas_item;

uniform float brightnes;

void fragment() {
	COLOR += vec4(brightnes, brightnes, brightnes, 0);
}
