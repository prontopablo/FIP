PShader[] customShaders = new PShader[14]; // Array to hold custom shaders
String[] shaderNames = { "Gaussian Blur", "Motion Blur", "Edge Detection", "Edge Enhancement", "Difference of Gaussian", "Unsharp Masking", "Edge-Preserving Filter", "Grayscale", "Flip", "Invert Colors", "Erosion", "Vignette", "Quantization", "Halftone" };
int currentShaderIndex = 0; // Index to keep track of the current shader
PImage lucio;
PImage venice;

void setup() {
  size(1000, 1000, P2D);
  
  customShaders[0] = loadShader("gaussianBlur.glsl"); // Example blur (takes no parameters)
  customShaders[1] = loadShader("motionBlur.glsl");
  customShaders[2] = loadShader("edgeDetection.glsl");
  customShaders[3] = loadShader("laplacianEdgeEnhancement.glsl");
  customShaders[4] = loadShader("differenceOfGaussian.glsl");
  customShaders[5] = loadShader("unsharpMasking.glsl");
  customShaders[6] = loadShader("edgePreservingFilter.glsl");
  customShaders[7] = loadShader("grayscale.glsl");
  customShaders[8] = loadShader("flip.glsl");
  customShaders[9] = loadShader("invertColors.glsl");
  customShaders[10] = loadShader("erosion.glsl");
  customShaders[11] = loadShader("vignette.glsl");
  customShaders[12] = loadShader("quantization.glsl");
  customShaders[13] = loadShader("halftone.glsl");

  println("Using: " + shaderNames[currentShaderIndex]);
  // lucio = loadImage("lucio.jpg");
  venice = loadImage("venice.jpg");
  stroke(255, 0, 0);
  rectMode(CENTER);
}

void draw() {
  // Start measuring time
  int startTime = millis();
  // image(lucio, 0, 0, width, height);
  image(venice, 0, 0, width, height);
  // Apply the currently selected shader
  if (currentShaderIndex >= 0 && currentShaderIndex < customShaders.length) {
    if (currentShaderIndex == 1) { // Apply motion blur shader
      customShaders[currentShaderIndex].set("texOffset", 1.0 / width, 1.0 / height);
      customShaders[currentShaderIndex].set("blurAmount", 5.0);
    } else if (currentShaderIndex == 4) {
      customShaders[currentShaderIndex].set("radius1", 10.0); // Adjust radii here
      customShaders[currentShaderIndex].set("radius2", 1.0);
    } else if (currentShaderIndex == 6) {
      customShaders[currentShaderIndex].set("threshold", 0.2); // Adjust threshold for edge-preserving filter
    } else if (currentShaderIndex == 12) {
      customShaders[currentShaderIndex].set("shades", 4.0); // set shades per color channel
    } else if (currentShaderIndex == 13) {
      customShaders[currentShaderIndex].set("cellSize", 10.0);
      customShaders[currentShaderIndex].set("threshold", 0.5);
    }
    filter(customShaders[currentShaderIndex]);
  }

  // Draw shapes
  // rect(mouseX, mouseY, 350, 350);
  // ellipse(mouseX, mouseY, 300, 300);

  // End measuring time
  int endTime = millis();
  // println("Time taken: " + (endTime - startTime) + " ms");
}

void keyPressed() {
  // Use the left arrow key to cycle to the previous shader
  if (keyCode == LEFT) {
    currentShaderIndex = (currentShaderIndex - 1 + customShaders.length) % customShaders.length;
  }
  // Use the right arrow key to cycle to the next shader
  else if (keyCode == RIGHT) {
    currentShaderIndex = (currentShaderIndex + 1) % customShaders.length;
  }

  println("Using: " + shaderNames[currentShaderIndex]);
}
