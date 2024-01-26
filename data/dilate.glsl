#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

/*
   Dilates to increase light areas
*/

#define PROCESSING_TEXTURE_SHADER

uniform sampler2D texture;
uniform vec2 texOffset;

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
    
    // Combine the neighboring pixels to dilate the image
    vec4 dilatedColor = max(centerColor, max(leftColor, max(rightColor, max(topColor, bottomColor))));
    
    // Output the dilated color
    gl_FragColor = dilatedColor * vertColor;
}
