#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

#define PROCESSING_TEXTURE_SHADER

/*
    Based on https://codepen.io/Juxtopposed/pen/GRPRPyR
*/

uniform sampler2D texture;
uniform vec2 texOffset;
uniform vec2 resolution;
uniform vec2 mouse; 

varying vec4 vertColor;
varying vec4 vertTexCoord;

void main() {
    vec2 tc = vertTexCoord.st;

    // Sample the original pixel color
    vec4 originalColor = texture2D(texture, tc);

    // Calculate the distance from the mouse pointer
    float dist = length(tc - vec2(mouse.x / resolution.x, 1.0 - mouse.y / resolution.y)) / 3;

    // Adjust glitch intensity based on distance from the mouse
    float glitchIntensity = smoothstep(0.0, 0.1, dist);

    // Separate RGB channels with glitch displacement
    float redChannel = texture2D(texture, tc + vec2(glitchIntensity * 0.01, 0.0)).r;
    float greenChannel = texture2D(texture, tc - vec2(0.0, glitchIntensity * 0.01)).g;
    float blueChannel = texture2D(texture, tc + vec2(0.0, glitchIntensity * 0.01)).b;

    // Combine the glitched channels
    vec4 glitchedColor = vec4(redChannel, greenChannel, blueChannel, 1.0);

    // Mix the original and glitched colors
    vec4 finalColor = mix(originalColor, glitchedColor, glitchIntensity);

    // Output the final color with the vertex color
    gl_FragColor = finalColor * vertColor;
}
