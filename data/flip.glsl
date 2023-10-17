#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

#define PROCESSING_TEXTURE_SHADER

uniform sampler2D texture;
uniform vec2 texOffset; // Texture offset (used for flipping)

varying vec4 vertColor;
varying vec4 vertTexCoord;

void main(void) {
  // Calculate the flipped texture coordinates
  vec2 flippedTexCoord = vec2(1.0 - vertTexCoord.s, vertTexCoord.t);

  // Sample the original texture with the flipped coordinates
  vec4 flippedColor = texture2D(texture, flippedTexCoord);

  // Set the output color with the original vertex color
  gl_FragColor = flippedColor * vertColor;
}

// Followed: https://github.com/Milchreis/processing-imageprocessing/blob/master/src/milchreis/imageprocessing/Flip.java