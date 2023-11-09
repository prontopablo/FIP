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
    float threshold = 0.5;
    
    // Sample the surrounding pixels
    vec4 centerColor = texture2D(texture, tc);
    vec4 leftColor = texture2D(texture, tc - texOffset);
    vec4 rightColor = texture2D(texture, tc + texOffset);
    vec4 topColor = texture2D(texture, tc - vec2(0.0, texOffset.t));
    vec4 bottomColor = texture2D(texture, tc + vec2(0.0, texOffset.t));
    
    // Calculate the intensity gradients
    float horizontalGradient = length(leftColor.rgb - rightColor.rgb);
    float verticalGradient = length(topColor.rgb - bottomColor.rgb);
    
    // Combine gradients to detect edges
    float edgeIntensity = sqrt(horizontalGradient * horizontalGradient + verticalGradient * verticalGradient);
    
    // Apply the threshold to highlight edges
    vec4 edgeColor = edgeIntensity > threshold ? vec4(0.0, 0.0, 0.0, 1.0) : vec4(1.0, 1.0, 1.0, 1.0);

    // Sample the texture
    vec4 texColor = texture2D(texture, tc);

    // Quantize each color channel to four levels
    float r = floor(texColor.r * 4.0) / 4.0;
    float g = floor(texColor.g * 4.0) / 4.0;
    float b = floor(texColor.b * 4.0) / 4.0;

    // Set the output color with the original vertex color, cel shading, and edge detection
    gl_FragColor = mix(vec4(r, g, b, texColor.a) * vertColor, edgeColor * vertColor, smoothstep(0.4, 0.6, edgeIntensity));
}
