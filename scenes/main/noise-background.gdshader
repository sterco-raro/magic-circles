shader_type canvas_item;

uniform sampler2D noise_tex: repeat_enable;
uniform sampler2D gradient_tex: repeat_enable;
uniform float speed = 0.1;
uniform vec4 smoke_color: source_color;

void fragment () {
	vec2 uv1 = vec2(UV.x + TIME * speed * 2.0, UV.y);
	vec2 uv2 = vec2(UV.x - TIME * speed * 2.0, UV.y);
	vec2 uv3 = vec2(UV.x, UV.y + TIME * speed * 4.0);

	float grad = texture(gradient_tex, vec2(UV.x, UV.y)).r;

	float r = texture(noise_tex, uv1).r;
	float g = texture(noise_tex, uv2).g;
	float b = texture(noise_tex, uv3).b;

	float alpha = r * g * b;

	COLOR.rgb = smoke_color.rgb;
	COLOR.a = clamp(alpha * 8.0 * grad, 0.0, 1.0);
}
