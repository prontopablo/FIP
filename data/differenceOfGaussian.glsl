#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

uniform sampler2D texture;
uniform vec2 resolution;
uniform float radius1;
uniform float radius2;

void main() {
    vec2 st = gl_FragCoord.xy / resolution;

    vec4 color1 = texture2D(texture, st);
    vec4 color2 = texture2D(texture, st);

    // Apply the first Gaussian blur
    for (float x = -radius1; x <= radius1; x++) {
        for (float y = -radius1; y <= radius1; y++) {
            color1 += texture2D(texture, st + vec2(x, y) / resolution);
        }
    }
    color1 /= (2.0 * radius1 + 1.0) * (2.0 * radius1 + 1.0);

    // Apply the second Gaussian blur
    for (float x = -radius2; x <= radius2; x++) {
        for (float y = -radius2; y <= radius2; y++) {
            color2 += texture2D(texture, st + vec2(x, y) / resolution);
        }
    }
    color2 /= (2.0 * radius2 + 1.0) * (2.0 * radius2 + 1.0);

    // Calculate the Difference of Gaussian
    vec4 dog = color1 - color2;

    gl_FragColor = dog;
}

// Algorithm followed: https://theailearner.com/2019/05/13/difference-of-gaussians-dog/