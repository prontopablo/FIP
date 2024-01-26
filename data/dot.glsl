#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

#define PROCESSING_TEXTURE_SHADER

/*
   Emulates a seven-segment display by grouping pixels into dots
*/

uniform sampler2D texture;
uniform float dotSize = 0.008;

varying vec4 vertColor;
varying vec4 vertTexCoord;

void main() {
    vec2 tc = vertTexCoord.st;

    // Sample the pixel color
    vec4 color = texture2D(texture, tc);

    // Calculate dot matrix coordinates
    vec2 dotCoord = floor(tc / dotSize) * dotSize;

    // Calculate the center of the dot
    vec2 dotCenter = dotCoord + dotSize * 0.5;

    // Calculate the distance from the current pixel to the dot center
    float distanceToCenter = distance(tc, dotCenter);

    // Use the distance to create a circular pattern
    float circularPattern = smoothstep(0.0, 0.5, 1.0 - distanceToCenter / (dotSize * 0.5));

    // Sample the color at dot matrix position with circular pattern
    vec4 dotColor = texture2D(texture, dotCoord) * circularPattern;

    // Output the dot matrix color
    gl_FragColor = dotColor * vertColor;
}
