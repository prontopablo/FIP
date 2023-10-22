#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

#define PROCESSING_TEXTURE_SHADER

uniform sampler2D texture;
uniform vec2 texOffset;
uniform float rotationAngleDegrees = 45.0; // Rotation angle in degrees

varying vec4 vertColor;
varying vec4 vertTexCoord;

void main() {
    vec2 tc = vertTexCoord.st;
    float cosTheta = cos(radians(rotationAngleDegrees));
    float sinTheta = sin(radians(rotationAngleDegrees));

    // Calculate the coordinates of the rotated point
    float rotatedX = (tc.x - 0.5) * cosTheta - (tc.y - 0.5) * sinTheta + 0.5;
    float rotatedY = (tc.x - 0.5) * sinTheta + (tc.y - 0.5) * cosTheta + 0.5;

    // Check if the rotated coordinates are within the texture bounds
    if (rotatedX < 0.0 || rotatedX > 1.0 || rotatedY < 0.0 || rotatedY > 1.0) {
        // If outside the texture bounds, make the pixel transparent
        gl_FragColor = vec4(0.0, 0.0, 0.0, 0.0);
    } else {
        // Sample the color from the original texture at the rotated coordinates
        gl_FragColor = texture2D(texture, vec2(rotatedX, rotatedY)) * vertColor;
    }
}

// Followed: https://stackoverflow.com/questions/484573/image-rotation-algorithm