#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

#define PROCESSING_TEXTURE_SHADER

/*
    Simulates a linocut effect with changable ink/paper colors.
*/

uniform sampler2D texture;
uniform vec2 resolution;
uniform float threshold = 0.4;
uniform vec3 inkColor = vec3(0.4, 0.4, 1.0);
uniform vec3 paperColor = vec3(1.0, 1.0, 1.0);

varying vec4 vertColor;
varying vec4 vertTexCoord;

void main() {
    vec2 uv = vertTexCoord.st;

    // Sample the pixel color
    vec4 color = texture2D(texture, uv);

    // Convert to grayscale
    float grayscale = dot(color.rgb, vec3(0.299, 0.587, 0.114));

    // Apply a simple threshold
    float linocut = step(threshold, grayscale);

    // Mix ink color and paper color based on the linocut effect
    color.rgb = mix(paperColor, inkColor, linocut);

    // Output the adjusted color
    gl_FragColor = color * vertColor;
}
