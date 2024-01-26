#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

/*
   Basic sine wave deformation
*/

#define PROCESSING_TEXTURE_SHADER

uniform sampler2D texture;
uniform float deformationAmount = 0.1;

varying vec4 vertColor;
varying vec4 vertTexCoord;

void main() {
    vec2 tc = vertTexCoord.st;

    // Sample the pixel color
    vec4 color = texture2D(texture, tc);

    // Calculate deformation
    vec2 deform = vec2(sin(tc.y * 10.0) * deformationAmount, 0.0);

    // Apply deformation to texture coordinates
    tc += deform;

    // Sample the deformed pixel color
    vec4 deformedColor = texture2D(texture, tc);

    // Output the deformed color
    gl_FragColor = deformedColor * vertColor;
}
