#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

#define PROCESSING_TEXTURE_SHADER

/*
    Followed: https://www.eclipse.org/articles/Article-SimpleImageEffectsForSWT/index.html
*/

uniform sampler2D texture;
uniform vec2 texOffset;

varying vec4 vertColor;
varying vec4 vertTexCoord;

void main(void) {
    // Calculate the texture coordinates for sampling
    vec2 tc = vertTexCoord.st;

    // Sample the current pixel and the neighboring pixels
    vec4 currentColor = texture2D(texture, tc);
    vec4 leftColor = texture2D(texture, tc - texOffset);
    vec4 rightColor = texture2D(texture, tc + texOffset);

    // Calculate the gradient by subtracting leftColor from rightColor
    vec4 gradient = rightColor - leftColor;

    // Normalize the gradient to make it visible
    vec4 embossColor = gradient * 0.5 + 0.5;

    // Set the output color with the original vertex color
    gl_FragColor = embossColor * vertColor;
}