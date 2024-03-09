### Week Starting 04/03/24
- Writeup work, working through feedback
- Updated website to have next/prev buttons, footer, footnotes.
- Updated FIP archictecture to abstract file path loading

#

### Week Starting 19/02/24
- Converted docs to generate static html for offline reference, restyled website
- Added stable release url (latest tag) and FIP.txt as per the library guidelines
- Fixed examples in reference pages
- Compressed site images
###
- Created p5.FIP.js
- Created p5.FIP GitHub + Site
- Added p5.FIP examples + collection
###
- Added Anti-aliasing
- Fixed unused uniforms in duoTone, quantization and linocut
- Renamed Edge Preserving Filter to Edge Preserving Smooth
- Fixed flipped y coordinates in glitch shader 
- Added PGraphics example
- Ported static shader to p5.js
###
- Converted comparison table to LaTeX

#

### Week Starting 12/02/24
- Hosted FIP on alternative GitHub account while having account issues
- Posted on Processing Discourse asking for feedback, testing and suggestions
- Wrote shader reference page for every shader
- Submitted FIP to Contribution Manager
- Added copy code button to reference site
#

### Week Starting 05/02/24

- Updated sharpness uniforms

###

- Ported all 43 shaders to p5.js
- Updated cartoon to have edgeThreshold parameter
- Updated box blur to have blurRadius parameter
- Updated edge preserving filter to have defualt threshold value
- Updated laplacian edge enhancement to have amount value
- Released FIP v.1.0.0 alpha with 43 shaders and 4 examples

#

### Week Starting 29/01/24
- Linocut

###

- Updated duoTone default values for a stronger effect
- Added flip directions to flip
- Fixed error in quantization shader logic

#

### Week Starting 22/01/24

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

- Interim Report

#

### Week Starting 08/01/24

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

- Sketch
- CRT

#

### Week Starting 04/12/23

- Updated [table comparing library functionality](FunctionComparisonTable.jpg)

#
### Week Starting 27/11/23

- Created [Introduction First Draft](Introduction%20First%20Draft.md)

#
### Week Starting 20/11/23

- Created [table comparing library functionality](FunctionComparisonTable.jpg)
- Created [3D demo](https://www.youtube.com/watch?v=PWXdbIyUZIo) 
#
### Week Starting 13/11/23

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