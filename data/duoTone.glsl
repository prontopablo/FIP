#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

#define PROCESSING_TEXTURE_SHADER

/*
    Duo-tone shader with user-defined colors.
*/

uniform sampler2D texture;
uniform vec2 resolution;

varying vec4 vertColor;
varying vec4 vertTexCoord;

uniform vec3 tone1 = vec3(0.1, 0.5, 0.8);
uniform vec3 tone2 = vec3(0.8, 0.2, 0.1);

void main() {
    vec2 uv = vertTexCoord.st;

    // Sample the pixel color
    vec4 color = texture2D(texture, uv);

    // Calculate the luminance of the current pixel color
    float luminance = dot(color.rgb, vec3(0.299, 0.587, 0.114));

    // Choose the tone based on luminance
    vec3 duotoneColor = mix(tone1, tone2, luminance);

    // Output the adjusted color
    gl_FragColor = vec4(duotoneColor, color.a) * vertColor;
}
