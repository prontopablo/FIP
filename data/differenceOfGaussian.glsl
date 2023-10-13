#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

#define PROCESSING_TEXTURE_SHADER

uniform sampler2D texture;
uniform vec2 texOffset;

varying vec4 vertColor;
varying vec4 vertTexCoord;

// Function to calculate Gaussian blur for a given texture coordinate
vec4 gaussianBlur(sampler2D tex, vec2 texCoords, vec2 direction, float radius) {
    vec4 sum = vec4(0.0);
    float totalWeight = 0.0;
    
    for (float i = -radius; i <= radius; i++) {
        for (float j = -radius; j <= radius; j++) {
            vec2 offset = vec2(i, j) * texOffset;
            vec4 sample = texture2D(tex, texCoords + offset);
            float weight = exp(-(i * i + j * j) / (2.0 * radius * radius));
            sum += sample * weight;
            totalWeight += weight;
        }
    }
    
    return sum / totalWeight;
}

void main(void) {
    vec2 texCoords = vertTexCoord.st;
    float radius1 = 4.0; // Adjust the first blur radius as needed
    float radius2 = 8.0; // Adjust the second blur radius as needed

    // Calculate two Gaussian-blurred versions of the input image
    vec4 blurred1 = gaussianBlur(texture, texCoords, vec2(1.0, 1.0), radius1);
    vec4 blurred2 = gaussianBlur(texture, texCoords, vec2(1.0, 1.0), radius2);

    // Calculate the Difference of Gaussians
    vec4 dog = blurred1 - blurred2;

    gl_FragColor = dog * vertColor;
}
