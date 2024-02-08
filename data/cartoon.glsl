#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

#define PROCESSING_TEXTURE_SHADER

/*
  Adds a cartoon effect to the image
  Followed: https://docs.gimp.org/en/gimp-filter-cartoon.html
*/

uniform sampler2D texture;
uniform vec2 texOffset;
uniform float edgeThreshold = 0.1;

varying vec4 vertColor;
varying vec4 vertTexCoord;

void main(void) {
  // Calculate the texture coordinates for sampling
  vec2 tc = vertTexCoord.st - texOffset;

  // Sample the center pixel color
  vec4 centerColor = texture2D(texture, vertTexCoord.st);

  // Calculate the difference between the center pixel and its neighbors
  float delta = length(centerColor.rgb - texture2D(texture, tc).rgb);

  // If the difference is above the threshold, it's an edge pixel
  if (delta > edgeThreshold) {
    // Darken the edge pixels
    gl_FragColor = vec4(0.0, 0.0, 0.0, 1.0);
  } else {
    // Keep non-edge pixels the same
    gl_FragColor = centerColor;
  }
}