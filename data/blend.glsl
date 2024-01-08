#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

#define PROCESSING_TEXTURE_SHADER

/*
    Blends two textures together based on a mix factor
*/

uniform sampler2D texture1;
uniform sampler2D texture2;
uniform float mixFactor = 0.5;

varying vec4 vertColor;
varying vec4 vertTexCoord;

void main(void) {
  // Sample the colors from both textures
  vec2 flippedTexCoord = vec2(vertTexCoord.s, 1.0 - vertTexCoord.t); // Flip along the y-axis - Processing and OpenGL have different coordinate systems
  vec4 color1 = texture2D(texture1, flippedTexCoord);
  vec4 color2 = texture2D(texture2, flippedTexCoord);

  // Blend the colors based on the mix factor
  vec4 blendedColor = mix(color1, color2, mixFactor);

  // Output the final color
  gl_FragColor = blendedColor;
}