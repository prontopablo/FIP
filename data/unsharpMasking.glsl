#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

#define PROCESSING_TEXTURE_SHADER

uniform sampler2D texture;
uniform vec2 texOffset;
uniform float strength = 2.0; // Adjust the strength of the sharpening effect

varying vec4 vertColor;
varying vec4 vertTexCoord;

void main(void) {
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

// Tutorial provided by: https://www.educative.io/answers/what-is-unsharp-masking