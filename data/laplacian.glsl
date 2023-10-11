#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

#define PROCESSING_TEXTURE_SHADER

uniform sampler2D texture;
uniform vec2 texOffset;

varying vec4 vertColor;
varying vec4 vertTexCoord;

void main() {
    vec2 tc = vertTexCoord.st;
    
    // Define the Laplacian filter kernel
    mat3 laplacianKernel = mat3(-1, -1, -1,
                                -1,  8, -1,
                                -1, -1, -1);
    
    // Apply the Laplacian filter to the texture
    vec3 sum = vec3(0.0);
    sum += texture2D(texture, tc - texOffset).rgb * laplacianKernel[0][0];
    sum += texture2D(texture, tc).rgb * laplacianKernel[0][1];
    sum += texture2D(texture, tc + texOffset).rgb * laplacianKernel[0][2];
    sum += texture2D(texture, tc - texOffset.yx).rgb * laplacianKernel[1][0];
    sum += texture2D(texture, tc.yx).rgb * laplacianKernel[1][1];
    sum += texture2D(texture, tc + texOffset.yx).rgb * laplacianKernel[1][2];
    sum += texture2D(texture, tc - texOffset).rgb * laplacianKernel[2][0];
    sum += texture2D(texture, tc).rgb * laplacianKernel[2][1];
    sum += texture2D(texture, tc + texOffset).rgb * laplacianKernel[2][2];
    
    // Apply a threshold to create a binary edge map
    float threshold = 0.3;
    vec3 edgeColor = vec3(1.0, 1.0, 1.0);
    vec3 nonEdgeColor = vec3(0.0, 0.0, 0.0);
    vec3 resultColor = mix(nonEdgeColor, edgeColor, step(threshold, length(sum)));
    
    gl_FragColor = vec4(resultColor, 1.0) * vertColor;
}
