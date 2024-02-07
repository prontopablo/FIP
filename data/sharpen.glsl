#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

uniform sampler2D texture;
uniform vec2 resolution;

#define PROCESSING_TEXTURE_SHADER

/*
    
*/

// Sharpening intensity
uniform float sharpness = 1.5;

void main() {
    vec2 st = gl_FragCoord.xy / resolution;

    // Center pixel
    vec4 centerColor = texture2D(texture, st);

    // Neighboring pixels
    vec4 topColor = texture2D(texture, st + vec2(0.0, 1.0) / resolution);
    vec4 bottomColor = texture2D(texture, st + vec2(0.0, -1.0) / resolution);
    vec4 leftColor = texture2D(texture, st + vec2(-1.0, 0.0) / resolution);
    vec4 rightColor = texture2D(texture, st + vec2(1.0, 0.0) / resolution);

    // Calculate the sharpened color
    vec4 sharpenedColor = centerColor * (1.0 + 4.0 * sharpness) - sharpness * (topColor + bottomColor + leftColor + rightColor);

    gl_FragColor = sharpenedColor;
}
