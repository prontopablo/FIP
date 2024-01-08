#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

#define PROCESSING_TEXTURE_SHADER

/*
    
*/

uniform sampler2D texture;
uniform vec2 texOffset;

varying vec4 vertColor;
varying vec4 vertTexCoord;

void main() {
    vec2 tc = vertTexCoord.st;
    float amount = 1.5; // Adjust to control the strength of enhancement

    // Sample the center pixel
    vec4 centerColor = texture2D(texture, tc);
    
    // Sample the surrounding pixels
    vec4 leftColor = texture2D(texture, tc - texOffset);
    vec4 rightColor = texture2D(texture, tc + texOffset);
    vec4 topColor = texture2D(texture, tc - vec2(0.0, texOffset.t));
    vec4 bottomColor = texture2D(texture, tc + vec2(0.0, texOffset.t));
    
    // Calculate the enhanced color
    vec4 enhancedColor = centerColor + (centerColor - (leftColor + rightColor + topColor + bottomColor) / 4.0) * amount;
    
    // Output the enhanced color
    gl_FragColor = enhancedColor * vertColor;
}
