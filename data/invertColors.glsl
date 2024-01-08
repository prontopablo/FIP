#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

#define PROCESSING_TEXTURE_SHADER

/*
    Followed: https://github.com/Milchreis/processing-imageprocessing/blob/master/src/milchreis/imageprocessing/InvertColors.java
*/

uniform sampler2D texture;

varying vec4 vertColor;
varying vec4 vertTexCoord;

void main(void) {
  // Sample the color from the texture
  vec4 color = texture2D(texture, vertTexCoord.st);

  // Invert the color by subtracting it from 1.0
  vec3 invertedColor = 1.0 - color.rgb;

  // Set the output color with the inverted color and the original vertex color
  gl_FragColor = vec4(invertedColor, color.a) * vertColor;
}
