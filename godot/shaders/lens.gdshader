//gpt shaders
shader_type canvas_item;

// VR lens distortion coefficients
uniform float k1 = -0.22;
uniform float k2 = 0.24;

void fragment() {
    vec2 centered = UV * 2.0 - 1.0; // shift to -1..1
    float r = length(centered);     // radial distance

    // Barrel distortion
    float distortion = 1.0 + k1*r*r + k2*r*r*r*r;

    vec2 distorted_uv = centered * distortion;
    distorted_uv = (distorted_uv + 1.0) * 0.5; // back to 0..1

    if (distorted_uv.x < 0.0 || distorted_uv.x > 1.0 ||
        distorted_uv.y < 0.0 || distorted_uv.y > 1.0) {
        COLOR = vec4(0.0);
    } else {
        COLOR = texture(TEXTURE, distorted_uv);
    }
}
