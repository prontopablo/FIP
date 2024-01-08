#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

#define PROCESSING_TEXTURE_SHADER

/*
    Tutorial followed and values provided by: https://tannerhelland.com/2011/10/01/grayscale-image-algorithm-vb6.html#:~:text=All%20grayscale%20algorithms%20use%20the,with%20the%20new%20gray%20value
*/

uniform sampler2D texture;
uniform vec2 texOffset;

varying vec4 vertColor;
varying vec4 vertTexCoord;

void main(void) {
  vec2 tc = vertTexCoord.st;
  vec4 color = texture2D(texture, tc);
  
  // Calculate the grayscale value for each pixel
  float gray = dot(color.rgb, vec3(0.299, 0.587, 0.114));
  
  // Create a grayscale color by using the grayscale value for all color channels
  gl_FragColor = vec4(vec3(gray), color.a) * vertColor;
}
