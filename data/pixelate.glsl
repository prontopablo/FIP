#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

uniform sampler2D texture;
uniform vec2 resolution;
uniform float pixelSize = 200.0; // Adjust the pixel size

void main() {
    vec2 st = gl_FragCoord.xy / resolution;
    
    // Calculate the position within the pixel block
    vec2 pixelPos = floor(st * pixelSize) / pixelSize;
    
    // Sample the color within the pixel block
    vec4 color = texture2D(texture, pixelPos);
    
    gl_FragColor = color;
}

