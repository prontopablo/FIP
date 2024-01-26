#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

#define PROCESSING_TEXTURE_SHADER

/*
    Creates a ripple effect using sine.
*/

uniform sampler2D texture;
uniform vec2 resolution;

varying vec4 vertColor;
varying vec4 vertTexCoord;

uniform float rippleFrequency = 50.0;
uniform float rippleAmplitude = 0.01; // Amplitude or strength of the ripples
uniform vec2 rippleCenterOffset = vec2(0.0, 0.0); 

void main() {
    vec2 uv = vertTexCoord.st;
    
    // Center coordinates of the screen with offset
    vec2 center = resolution / 2.0 + rippleCenterOffset;
    
    // Calculate the distance from the current pixel to the center
    float distance = length(uv - center);
    
    // Calculate the ripple effect using sine function with parameters
    float ripple = sin(distance * rippleFrequency) * rippleAmplitude;
    
    // Offset the texture coordinate based on the ripple effect
    vec2 tc = uv + ripple;
    
    // Sample the pixel color
    vec4 color = texture2D(texture, tc);
    
    // Output the adjusted color
    gl_FragColor = color * vertColor;
}
