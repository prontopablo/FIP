PShader[] customShaders = new PShader[6]; // Array to hold custom shaders
int currentShaderIndex = 0; // Index to keep track of the current shader
float blurAmount = 5.0; // To override the default values
PImage lucio;

void setup() {
  size(1000, 1000, P2D);
  customShaders[0] = loadShader("gaussianBlur.glsl"); // Example blur (takes no parameters)
  customShaders[1] = loadShader("motionBlur.glsl");
  customShaders[2] = loadShader("laplacian.glsl");
  customShaders[3] = loadShader("edgeDetection.glsl");
  customShaders[4] = loadShader("edgeEnhancement.glsl");
  customShaders[5] = loadShader("differenceOfGaussian.glsl");
  lucio = loadImage("lucio.jpg");
  stroke(255, 0, 0);
  rectMode(CENTER);
}

void draw() {
  // Start measuring time
  int startTime = millis();
  image(lucio, 0, 0, width, height);
  // Apply the currently selected shader
  if (currentShaderIndex >= 0 && currentShaderIndex < customShaders.length) {
    if (currentShaderIndex == 1) { // Apply motion blur shader
      customShaders[currentShaderIndex].set("texOffset", 1.0 / width, 1.0 / height);
      customShaders[currentShaderIndex].set("blurAmount", blurAmount);
    }
    else if (currentShaderIndex == 5){
      customShaders[currentShaderIndex].set("radius1", 10.0); // Adjust the radii as needed
      customShaders[currentShaderIndex].set("radius2", 5.0);
    }
    filter(customShaders[currentShaderIndex]);
  } else {
    filter(BLUR); // Default to built-in blur
  }
  
  // Draw shapes
  //rect(mouseX, mouseY, 350, 350);
  //ellipse(mouseX, mouseY, 300, 300);
  
  // End measuring time
  int endTime = millis();
  //println("Time taken: " + (endTime - startTime) + " ms");
}

void keyPressed() {
  // Cycle through custom shaders when number keys (1-6) are pressed
  if (key >= '1' && key <= '6') {
    currentShaderIndex = int(key) - '1'; // Convert key to shader index
    println("Using custom shader: " + (currentShaderIndex + 1));
  } 
  // Switch to built-in blur when the '0' key is pressed
  else if (key == '0') {
    currentShaderIndex = -1; // Use built-in blur
    println("Using built-in blur");
  }
}
