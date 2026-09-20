shader_type canvas_item;

uniform bool flash = false;

void fragment() {
	COLOR = texture(TEXTURE, UV) * COLOR;

	if (flash) {
		COLOR.rgb = vec3(0.5);
	}
}
