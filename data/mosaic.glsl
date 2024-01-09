#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

#define PROCESSING_TEXTURE_SHADER

uniform sampler2D texture;
uniform vec2 texOffset;
uniform float mosaicSize = 40.00;

varying vec4 vertColor;
varying vec4 vertTexCoord;

void main() {
    vec2 tc = vertTexCoord.st;
    
    // Calculate the position of the mosaic cell
    vec2 mosaicCell = floor(tc * mosaicSize) / mosaicSize;
    
    // Sample the color from the mosaic cell
    vec4 mosaicColor = texture2D(texture, mosaicCell);
    
    // Output the color of the mosaic cell
    gl_FragColor = mosaicColor * vertColor;
}
