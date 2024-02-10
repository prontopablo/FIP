### Week Starting 05/02/24
#
- Updated sharpness uniforms

###

- Ported grayscale, flip, rotate, sepia, sharpen, saturation, gamma, brightness, pixelate, quantization, solarize, contrast, deform, dithering, dot, ripple, invert colors, mosaic, cartoon, dilate, vignette, unsharp masking, box blur, canny edge detection, blend, bloom, threshold, bilateral, CRT, DoG to p5.js
- Updated cartoon to have edgeThreshold parameter
- Updated box blur to have blurRadius parameter

#

### Week Starting 29/01/24
#
- Linocut

###

- Updated duoTone default values for a stronger effect
- Added flip directions to flip
- Fixed error in quantization shader logic

### Week Starting 22/01/24
#
- Created Documentation website and started hosting it on GitHub Pages.
- Added Getting Started and Resources sections to docs, along with Blend as an example reference.

###

- Updated blend to have multiple (14) modes
- Updated Contrast to clamp color output between 0.0 and 1.0
- Updated Vignette to have 3 additional parameters
- Removed cubify due to aritifacts on other GPUs - [Screenshot](https://github.com/prontopablo/FIP/blob/main/notes/Progress%20Screenshots/cubifyPrecision.png)

###
- Duo-tone
- Solarize
- Box Blur
- Brightness
- Deform
- Dilate
- Dot
- Ripple 

#

### Week Starting 15/01/24
#
- Interim Report

#

### Week Starting 08/01/24
#
- Contrast
- Saturation
- Gamma
- Mosaic
- Static
- Dithering
- Kuwahara
###
- Added comment header for every shader
- Adjusted default values for every shader
- Updated research links and restructured project files.
- Added this library to library comparison table.
#

### Week Starting 18/12/23
#
- Sketch
- CRT

#

### Week Starting 04/12/23
#
- Updated [table comparing library functionality](FunctionComparisonTable.jpg)

#
### Week Starting 27/11/23
#
- Created [Introduction First Draft](Introduction%20First%20Draft.md)

#
### Week Starting 20/11/23
#
- Created [table comparing library functionality](FunctionComparisonTable.jpg)
- Created [3D demo](https://www.youtube.com/watch?v=PWXdbIyUZIo) 
#
### Week Starting 13/11/23
#
- Started adding notes at the top of each shader for descriptions and credit.
###
- Bilateral
- Glitch
- Sepia
- Canny Edge Detection
- Cubify
- Blend
#

### 16/10/23 - 30/10/23
#
- Created [comparison of current libraries](Comparison%20of%20Image%20Processing%20Libraries.md)
- Created a [library](Library%20Notes.md)
- Reorganised project folder and switched to .md files
###
- Threshold
- Bloom
- Emboss
- Pixelate 
- Sharpen
- Rotate
- Cartoon
 ###
- Renamed "Edge Detection" to "Sobel Edge Detection" for clarity
#
### Week Starting 09/10/23
#  
-  Difference of Gaussian
-  Unsharp Masking
-  Edge Preserving
-  Grayscale
-  Flip
-  Invert Colours
-  Erosion
-  Vignette
-  Quantization
-  Halftone
###
- Got images to work with shaders (was drawing the image after the filter was applied) (see: https://stackoverflow.com/questions/38384768/processing-fragment-shader-not-displaying-anything)
- Started to define default values for shaders (see motionBlur.glsl blurAmount)
- Added code to GitHub