PShader[] customShaders = new PShader[10]; // Array to hold custom shaders
String[] shaderNames = { "Gaussian Blur", "Motion Blur", "Laplacian Filter", "Edge Detection", "Edge Enhancement", "Difference of Gaussian", "Unsharp Masking", "Edge-Preserving Filter", "Grayscale", "Flip", "Invert Colors" };
int currentShaderIndex = 0; // Index to keep track of the current shader
PImage lucio;
PImage venice;

void setup() {
  size(1000, 1000, P2D);
  customShaders[0] = loadShader("gaussianBlur.glsl"); // Example blur (takes no parameters)
  customShaders[1] = loadShader("motionBlur.glsl");
  customShaders[2] = loadShader("laplacianFilterWithThreshold.glsl");
  customShaders[3] = loadShader("edgeDetection.glsl");
  customShaders[4] = loadShader("laplacianEdgeEnhancement.glsl");
  customShaders[5] = loadShader("differenceOfGaussian.glsl");
  customShaders[6] = loadShader("unsharpMasking.glsl");
  customShaders[7] = loadShader("edgePreservingFilter.glsl");
  customShaders[8] = loadShader("grayscale.glsl");
  customShaders[9] = loadShader("flip.glsl");
  customShaders[10] = loadShader("invertColors.glsl");
  println("Using: " + shaderNames[currentShaderIndex]);
  lucio = loadImage("lucio.jpg");
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
    } else if (currentShaderIndex == 5) {
      customShaders[currentShaderIndex].set("radius1", 10.0); // Adjust radii here
      customShaders[currentShaderIndex].set("radius2", 5.0);
    } else if (currentShaderIndex == 7) {
      customShaders[currentShaderIndex].set("threshold", 0.2); // Adjust threshold for edge-preserving filter
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
  // Add this condition to reset to the built-in shader when the end of the custom shaders is reached.
  if (currentShaderIndex == customShaders.length) {
    currentShaderIndex = 0; // Reset to the built-in shader
    println("Using built-in shader");
  }
  println("Using: " + shaderNames[currentShaderIndex]);
}
