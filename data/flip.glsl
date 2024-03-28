#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

#define PROCESSING_TEXTURE_SHADER

/*
    Flips a texture depending on the flipHorizontal and flipVertical flags.
*/

uniform sampler2D texture;
uniform vec2 texOffset;
uniform bool flipHorizontal = false;
uniform bool flipVertical = true;

varying vec4 vertColor;
varying vec4 vertTexCoord;

void main(void) {
  // Calculate the flipped texture coordinates based on flip direction
  vec2 flippedTexCoord = vec2(
    flipHorizontal ? 1.0 - vertTexCoord.s : vertTexCoord.s,
    flipVertical ? 1.0 - vertTexCoord.t : vertTexCoord.t
  );

  // Sample the original texture with the flipped coordinates
  vec4 flippedColor = texture2D(texture, flippedTexCoord);

  // Set the output color with the original vertex color
  gl_FragColor = flippedColor * vertColor;
}
