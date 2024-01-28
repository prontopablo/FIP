#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

/*
   Blends textures together based on a mix factor and blending type.
   https://en.wikipedia.org/wiki/Blend_modes
   https://processing.org/reference/blendMode_.html
   https://tinf2.vub.ac.be/~dvermeir/manual/gimp/Grokking-the-GIMP-v1.0/node55.html
*/

#define PROCESSING_TEXTURE_SHADER

uniform sampler2D texture1;
uniform sampler2D texture2;
uniform float mixFactor = 0.5;
uniform int blendingMode = 1;

varying vec4 vertColor;
varying vec4 vertTexCoord;

void main(void) {
    vec2 flippedTexCoord = vec2(vertTexCoord.s, 1.0 - vertTexCoord.t);
    vec4 color1 = texture2D(texture1, flippedTexCoord);
    vec4 color2 = texture2D(texture2, flippedTexCoord);
    vec4 blendedColor;

    switch (blendingMode) {
        case 1:
            blendedColor = color1 + color2 * mixFactor; // Additive Blending
            break;
        case 2:
            blendedColor = color1 - color2 * mixFactor; // Subtract Blending
            break;
        case 3:
            blendedColor = color1 * color2 * mixFactor; // Multiplicative Blending
            break;
        case 4:
            blendedColor = 1.0 - (1.0 - color1) * (1.0 - color2) * mixFactor; // Screen Blending
            break;
        case 5:
            blendedColor = mix(2.0 * color1 * color2, 1.0 - 2.0 * (1.0 - color1) * (1.0 - color2), step(0.5, color1)); // Overlay Blending
            break;
        case 6:
            blendedColor = min(color1, color2) * mixFactor; // Darken Blending
            break;
        case 7:
            blendedColor = max(color1, color2) * mixFactor; // Lighten Blending
            break;
        case 8:
            blendedColor = abs(color1 - color2) * mixFactor; // Difference Blending
            break;
        case 9:
            blendedColor = color1 + color2 - 2.0 * color1 * color2 * mixFactor; // Exclusion Blending
            break;
        case 10:
            blendedColor = color1 * (1.0 - color2) + color2 * (1.0 - color1) * mixFactor; // Behind Blending
            break;
        case 11:
            blendedColor = mix(color1, color2, mix(color1.a, 1.0 - color2.a, mixFactor)); // Dissolve Blending
            break;
        case 12:
            blendedColor = vec4(abs(color1.rgb - color2.rgb), max(color1.a, color2.a)); // Hue Blending
            break;
        case 13:
            blendedColor = color2; // Normal Blending
            break;
        default:
            blendedColor = mix(color1, color2, mixFactor); // Linear Interpolation
            break;
    }

    gl_FragColor = blendedColor;
}
