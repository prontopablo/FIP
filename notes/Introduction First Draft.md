# Introduction
In the landscape of creative coding, Processing stands out as a versatile platform. Processing is a free integrated development environment (IDE) designed to cater to the needs of artists, designers, and creative coders. It streamlines the development of visual applications by providing a comprehensive set of functions. These include capabilities for drawing graphics, managing user input, and creating animations. 

There are several existing image processing libraries for Processing. However, real-time post-processing requires efficiency, flexibility, and an expansive array of effects. Upon analysing the landscape of existing solutions, it becomes evident that the current offerings, while commendable, leave room for enhancement.

## Motivation
This project aims to address the issues in existing image-processing libraries for Processing. This will be achieved by introducing a comprehensive, hardware-accelerated image processing library. There are three key objectives: to significantly improve performance by leveraging shaders for real-time post-processing, to create a comprehensive set of post-processing operations to enable artists and developers, and to augment user experience through flexible usage and detailed documentation.

## Research Question / Project Objectives

## Outline of the Project Work

## Technical Terms (?)
_Should this section be integrated into the text by explaining the terms as they come up?_ ***

OpenGL Shading Language (GLSL) is a C-style shading language. Shaders are programs that modify the position and colour of the pixels and vertices that make up a rendered image. Shaders are typically executed on a graphics processing unit (GPU) owing to its capacity for parallel processing. Shaders empower developers to manipulate pixels and generate visually striking effects with exceptional performance (subjective?). GLSL shaders find widespread application in creative coding and graphics programming, and Processing provides robust support for their implementation.

Post-processing refers to the application of effects and manipulations to an image or video after the initial rendering.

## Structure & Contents
### Chapter 2: State of the Art

Building upon the foundations laid in the introduction, this chapter conducts an in-depth exploration of existing image-processing libraries for Processing. This includes a comparison of the features, ease of use, and performance of each library. The insights gained in this chapter aid in understanding the necessity of the proposed solution.

### Chapter 3: Design

A comprehensive understanding of the existing landscape informs the transition to the design phase. This chapter outlines the library's architecture and design.

### Chapter 4: Implementation

The design takes shape in this chapter as the technical aspects are detailed. This includes implementing the GLSL shaders, ensuring compatibility with two Processing variants, and addressing challenges encountered during the development process. Code snippets, diagrams, and detailed explanations provide readers with a practical understanding of the solution.

### Chapter 5: Evaluation

To assess the efficacy of the proposed solution, this chapter presents a thorough evaluation. Performance benchmarks and comparisons with existing libraries are analysed to gauge the effectiveness of the library. By providing transparent insights into the evaluation process, readers can objectively assess the contributions and limitations of the developed solution.

### Chapter 6: Conclusions

This chapter synthesizes the key findings and implications of the research. It includes a reflection on the decisions made from identifying a need within the existing landscape to proposing, designing, and implementing a real-time image post-processing library for Processing. The chapter concludes with thoughts on future research.

# Structure Followed:
![Alt text](<IntroductionStructure.png>)


