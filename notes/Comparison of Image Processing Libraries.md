# Comparison of Image Processing Libraries

## Overview

When considering the purpose of the project, it's important to evaluate current solutions and their features, ease of use, and availability. Below is a comparison of several image processing libraries for use with Processing:

## PixelFlow

- **Availability**: Processing Library Manager.
- **Features**: Offers a decent range of shaders.
- **Shader Compatibility**: Provides a wrapper for ShaderToy, allowing artists to use ShaderToy shaders in Processing.
- **Installation**: Easily importable from the Processing Library Manager.
- **Manual Cloning**: Not required.

## Filters4Processing

- **Features**: Limited selection of approximately 10 shaders.

## Lygia

- **Features**: Extensive collection of shaders.
- **Installation and Dependencies**: May be more complex to set up and manage due to dependencies.

## Tutorials/Examples Libraries

- These libraries offer tutorials and examples but are generally less relevant to advanced image processing tasks.

<br>

## Documentation

- **Reference Documentation**: None of the libraries provide reference documentation for shaders, making it challenging for users to look up shader usage and parameters.

## Recommendations

- **Primary Recommendation**: PixelFlow is the closest equivalent to the proposed project due to its features, ease of use, and availability through the Processing Library Manager.
- **Alternative Options**: Artists seeking more diverse options can explore other shader libraries with Processing wrappers such as Lygia, OpenCV, and ShaderToy.

<br>

## PixelFlow Features

PixelFlow offers the following image processing operations:

- Box Blur
- Binomial Blur
- Gauss Blur
- Gauss Blur Pyramid
- Median
- Bilateral Filter
- Custom Convolution Kernel
- DoG (Difference of Gaussian)
- Background Subtraction
- Difference - Laplace
- Sobel
- Gamma Correction
- Luminance
- Thresholding
- Harris Corner Detection
- Optical Flow - Bloom
- Depth of Field (DoF)
- Liquid FX Filter
- Summed Area Table (SAT)
- Distance Transform (Jumpflood), Voronoi, Distance Map
- Min/Max (global)
- Min/Max (local)
- Merge Shader
- FlowField
- Line Integral Convolution (LIC) / Streamlines