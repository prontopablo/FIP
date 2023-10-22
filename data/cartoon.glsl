#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

#define PROCESSING_TEXTURE_SHADER

uniform sampler2D texture;
uniform vec2 texOffset;

varying vec4 vertColor;
varying vec4 vertTexCoord;

void main(void) {
  // Calculate the texture coordinates for sampling
  vec2 tc = vertTexCoord.st - texOffset;

  // Sample the center pixel color
  vec4 centerColor = texture2D(texture, vertTexCoord.st);

  // Define a threshold to determine if a pixel is part of an edge
  float edgeThreshold = 0.1;

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

// Followed: https://docs.gimp.org/en/gimp-filter-cartoon.html