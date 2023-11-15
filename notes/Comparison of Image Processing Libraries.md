# Comparison of Image Processing Libraries

### Overview

When considering the purpose of the project, it's important to evaluate current solutions and their features, ease of use, and availability. Below is a comparison of several image processing libraries for use with Processing:

![Alt text](image.png)
<div style="text-align:center;"><i>Table 1: Overview of Existing Image Processing Libraries for p5</i>
</div>

<br>

![Alt text](image-1.png)
<div style="text-align:center;"><i>Table 2: Comparison of Functions by Library</i>
</div>

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
<br>
<br>

## Documentation

- **Reference Documentation**: PixelFlow is again at the forefront and provides the best documentation, with generated javadocs and a sample sketch. However, it is still not possible to easily search for a filter and see an example. The documentation the other libraries provide is limited or it is contained in code comments within GLSL files, making it challenging for users to look up shader usage and parameters.

## Recommendations

- **Primary Recommendation**: PixelFlow is the closest equivalent to the proposed project due to its features and its availability through the Processing Library Manager.
- **Alternative Options**: Artists seeking more diverse options can explore other shader libraries with Processing wrappers such as Lygia, OpenCV, and ShaderToy. This is a larger overhead, with more technical knowledge required. An artist would have to find the shader they wanted to use on a website like ShaderToy or OpenCV. They would then have to bring that shader into their sketch and use the appropriate wrapper provided by a library.
