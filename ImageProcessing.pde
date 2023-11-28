// import processing.video.*;

PShader[] customShaders = new PShader[27];
String[] shaderNames = { "Gaussian Blur", "Motion Blur", "Sobel Edge Detection", "Edge Enhancement", "Difference of Gaussian", "Unsharp Masking", "Edge-Preserving Filter", "Grayscale", "Flip", "Invert Colors", "Erosion", "Vignette", "Quantization", "Halftone", "Pixelate", "Sharpen", "Rotate", "Cartoon", "Emboss", "Bloom", "Threshold", "Blend", "Cubify", "Canny Edge Detection", "Sepia", "Glitch", "Bilateral Filter" };
PImage[] images = new PImage[3];
// Capture video;

int currentShaderIndex = 0;
int currentImageIndex = 0;
boolean useFilter = true;
PImage lucio;
PImage venice;
PImage koala;

void setup() {
  size(1000, 1000, P3D);
  
  // video = new Capture(this, width, height);
  // video.start();
  
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
  customShaders[21] = loadShader("blend.glsl");
  customShaders[22] = loadShader("cubify.glsl");
  customShaders[23] = loadShader("cannyEdgeDetection.glsl");
  customShaders[24] = loadShader("sepia.glsl");
  customShaders[25] = loadShader("glitch.glsl");
  customShaders[26] = loadShader("bilateral.glsl");
  
  images[0] = loadImage("lucio.jpg");
  images[1] = loadImage("venice.jpg");
  images[2] = loadImage("koala.jpg");

  println("Using: " + shaderNames[currentShaderIndex]);
}

void draw() {
  background(0);
  // Start measuring time
  int startTime = millis();
  
  //if (video.available()) {
  // video.read();
  //}
  
  // image(video, 0, 0, width, height);
  
  // image(images[currentImageIndex], 0, 0, width, height);
  
  // Draw ground
  drawGround();
  
  // Draw rotating boxes
  drawRotatingBoxes();
  
  // Apply the currently selected shader
  if (currentShaderIndex >= 0 && currentShaderIndex < customShaders.length) {
    if (currentShaderIndex == 1) {
      customShaders[currentShaderIndex].set("texOffset", 1.0 / width, 1.0 / height);
      customShaders[currentShaderIndex].set("blurAmount", 5.0);
    } else if (currentShaderIndex == 4) {
      customShaders[currentShaderIndex].set("radius1", 10.0);
      customShaders[currentShaderIndex].set("radius2", 1.0);
    } else if (currentShaderIndex == 6) {
      customShaders[currentShaderIndex].set("threshold", 0.2); 
    } else if (currentShaderIndex == 12) {
      customShaders[currentShaderIndex].set("shades", 4.0); 
    } else if (currentShaderIndex == 13) {
      customShaders[currentShaderIndex].set("cellSize", 10.0);
      customShaders[currentShaderIndex].set("threshold", 0.5);
    } else if (currentShaderIndex == 21) {
      customShaders[currentShaderIndex].set("texture1", images[0]);
      customShaders[currentShaderIndex].set("texture2", images[1]);
      customShaders[currentShaderIndex].set("mixFactor", 0.5);
    } else if (currentShaderIndex == 23) {
      customShaders[currentShaderIndex].set("thresholdLow", 0.2);
    } else if (currentShaderIndex == 25) {
      customShaders[currentShaderIndex].set("mouse", float(mouseX), float(mouseY));
    }
    if (useFilter == true) {
      filter(customShaders[currentShaderIndex]);
    }
  }

  // End measuring time
  int endTime = millis();
  println("Time taken: " + (endTime - startTime) + " ms");
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

void drawGround() {
  // Use texture for ground
  PGraphics textureGraphics = createGraphics(width, height);
  textureGraphics.beginDraw();
  textureGraphics.background(200);
  textureGraphics.stroke(0);
  textureGraphics.strokeWeight(2);
  textureGraphics.noFill();
  textureGraphics.translate(textureGraphics.width / 2, textureGraphics.height / 2);
  textureGraphics.rotateX(HALF_PI);
  textureGraphics.box(800, 800, 1);
  textureGraphics.endDraw();
  
  // Set ground texture
  texture(textureGraphics);
  
  // Draw ground plane
  pushMatrix();
  translate(width / 2, height / 2, 0);
  rotateX(HALF_PI);
  popMatrix();
  
  // Reset texture to avoid affecting other elements
  resetShader();
}

void drawRotatingBoxes() {
  // Draw multiple rotating boxes
  int numBoxes = 5;
  float spacing = 150;
  
  for (int i = 0; i < numBoxes; i++) {
    float angle = map(i, 0, numBoxes, 0, TWO_PI);
    float x = cos(angle) * spacing;
    float y = sin(angle) * spacing;
    
    pushMatrix();
    translate(width / 2 + x, height / 2 + y, sin(millis() * 0.002 + angle) * 100);
    rotateX(frameCount * 0.02);
    rotateY(frameCount * 0.03);
    box(50);
    popMatrix();
  }
}
