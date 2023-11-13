#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

#define PROCESSING_TEXTURE_SHADER

uniform sampler2D texture;
uniform vec2 texOffset;
uniform float thresholdLow = 0.1;
uniform float thresholdHigh = 0.3;

varying vec4 vertColor;
varying vec4 vertTexCoord;

void main() {
    vec2 tc = vertTexCoord.st;
    
    // Sample the surrounding pixels
    vec4 centerColor = texture2D(texture, tc);
    vec4 leftColor = texture2D(texture, tc - texOffset);
    vec4 rightColor = texture2D(texture, tc + texOffset);
    vec4 topColor = texture2D(texture, tc - vec2(0.0, texOffset.t));
    vec4 bottomColor = texture2D(texture, tc + vec2(0.0, texOffset.t));
    
    // Calculate the intensity gradients
    float horizontalGradient = length(leftColor - rightColor);
    float verticalGradient = length(topColor - bottomColor);
    
    // Combine gradients to detect edges
    float edgeIntensity = sqrt(horizontalGradient * horizontalGradient + verticalGradient * verticalGradient);
    
    // Apply the threshold to highlight edges
    vec4 edgeColor = edgeIntensity > thresholdLow ? vec4(1.0, 1.0, 1.0, 1.0) : vec4(0.0, 0.0, 0.0, 1.0);
    
    // Perform hysteresis to link edges
    edgeColor = edgeColor * (edgeIntensity > thresholdHigh ? 1.0 : 0.0);
    
    // Output the edge-detected color
    gl_FragColor = edgeColor * vertColor;
}

// Adapted from https://github.com/Milchreis/processing-imageprocessing/blob/master/src/milchreis/imageprocessing/CannyEdgeDetector.java