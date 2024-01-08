#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

#define PROCESSING_TEXTURE_SHADER

/*
    Dithering: https://en.wikipedia.org/wiki/Dither
*/

uniform sampler2D texture;
uniform vec2 texOffset;

varying vec4 vertColor;
varying vec4 vertTexCoord;

void main() {
    vec2 tc = vertTexCoord.st;

    // Sample the original pixel color
    vec4 originalColor = texture2D(texture, tc);

    // Convert the color to grayscale
    float gray = dot(originalColor.rgb, vec3(0.299, 0.587, 0.114));

    // Use a simple 2x2 Bayer matrix for dithering
    int row = int(mod(gl_FragCoord.y, 2.0));
    int col = int(mod(gl_FragCoord.x, 2.0));
    float ditherValue = 0.25 * float(row * 2 + col);

    // Add the dithering error
    gray += ditherValue;

    // Threshold the grayscale value
    vec4 ditheredColor = step(0.5, gray) * vec4(1.0, 1.0, 1.0, 1.0);

    // Output the dithered color
    gl_FragColor = ditheredColor * vertColor;
}
