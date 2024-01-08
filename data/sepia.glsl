#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

#define PROCESSING_TEXTURE_SHADER

/*
    Followed: https://stackoverflow.com/questions/36434905/processing-an-image-to-sepia-tone-in-python
*/

uniform sampler2D texture;
uniform vec2 texOffset;

varying vec4 vertColor;
varying vec4 vertTexCoord;

void main() {
    vec2 tc = vertTexCoord.st;
    
    // Sample the texture color
    vec4 color = texture2D(texture, tc);
    
    // Convert to grayscale
    float gray = dot(color.rgb, vec3(0.299, 0.587, 0.114));
    
    // Sepia tone transformation
    vec3 sepiaColor = vec3(gray * 1.2, gray * 0.9, gray * 0.7);
    
    // Output the sepia-toned color
    gl_FragColor = vec4(sepiaColor, color.a) * vertColor;
}