#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

/*
   Simple box blur (https://en.wikipedia.org/wiki/Box_blur)
*/

#define PROCESSING_TEXTURE_SHADER

uniform sampler2D texture;
uniform vec2 texOffset;

const int blurRadius = 3;

varying vec4 vertColor;
varying vec4 vertTexCoord;

void main() {
    vec2 tc = vertTexCoord.st;
    
    // Initialize the accumulated color
    vec4 sumColor = vec4(0.0);
    
    // Iterate over the pixels in the blur radius
    for (int i = -blurRadius; i <= blurRadius; i++) {
        for (int j = -blurRadius; j <= blurRadius; j++) {
            // Sample the color of the current pixel
            vec4 currentColor = texture2D(texture, tc + vec2(float(i), float(j)) * texOffset);
            
            // Accumulate the color
            sumColor += currentColor;
        }
    }
    
    // Average the accumulated color
    vec4 blurredColor = sumColor / float((2 * blurRadius + 1) * (2 * blurRadius + 1));
    
    // Output the blurred color
    gl_FragColor = blurredColor * vertColor;
}
