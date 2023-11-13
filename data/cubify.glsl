#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

#define PROCESSING_TEXTURE_SHADER

uniform sampler2D texture;
uniform vec2 texOffset;

varying vec4 vertColor;
varying vec4 vertTexCoord;

uniform float dilationRadius = 0.01;

void main(void) {
    vec2 texSize = textureSize(texture, 0);
    vec2 texCoord = vertTexCoord.st;

    // Iterate over a neighborhood around the current pixel
    for (float i = -dilationRadius; i <= dilationRadius; i += texOffset.x) {
        for (float j = -dilationRadius; j <= dilationRadius; j += texOffset.y) {
            // Sample the neighboring pixel
            vec2 offset = vec2(i, j);
            vec4 neighborColor = texture2D(texture, texCoord + offset);

            // Update the current pixel with the maximum intensity value
            gl_FragColor = max(gl_FragColor, neighborColor);
        }
    }

    gl_FragColor *= vertColor;
}

// Accidentally created in attempting to create dilation shader