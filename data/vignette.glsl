#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

#define PROCESSING_TEXTURE_SHADER

uniform sampler2D texture;
uniform vec2 texOffset;

varying vec4 vertColor;
varying vec4 vertTexCoord;

uniform float vignetteStrength = 0.5; // Strength of the vignette effect, 0.0 (none) to 1.0 (maximum)

void main(void) {
  vec2 texSize = textureSize(texture, 0);

  // Calculate the center position of the image
  vec2 center = vec2(texSize.x * 0.5, texSize.y * 0.5);

  // Calculate the current pixel's position
  vec2 position = vertTexCoord.st * texSize;

  // Calculate the distance from the center
  float distance = distance(center, position) / length(center);

  // Apply the vignette effect based on the distance from the center
  float vignette = 1.0 - distance * vignetteStrength;

  // Clamp the vignette value to ensure it doesn't go below 0
  vignette = max(vignette, 0.0);

  vec4 color = texture2D(texture, vertTexCoord.st);
  gl_FragColor = vec4(color.rgb * vignette, color.a) * vertColor;
}
