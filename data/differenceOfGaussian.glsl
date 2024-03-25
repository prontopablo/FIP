#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

/*
  Difference of Gaussian (https://en.wikipedia.org/wiki/Difference_of_Gaussians)
  Followed: https://www.youtube.com/watch?v=5EuYKEvugLU
  https://users.cs.northwestern.edu/~sco590/winnemoeller-cag2012.pdf
*/

uniform sampler2D texture;
uniform vec2 texOffset;
uniform float radius1 = 10.0;
uniform float radius2 = 1.0;
uniform float threshold = 0.01;

varying vec4 vertColor;
varying vec4 vertTexCoord;

void main() {
    vec2 st = vertTexCoord.st;

    // Accumulators for Gaussian blurs
    vec4 color1 = vec4(0.0);
    vec4 color2 = vec4(0.0);

    // Gaussian blur along the x-axis
    for (float x = -radius1; x <= radius1; x++) {
        vec2 offset = vec2(x, 0.0) * texOffset;
        color1 += texture2D(texture, st + offset);
    }
    color1 /= (2.0 * radius1 + 1.0);

    // Gaussian blur along the y-axis
    for (float y = -radius1; y <= radius1; y++) {
        vec2 offset = vec2(0.0, y) * texOffset;
        color1 += texture2D(texture, st + offset);
    }
    color1 /= (2.0 * radius1 + 1.0);

    // Gaussian blur for the second blur
    for (float x = -radius2; x <= radius2; x++) {
        vec2 offset = vec2(x, 0.0) * texOffset;
        color2 += texture2D(texture, st + offset);
    }
    color2 /= (2.0 * radius2 + 1.0);

    for (float y = -radius2; y <= radius2; y++) {
        vec2 offset = vec2(0.0, y) * texOffset;
        color2 += texture2D(texture, st + offset);
    }
    color2 /= (2.0 * radius2 + 1.0);

    // Difference of Gaussian with threshold
    vec4 dog = color1 - color2;
    dog *= step(threshold, length(dog.rgb));

    gl_FragColor = dog;
}

