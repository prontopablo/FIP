#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

#define PROCESSING_TEXTURE_SHADER

/*
    Quantization shader to reduce the number of colors in an image.
*/

uniform sampler2D texture;

varying vec4 vertColor;
varying vec4 vertTexCoord;

uniform int shades = 4;

void main() {
    vec2 uv = vertTexCoord.st;
    
    // Sample the pixel color
    vec4 color = texture2D(texture, uv);
    
    // Quantize the color values
    color.rgb = floor(color.rgb * float(shades)) / float(shades - 1.0);
    
    // Output the adjusted color
    gl_FragColor = color * vertColor;
}
