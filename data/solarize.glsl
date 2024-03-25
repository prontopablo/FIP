#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

#define PROCESSING_TEXTURE_SHADER

/*
    Solarize shader effect.
*/

uniform sampler2D texture;
uniform float threshold = 0.5;

varying vec4 vertColor;
varying vec4 vertTexCoord;

void main() {
    vec2 uv = vertTexCoord.st;

    // Sample the pixel color
    vec4 color = texture2D(texture, uv);

    // Calculate the average intensity of the pixel color
    float intensity = (color.r + color.g + color.b) / 3.0;

    // Solarize effect: invert colors if intensity is above a threshold
    if (intensity > threshold) {
        color.rgb = 1.0 - color.rgb;
    }

    // Output the adjusted color
    gl_FragColor = color * vertColor;
}
