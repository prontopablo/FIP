#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

#define PROCESSING_TEXTURE_SHADER

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

varying vec4 vertColor;
varying vec4 vertTexCoord;

void main(void) {
  // Calculate the texture coordinates
  vec2 uv = vertTexCoord.st;

  // Calculate the distance from the current pixel to the center of the stroke
  float distanceToCenter = distance(uv, u_mouse);

  // Define brush parameters
  float brushSize = 0.04;
  float brushSoftness = 0.02;
  vec3 brushColor = vec3(0.2, 0.6, 1.0);

  // Use smoothstep to create a soft edge for the brush
  float brush = smoothstep(brushSize, brushSize + brushSoftness, distanceToCenter);

  // Mix the brush color with the background color based on brush intensity
  vec3 finalColor = mix(vertColor.rgb, brushColor, brush);

  // Set the output color with the original alpha value
  gl_FragColor = vec4(finalColor, vertColor.a);
}
