import fip.; // Import the FIP library
import java.util.ArrayList;

// Test conditions: Shaders run on an image for a minute before the
// frame time is averaged in ms.

PShader shader;
PImage ireland;
int lastFrameCount = 0;
ArrayList<Long> frameTimes = new ArrayList<>();

void setup() {
    size(1000, 1000, P3D); // Set up the canvas with a renderer (P3D in this case)

    shader = loadShader(FIP.gaussianBlur); // Load the glitch shader

    ireland = loadImage("irelandBefore.jpg");

    frameRate(1000);
}

void draw() {
    image(ireland, 0, 0, width, height);

    //filter(shader); // Apply the FIP shader
    filter(BLUR); // Apply the native shader

    if (frameCount > lastFrameCount) {
        long frameTime = (long)(1000.0 / frameRate); // Calculate frame time in milliseconds
        frameTimes.add(frameTime); // Store frame time in the ArrayList
        lastFrameCount = frameCount;
    }
}

void keyPressed() {
    if (key == 's' || key == 'S') {
        // Calculate and print the average frame time when the 's' key is pressed
        long sum = 0;
        for (Long time : frameTimes) {
            sum += time;
        }
        float averageFrameTime = (float) sum / frameTimes.size();
        println("Average Frame Time: " + averageFrameTime + " ms");
    }
}

/* 
 Results are presented in the format:
 Function Name (Parameter Value used):
 FIP Result
 Processing Result

 Dilate:
 3.6927211 ms
 58.789425 ms

 Erode:
 9.198722 ms
 60.1649 ms

 Threshold (Default):
 3.0775745 ms
 46.802082 ms

 Grayscale:
 3.0664055 ms
 47.203003 ms

 Invert:
 3.1128051 ms
 46.692722 ms

 Posterize/Quantize (2):
 3.0754905 ms
 50.054375 ms

 BLUR/Gaussian Blur (default):
 4.0849695 ms
 93.2671 ms

 Opaque:
 Not supported
 45.775127 ms

*/