#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

#define PROCESSING_TEXTURE_SHADER

/*
    Adds a vignette to the texture
*/

uniform sampler2D texture;
uniform vec2 texOffset;

varying vec4 vertColor;
varying vec4 vertTexCoord;

uniform float vignetteStrength = 0.8; // 0.0 (none) to 1.0 (maximum)
uniform float vignetteFalloff = 1.0; // Rate at which the vignette diminishes
uniform float vignetteSign = 1.0;    // -1.0 (inward) or 1.0 (outward)
uniform float vignetteSize = 1.0;     // Overall size of the vignette

void main(void) {
  vec2 texSize = textureSize(texture, 0);

  // Calculate the center position of the image
  vec2 center = vec2(texSize.x * 0.5, texSize.y * 0.5);

  // Calculate the current pixel's position
  vec2 position = vertTexCoord.st * texSize;

  // Calculate the distance from the center
  float distance = distance(center, position) / length(center);

  // Apply the vignette effect based on the distance from the center
  float vignette = 1.0 - pow(distance * vignetteSign, vignetteFalloff) * vignetteStrength;

  // Clamp the vignette value to ensure it doesn't go below 0
  vignette = max(vignette, 0.0);

  // Apply size to the vignette
  vignette *= smoothstep(0.0, 1.0, 1.0 - distance / vignetteSize);

  vec4 color = texture2D(texture, vertTexCoord.st);
  gl_FragColor = vec4(color.rgb * vignette, color.a) * vertColor;
}
