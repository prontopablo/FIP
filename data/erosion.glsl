#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

#define PROCESSING_TEXTURE_SHADER

/*
    Followed: https://github.com/Milchreis/processing-imageprocessing/blob/master/src/milchreis/imageprocessing/Erosion.java#L25
*/

uniform sampler2D texture;
uniform vec2 texOffset;

varying vec4 vertColor;
varying vec4 vertTexCoord;

uniform int radius = 3;

void main(void) {
    vec2 texSize = textureSize(texture, 0);
    vec2 pixelSize = 1.0 / texSize;

    vec4 centerColor = texture2D(texture, vertTexCoord.st);

    // Define the structuring element (3x3 kernel)
    int kernelSize = radius * 2 + 1;
    float minVal = 1.0; // Initialise minVal to maximum possible value

    float sampleValue;
    for (int i = -radius; i <= radius; i++) {
        for (int j = -radius; j <= radius; j++) {
            vec2 sampleTexCoord = vertTexCoord.st + vec2(float(i), float(j)) * texOffset;
            vec4 sampleColor = texture2D(texture, sampleTexCoord);

            // Convert to grayscale using luminance
            sampleValue = dot(sampleColor.rgb, vec3(0.299, 0.587, 0.114));

            // Apply erosion using structuring element
            minVal = min(minVal, sampleValue);
        }
    }

    gl_FragColor = vec4(minVal, minVal, minVal, centerColor.a) * vertColor;
}