#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

#define PROCESSING_TEXTURE_SHADER

uniform sampler2D texture;
uniform vec2 texOffset;
uniform float blurAmount = 10.0; // Default amount of motion blur

varying vec4 vertColor;
varying vec4 vertTexCoord;

void main(void) {
  // Calculate the texture coordinates for sampling
  vec2 tc = vertTexCoord.st - texOffset * blurAmount;

  // Initialize the color accumulator
  vec4 sum = texture2D(texture, tc);

  // Sample multiple times along the motion direction and accumulate colors
  for (float i = 1.0; i < blurAmount; i += 1.0) {
    tc -= texOffset;
    sum += texture2D(texture, tc);
  }

  // Calculate the final blurred color by averaging the samples
  vec4 blurredColor = sum / blurAmount;

  // Set the output color with the original vertex color
  gl_FragColor = blurredColor * vertColor;
}

// Followed: https://www.geeksforgeeks.org/opencv-motion-blur-in-python/