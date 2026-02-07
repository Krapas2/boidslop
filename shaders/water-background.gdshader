shader_type canvas_item;

uniform sampler3D noise_texture;
uniform float noise_zoom;
uniform float time_scale;
uniform float color_threshold;
uniform vec4 base_color : source_color;
uniform vec4 highlight_color : source_color;

varying vec2 world_position;

void vertex() {
    world_position = (MODEL_MATRIX * vec4(VERTEX, 0.0, 1.0)).xy;
}

void fragment() {
	vec3 sample_position = vec3(fract(world_position/noise_zoom), fract(TIME*time_scale));
	float v = texture(noise_texture, sample_position).x;
	v = step(v,-color_threshold/2.)+step(color_threshold/2.,v);

	vec4 col = v*highlight_color+(1.-v)*base_color;

	COLOR = col;
}
