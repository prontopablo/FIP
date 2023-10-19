# Library Notes
I've created a working Processing library using the official library template. Using the library would look something like this:
1) If the library was accepted by the Processing Foundation, users could install the library from the library manager.
2) Users would then import the library into their sketch and initialize it. They then load the shader in setup() and apply it in draw() (as seen below).

```processing
import imageProcessing.*; // Import the library

ImageProcessing ip;
PImage venice;

void setup() {
    size(1000, 1000, P2D);
    ip = new ImageProcessing(this); // Initialize library

    // Load an image
    venice = loadImage("venice.jpg");

    ip.loadShader(); // Load the shader
}

void draw() {
    background(255);
    image(venice, 0, 0, width, height);

    ip.applyShader(); // Apply the shader
}
```

3) Setting parameters would look something like:
```processing
    // Set individual shader parameters
    ip.setShaderParameter("param1", 0.5);
    ip.setShaderParameter("param2", 0.8);
    
    // Set multiple shader parameters using a Map
    Map<String, Float> parameters = new HashMap<String, Float>();
    ip.parameters.put("param1", 0.5);
    ip.parameters.put("param2", 0.8);
    ip.setShaderParameters(parameters);
```