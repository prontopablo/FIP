#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

#define PROCESSING_TEXTURE_SHADER

/*

*/

uniform sampler2D texture;
uniform vec2 texOffset;
uniform float gamma = 2.2;

varying vec4 vertColor;
varying vec4 vertTexCoord;

void main() {
    vec2 tc = vertTexCoord.st;

    // Sample the color from the texture
    vec4 color = texture2D(texture, tc);

    // Apply gamma correction
    vec3 gammaCorrected = pow(color.rgb, vec3(1.0 / gamma));

    // Output the corrected color
    gl_FragColor = vec4(gammaCorrected, color.a) * vertColor;
}
