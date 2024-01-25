#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

/*
   Blends textures together based on a mix factor and blending type.
   (https://en.wikipedia.org/wiki/Blend_modes)
*/

#define PROCESSING_TEXTURE_SHADER

uniform sampler2D texture1;
uniform sampler2D texture2;
uniform float mixFactor = 0.5;

// Specify the blending mode
uniform int blendingMode;

varying vec4 vertColor;
varying vec4 vertTexCoord;

void main(void) {
    vec2 flippedTexCoord = vec2(vertTexCoord.s, 1.0 - vertTexCoord.t);
    vec4 color1 = texture2D(texture1, flippedTexCoord);
    vec4 color2 = texture2D(texture2, flippedTexCoord);
    vec4 blendedColor;

    // Use a switch statement to select the blending mode
    switch (blendingMode) {
        case 1:
            blendedColor = color1 + color2 * mixFactor; // Additive Blending
            break;
        case 2:
            blendedColor = color1 - color2 * mixFactor; // Subtract Blending
            break;
        case 3:
            blendedColor = color1 * color2 * mixFactor; // Multiplication Blending
            break;
        case 4:
            blendedColor = (1 - (1 - color1) * (1 - color2)) * mixFactor;
            break;
        default:
            blendedColor = mix(color1, color2, mixFactor); // Linear Interpolation
            break;
    }

    gl_FragColor = blendedColor;
}
