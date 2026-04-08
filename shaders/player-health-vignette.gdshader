shader_type canvas_item;

uniform float normalized_health : hint_range(0, 1);
uniform vec3 low_health_color : source_color;
uniform vec3 high_health_color : source_color;

void fragment() {
	float vignette_alpha = (length(UV-vec2(.5))+1.-normalized_health)*(1.-normalized_health);
	vec3 vignette_color = mix(low_health_color, high_health_color, normalized_health);
	COLOR = vec4(vignette_color, vignette_alpha);
}

