Combines Sobel operator for edge detection and stippling. The Sobel operator calculates the intensity gradient of the image, and the stippling effect adds random dots to the edges, creating an TV static appearance.

## Parameters
`texture` **Texture**: The input texture to be filtered. Default: **`The entire canvas`**
<br>
`texOffset` **Vec2:** The offset used for sampling neighboring pixels. Default: **`(1.0 / width, 1.0 / height)`**
<br>
`threshold` **Float:** The threshold for edge detection. Pixels with intensity above this threshold will be treated as edges.Default: **`0.05`**
<br>
`stippleDensity` **Float:** The density of stippling dots to be added to the ink effect. A lower value results in more dots.Default: **`0.99`**

## Example
```processing
import fip.*;

PShader static;

PImage ireland;

void setup() {
  size(1000, 1000, P3D);

  static = loadShader("static.glsl");

  ireland = loadImage("ireland.jpg");

  static.set("threshold", 0.05);
  static.set("stippleDensity", 0.99);
}

void draw() {
  image(ireland, 0, 0, width, height);

  filter(static);
}

```