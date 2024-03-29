#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

#define PROCESSING_TEXTURE_SHADER

/*
    Contrast
*/

uniform sampler2D texture;
uniform float contrast = 2.0;

varying vec4 vertColor;
varying vec4 vertTexCoord;

void main() {
    vec2 tc = vertTexCoord.st;

    // Sample the pixel color
    vec4 color = texture2D(texture, tc);

    // Adjust contrast
    color.rgb = (color.rgb - 0.5) * contrast + 0.5;

    color.rgb = clamp(color.rgb, 0.0, 1.0);

    // Output the adjusted color
    gl_FragColor = color * vertColor;
}
