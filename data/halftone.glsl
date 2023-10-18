#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

#define PROCESSING_TEXTURE_SHADER

uniform sampler2D texture;
uniform vec2 resolution;
uniform float cellSize = 10.0;
uniform float threshold = 0.5; // Threshold to determine if the pixel is inside the dot

varying vec4 vertColor;
varying vec4 vertTexCoord;

void main() {
    vec2 texCoord = vertTexCoord.st;
    
    // Convert the texture coordinates to screen space
    vec2 screenCoord = texCoord * resolution;

    // Calculate the position of the current cell
    vec2 cellPos = floor(screenCoord / cellSize) * cellSize;
    
    // Calculate the center of the cell
    vec2 cellCenter = cellPos + 0.5 * cellSize;
    
    // Calculate the vector from the current pixel to the center of the cell
    vec2 diff = screenCoord - cellCenter;
    
    // Calculate the distance from the current pixel to the center of the cell
    float distanceToCenter = length(diff);
    
    // Calculate the radius of the dot (based on intensity)
    float radius = 0.5 * cellSize * (1.0 - texture2D(texture, texCoord).r);
    
    if (distanceToCenter <= radius - threshold) {
        // Inside the dot, set the color to black
        gl_FragColor = vec4(0.0, 0.0, 0.0, 1.0);
    } else {
        // Outside the dot, set the color to white
        gl_FragColor = vec4(1.0, 1.0, 1.0, 1.0);
    }
}

// Followed: https://stackoverflow.com/questions/1258047/algorithm-to-make-halftone-images