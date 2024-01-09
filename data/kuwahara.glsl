#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

#define PROCESSING_TEXTURE_SHADER

/*
    Kuwahara Filter: https://en.wikipedia.org/wiki/Kuwahara_filter
    Followed: https://www.youtube.com/watch?v=LDhN-JK3U9g
*/

uniform sampler2D texture;
uniform vec2 texOffset;

varying vec4 vertColor;
varying vec4 vertTexCoord;

const int kernelSize = 7;

void main() {
    vec2 tc = vertTexCoord.st;
    
    // Initialize variables for the four quadrants
    vec4 q1 = vec4(0.0);
    vec4 q2 = vec4(0.0);
    vec4 q3 = vec4(0.0);
    vec4 q4 = vec4(0.0);
    
    // Sample pixels for each quadrant
    for (int i = 0; i < kernelSize; i++) {
        for (int j = 0; j < kernelSize; j++) {
            vec4 color = texture2D(texture, tc + vec2(i, j) * texOffset);
            
            if (i < kernelSize / 2) {
                if (j < kernelSize / 2) {
                    q1 += color;
                } else {
                    q2 += color;
                }
            } else {
                if (j < kernelSize / 2) {
                    q3 += color;
                } else {
                    q4 += color;
                }
            }
        }
    }
    
    // Average colors in each quadrant
    q1 /= float(kernelSize * kernelSize / 4);
    q2 /= float(kernelSize * kernelSize / 4);
    q3 /= float(kernelSize * kernelSize / 4);
    q4 /= float(kernelSize * kernelSize / 4);
    
    // Find the standard deviation of colors in each quadrant
    vec4 meanColor = (q1 + q2 + q3 + q4) / 4.0;
    float varianceQ1 = dot(q1 - meanColor, q1 - meanColor);
    float varianceQ2 = dot(q2 - meanColor, q2 - meanColor);
    float varianceQ3 = dot(q3 - meanColor, q3 - meanColor);
    float varianceQ4 = dot(q4 - meanColor, q4 - meanColor);
    
    float minVariance = min(min(varianceQ1, varianceQ2), min(varianceQ3, varianceQ4));
    
    // Output the color with minimum variance
    vec4 resultColor;
    if (minVariance == varianceQ1) {
        resultColor = q1;
    } else if (minVariance == varianceQ2) {
        resultColor = q2;
    } else if (minVariance == varianceQ3) {
        resultColor = q3;
    } else {
        resultColor = q4;
    }
    
    // Output the smoothed color
    gl_FragColor = resultColor * vertColor;
}
