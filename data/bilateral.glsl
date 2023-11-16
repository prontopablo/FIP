#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

#define PROCESSING_TEXTURE_SHADER

/*
    Followed: https://github.com/diwi/PixelFlow/blob/master/src/com/thomasdiewald/pixelflow/glsl/Filter/bilateral.frag
*/

uniform sampler2D texture;
uniform vec2 texOffset;
uniform float sigmaSpace = 20.0;  // Spatial standard deviation
uniform float sigmaColor = 0.1;  // Intensity (color) standard deviation

varying vec4 vertColor;
varying vec4 vertTexCoord;

void main() {
    vec2 tc = vertTexCoord.st;

    // Initialize the weighted sum and normalization factor
    vec3 sum = vec3(0.0);
    float normalization = 0.0;

    // Iterate over a 5x5 kernel
    for (float i = -2.0; i <= 2.0; i++) {
        for (float j = -2.0; j <= 2.0; j++) {
            // Sample the current pixel
            vec4 currentColor = texture2D(texture, tc + vec2(i, j) * texOffset);

            // Calculate spatial and intensity differences
            float spatialDist = length(vec2(i, j));
            vec3 colorDist = currentColor.rgb - vertColor.rgb;

            // Calculate the bilateral filter weight
            float spatialWeight = exp(-0.5 * (spatialDist * spatialDist) / (sigmaSpace * sigmaSpace));
            float colorWeight = exp(-0.5 * dot(colorDist, colorDist) / (sigmaColor * sigmaColor));
            float weight = spatialWeight * colorWeight;

            // Accumulate the weighted color values
            sum += weight * currentColor.rgb;
            normalization += weight;
        }
    }

    // Normalize the sum and output the result
    vec3 resultColor = sum / normalization;
    gl_FragColor = vec4(resultColor, vertColor.a);
}
