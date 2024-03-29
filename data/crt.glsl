#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

#define PROCESSING_TEXTURE_SHADER

/*
  Recreates the effects of an old CRT television with visible scanlines, spherical warping, and vignette
  Followed: https://www.youtube.com/watch?v=aWdySZ0BtJs
*/

uniform sampler2D texture;
uniform vec2 texOffset;
uniform float thresholdLow = 0.1;
uniform float thresholdHigh = 0.3;
uniform float scanlineWeight = 0.1;
uniform float brightness = 2.5;
uniform float distortion = 0.02;

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
    
    // Apply scanlines effect
    float offset = 0.002;
    
    // Calculate spherical warp
    float distanceToCenter = length(tc - vec2(0.5, 0.5));
    vec2 warpOffset = normalize(tc - vec2(0.5, 0.5)) * pow(distanceToCenter, 2.0) * distortion;
    vec2 distortedUV = tc + sin(tc.y * 20.0) * offset + warpOffset;
    
    vec4 crtColor = texture2D(texture, distortedUV);
    crtColor.rgb -= crtColor.rgb * smoothstep(0.5 - scanlineWeight, 0.5 + scanlineWeight, mod(gl_FragCoord.y, 2.0));

    // Adjust brightness
    crtColor *= brightness;

    // Add a slight vignette effect
    float vignetteFactor = 1.0 - 0.5 * pow(distanceToCenter, 2.0);
    crtColor *= vignetteFactor;

    // Output the CRT-processed color
    gl_FragColor = crtColor * vertColor;
}
