#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

#define PROCESSING_TEXTURE_SHADER

/*
    Static shader using sobel operator for edge detection and stippling    
*/

uniform sampler2D texture;
uniform vec2 texOffset;
uniform float threshold = 0.08;
uniform float stippleDensity = 0.99;

varying vec4 vertColor;
varying vec4 vertTexCoord;

// Function to generate a random number between 0 and 1
float rand(vec2 co) {
    return fract(sin(dot(co.xy, vec2(12.9898, 78.233))) * 43758.5453);
}

void main() {
    vec2 tc = vertTexCoord.st;

    // Sample the surrounding pixels
    vec4 centerColor = texture2D(texture, tc);
    vec4 leftColor = texture2D(texture, tc - texOffset);
    vec4 rightColor = texture2D(texture, tc + texOffset);
    vec4 topColor = texture2D(texture, tc - vec2(0.0, texOffset.t));
    vec4 bottomColor = texture2D(texture, tc + vec2(0.0, texOffset.t));

    // Apply the Sobel operator for edge detection
    float horizontalGradient = -leftColor.r + rightColor.r - topColor.r + bottomColor.r;
    float verticalGradient = -leftColor.r - rightColor.r + topColor.r + bottomColor.r;

    // Combine gradients to detect edges
    float edgeIntensity = sqrt(horizontalGradient * horizontalGradient + verticalGradient * verticalGradient);

    // Apply the threshold to create ink-like effect
    vec4 inkColor = edgeIntensity > threshold ? vec4(0.0, 0.0, 0.0, 1.0) : vec4(1.0, 1.0, 1.0, 1.0);

    // Stippling: Add random dots to the ink color
    float stipple = rand(tc);
    inkColor.rgb *= smoothstep(1.0 - stippleDensity, 1.0, stipple);

    // Output the stippled ink drawing color
    gl_FragColor = inkColor * vertColor;
}
