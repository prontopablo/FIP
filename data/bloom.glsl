#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

uniform sampler2D texture;
uniform float intensity = 0.5;
uniform float glow = 0.0;

varying vec4 vertColor;
varying vec4 vertTexCoord;

void main(void) {
  // Sample the original image
  vec4 originalColor = texture2D(texture, vertTexCoord.st);

  // Blur the image
  vec4 blurredColor = vec4(0.0);

  // Adjust glow value within a reasonable range
  float clampedGlow = clamp(glow, 0.0, 8.0);

  // Calculate the blur offset
  vec2 blurOffset = vec2(clampedGlow / textureSize(texture, 0).x, 0.0);

  // Accumulate blurred colors
  for (float i = -8.0; i <= 8.0; i += 1.0) {
    vec2 offset = i * blurOffset;
    blurredColor += texture2D(texture, vertTexCoord.st + offset);
  }

  blurredColor /= 17.0; // Adjust divisor as needed

  // Apply intensity to the blurred color
  blurredColor *= intensity;

  // Combine the original color and the blurred color using the Screen blending mode
  vec4 bloom = 1.0 - (1.0 - originalColor) * (1.0 - blurredColor);

  // Set the output color with the original vertex color
  gl_FragColor = bloom * vertColor;
}

// Adapted from: https://github.com/Milchreis/processing-imageprocessing/blob/master/src/milchreis/imageprocessing/Bloom.java