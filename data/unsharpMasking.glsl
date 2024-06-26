#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

#define PROCESSING_TEXTURE_SHADER

/*
    Followed: https://www.educative.io/answers/what-is-unsharp-masking
*/

uniform sampler2D texture;
uniform vec2 texOffset;
uniform float strength = 2.0; 

varying vec4 vertColor;
varying vec4 vertTexCoord;

void main() {
    // Sample the original image
    vec4 originalColor = texture2D(texture, vertTexCoord.st);
    
    // Sample a blurred version of the image
    vec4 blurredColor = texture2D(texture, vertTexCoord.st + vec2(-texOffset.s, -texOffset.t));
    
    // Calculate the difference between the original and blurred image
    vec4 difference = originalColor - blurredColor;
    
    // Enhance the difference to sharpen the image (unsharp masking)
    vec4 sharpenedColor = originalColor + difference * strength;
    
    gl_FragColor = sharpenedColor * vertColor;
}