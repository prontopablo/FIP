PShader[] customShaders = new PShader[22];
String[] shaderNames = { "Gaussian Blur", "Motion Blur", "Sobel Edge Detection", "Edge Enhancement", "Difference of Gaussian", "Unsharp Masking", "Edge-Preserving Filter", "Grayscale", "Flip", "Invert Colors", "Erosion", "Vignette", "Quantization", "Halftone", "Pixelate", "Sharpen", "Rotate", "Cartoon", "Emboss", "Bloom", "Threshold", "Cel Shading" };
PImage[] images = new PImage[3];
int currentShaderIndex = 0;
int currentImageIndex = 0;
boolean useFilter = true;
PImage lucio;
PImage venice;
PImage koala;

void setup() {
  size(1000, 1000, P3D);

  customShaders[0] = loadShader("gaussianBlur.glsl");
  customShaders[1] = loadShader("motionBlur.glsl");
  customShaders[2] = loadShader("sobelEdgeDetection.glsl");
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
  customShaders[14] = loadShader("pixelate.glsl");
  customShaders[15] = loadShader("sharpen.glsl");
  customShaders[16] = loadShader("rotate.glsl");
  customShaders[17] = loadShader("cartoon.glsl");
  customShaders[18] = loadShader("emboss.glsl");
  customShaders[19] = loadShader("bloom.glsl");
  customShaders[20] = loadShader("threshold.glsl");
  customShaders[21] = loadShader("celShading.glsl");

  images[0] = loadImage("lucio.jpg");
  images[1] = loadImage("venice.jpg");
  images[2] = loadImage("koala.jpg");

  println("Using: " + shaderNames[currentShaderIndex]);
  stroke(255, 0, 0);
  rectMode(CENTER);
}

void draw() {
  // Start measuring time
  int startTime = millis();
  image(images[currentImageIndex], 0, 0, width, height);
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
    if (useFilter == true) {
      filter(customShaders[currentShaderIndex]);
    }
  }

  // End measuring time
  int endTime = millis();
  // println("Time taken: " + (endTime - startTime) + " ms");
}

void keyPressed() {
  // Use left and right arrow keys to cycle shaders
  if (keyCode == LEFT) {
    currentShaderIndex = (currentShaderIndex - 1 + customShaders.length) % customShaders.length;
    println("Using: " + shaderNames[currentShaderIndex]);
  } else if (keyCode == RIGHT) {
    currentShaderIndex = (currentShaderIndex + 1) % customShaders.length;
    println("Using: " + shaderNames[currentShaderIndex]);
  } else if (keyCode == DOWN) {
    currentImageIndex = (currentImageIndex - 1 + images.length) % images.length;
  } else if (keyCode == UP) {
    currentImageIndex = (currentImageIndex + 1) % images.length;
  } else if (key == 'x') {
    useFilter = !useFilter;
    if (!useFilter) {
      println("No filter");
    } else {
      println("Using: " + shaderNames[currentShaderIndex]);
    }
  }
}
