shader_type canvas_item;

uniform sampler2D screen_texture: hint_screen_texture, filter_nearest;

uniform float distortion_strength: hint_range(-1.0, 1.0) = 0.02;

uniform sampler2D noise_texture1: repeat_enable;
uniform sampler2D noise_texture2: repeat_enable;
uniform vec2 offset1 = vec2(0.1);
uniform vec2 offset2 = vec2(0.2);

void fragment() {
	vec4 noise_1 = texture(noise_texture1, UV + offset1 * TIME);
	vec4 noise_2 = texture(noise_texture2, UV + offset2 * TIME);

	float final_noise = noise_1.r * noise_2.r;
	float distortion = final_noise * distortion_strength;

	vec4 screen_colour = texture(screen_texture, SCREEN_UV + distortion);
	COLOR = screen_colour;
}