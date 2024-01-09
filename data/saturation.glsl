#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

#define PROCESSING_TEXTURE_SHADER

/*
    
*/

uniform sampler2D texture;
uniform float saturation = 2.00;

varying vec4 vertColor;
varying vec4 vertTexCoord;

void main() {
    // Sample the original color
    vec4 originalColor = texture2D(texture, vertTexCoord.st);

    // Convert to grayscale (luminance)
    float luminance = dot(originalColor.rgb, vec3(0.2126, 0.7152, 0.0722));

    // Interpolate between the original color and grayscale based on saturation
    vec4 saturatedColor = mix(vec4(luminance), originalColor, saturation);

    // Output the final color
    gl_FragColor = saturatedColor * vertColor;
}
