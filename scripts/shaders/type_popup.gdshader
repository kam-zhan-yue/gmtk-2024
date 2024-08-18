shader_type canvas_item;

uniform sampler2D screen_texture: hint_screen_texture, filter_nearest;

void fragment() {
	//vec4 original_colour = texture(TEXTURE, UV);
	//vec4 screen_colour = texture(screen_texture, SCREEN_UV);
	//float average = (screen_colour.r + screen_colour.g + screen_colour.g) / 3.0;
	//if(average > 0.1)
		//COLOR = screen_colour;
	//else
		//COLOR = original_colour;
}
