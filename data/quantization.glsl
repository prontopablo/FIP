#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

uniform sampler2D texture;

varying vec4 vertColor;
varying vec4 vertTexCoord;

uniform float shades = 8.0; // Shades per color channel

void main() {
    // Sample the original texture color
    vec4 originalColor = texture2D(texture, vertTexCoord.st);

    // Quantize each color channel
    float r = floor(originalColor.r * shades) / shades;
    float g = floor(originalColor.g * shades) / shades;
    float b = floor(originalColor.b * shades) / shades;

    // Set the output color with the quantized color and the original alpha value
    gl_FragColor = vec4(r, g, b, originalColor.a) * vertColor;
}


// Adapted from: https://github.com/Milchreis/processing-imageprocessing/blob/master/src/milchreis/imageprocessing/Quantization.java