#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

/*
   Brightness
*/

#define PROCESSING_TEXTURE_SHADER

uniform sampler2D texture;
uniform float brightness = 0.1;

varying vec4 vertColor;
varying vec4 vertTexCoord;

void main() {
    vec2 tc = vertTexCoord.st;

    // Sample the pixel color
    vec4 color = texture2D(texture, tc);

    // Adjust brightness
    color.rgb = color.rgb * brightness;

    color.rgb = clamp(color.rgb, 0.0, 1.0);

    // Output the adjusted color
    gl_FragColor = color * vertColor;
}
