shader_type spatial;

render_mode unshaded, cull_disabled, depth_prepass_alpha;

uniform sampler2D screen_texture : hint_screen_texture;

uniform sampler2D albedo_texture : source_color;

void fragment() {

	vec4 tex = texture(albedo_texture, UV);

	vec3 bg = texture(screen_texture, SCREEN_UV).rgb;

	float brightness = dot(bg, vec3(0.299, 0.587, 0.114));

	vec3 bright = vec3(1.0);
	vec3 dark   = vec3(0.0);

	vec3 color = mix(bright, dark, step(0.5, brightness));

	ALBEDO = tex.rgb * color;
	ALPHA = tex.a;
}