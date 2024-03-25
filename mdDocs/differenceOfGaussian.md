Applies two Gaussian blurs to the input texture and calculates the Difference of Gaussian.

## Parameters
`texture` **Texture**: The input texture to be filtered. Default: **`The entire canvas`**
<br>
`texOffset` **Vec2:** The offset used for sampling neighboring pixels. Default: **`(1.0 / width, 1.0 / height)`**
<br>
`radius1` **Float:** The radius of the first Gaussian blur. Default: **`10.0`**
<br>
`radius2` **Float:** The radius of the second Gaussian blur. Default: **`1.0`**
<br>
`threshold` **Float:** The intensity threshold below which colors will be discarded. Default: **`0.01`**

## Example
```java
import fip.*;

PShader differenceOfGaussian;
PImage ireland;

void setup() {
  size(1000, 1000, P3D);

  differenceOfGaussian = loadShader(FIP.differenceOfGaussian);

  ireland = loadImage("ireland.jpg");

  differenceOfGaussian.set("radius1", 10.0);
  differenceOfGaussian.set("radius2", 1.0);
  differenceOfGaussian.set("threshold", 0.2);
}

void draw() {
  image(ireland, 0, 0, width, height);

  filter(differenceOfGaussian);
}
```