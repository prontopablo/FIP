#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

#define PROCESSING_TEXTURE_SHADER

/*
    Followed: https://github.com/Milchreis/processing-imageprocessing/blob/master/src/milchreis/imageprocessing/Threshold.java
*/

uniform sampler2D texture;
uniform float threshold = 0.5;

varying vec4 vertColor;
varying vec4 vertTexCoord;

void main(void) {
    // Sample the texture color at the current fragment position
    vec4 color = texture2D(texture, vertTexCoord.st);

    // Calculate grayscale value by averaging color channels
    float grayscale = (color.r + color.g + color.b) / 3.0;

    // Apply threshold: If grayscale value is above the threshold, set to white; otherwise, set to black
    vec4 resultColor = vec4(vec3(step(threshold, grayscale)), 1.0);

    // Set the output color with the original vertex color
    gl_FragColor = resultColor * vertColor;
}