#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

#define PROCESSING_TEXTURE_SHADER

/*
    Anti-Aliasing Shader with Super-Sampling

    This shader performs basic anti-aliasing using a 2x2 super-sampling technique.
    It takes four samples per pixel and averages them to smooth out edges.

    https://en.wikipedia.org/wiki/Supersampling
*/

uniform sampler2D texture;
uniform vec2 texOffset;
uniform float strength = 1.0;

varying vec4 vertColor;
varying vec4 vertTexCoord;

void main(void) {
  vec2 texSize = textureSize(texture, 0);
  vec2 pixelSize = 1.0 / texSize;

  vec4 centerColor = texture2D(texture, vertTexCoord.st);

  // Define the offset for super-sampling
  vec2 offset = vec2(strength) * texOffset;

  // Accumulate color samples
  vec4 sum = vec4(0.0);

  // Sample 1
  sum += texture2D(texture, vertTexCoord.st + offset);

  // Sample 2
  sum += texture2D(texture, vertTexCoord.st + vec2(-offset.x, offset.y));

  // Sample 3
  sum += texture2D(texture, vertTexCoord.st + vec2(offset.x, -offset.y));

  // Sample 4
  sum += texture2D(texture, vertTexCoord.st - offset);

  // Average the samples
  vec4 averagedColor = sum / 4.0;

  gl_FragColor = averagedColor * vertColor;
}
