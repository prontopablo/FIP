#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

#define PROCESSING_TEXTURE_SHADER

/*
   
*/

uniform sampler2D texture;
uniform vec2 texOffset;
uniform float pixelSize = 0.01;

varying vec4 vertColor;
varying vec4 vertTexCoord;

void main() {
    vec2 tc = vertTexCoord.st;
    
    // Calculate the position in the pixel grid
    vec2 pixelPos = vec2(floor(tc.x / pixelSize) * pixelSize, floor(tc.y / pixelSize) * pixelSize);
    
    // Sample the color at the pixel position
    vec4 pixelColor = texture2D(texture, pixelPos);
    
    // Output the pixelated color
    gl_FragColor = pixelColor * vertColor;
}
