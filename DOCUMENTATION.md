# Animator Documentation

*Last updated: December 19, 2024*

## Overview

Animator is a specialized MATLAB® toolbox designed to create GIF animations from MATLAB code. It provides a powerful yet simple way to visualize parameter changes in your MATLAB plots by automatically generating animated GIF files.

## Key Features

- Parameter sweep automation
- Smooth transition generation
- GIF file creation
- Support for reverse animations
- Customizable frame rates
- Integration with MATLAB editor

## Requirements

- MATLAB R2022a or newer
- MATLAB Editor (for code manipulation)
- Write permissions in the working directory (for saving GIF files)

## Core Functions

### sweep.m

The main function that handles the animation creation process. 

**Syntax:**
```matlab
sweep(filename, codeLine, sweepRangeText, lineNumber, nSteps, animationOption, reverseFlag, saveAnimFlag, gifFileName, framesPerSecond)
```

**Parameters:**
- `filename`: The target M-file containing the plot code
- `codeLine`: The line of code containing the parameter to animate
- `sweepRangeText`: Range specification for the parameter sweep
- `lineNumber`: Line number in the file to modify
- `nSteps`: Number of steps in the animation
- `animationOption`: Animation style option
- `reverseFlag`: Boolean to control bi-directional animation
- `saveAnimFlag`: Boolean to control saving to file
- `gifFileName`: Output GIF filename
- `framesPerSecond`: Animation frame rate

### splitCode.m

Utility function for parsing code lines and extracting variable information.

**Supported Code Formats:**
- Simple assignment: `a = 1`
- Complex expressions with numerical values

## Usage Guide

1. **Prepare Your Code**
   - Create an M-file with your plotting code
   - Identify the parameter you want to animate
   - Ensure the parameter is assigned a numerical value

2. **Set Animation Parameters**
   - Choose the sweep range for your parameter
   - Decide on the number of animation steps
   - Set the desired frame rate
   - Choose whether to include reverse animation

3. **Generate Animation**
   - Call the sweep function with your parameters
   - The tool will automatically:
     - Modify your code
     - Generate plot snapshots
     - Compile the GIF animation

## Best Practices

1. **Code Organization**
   - Keep plotting code in a separate section
   - Use clear variable names
   - Comment your animation parameters

2. **Performance Optimization**
   - Choose appropriate step counts
   - Consider frame rate impact on file size
   - Use efficient plotting commands

3. **File Management**
   - Use descriptive GIF filenames
   - Save animations in a dedicated directory
   - Keep backup copies of original code

## Troubleshooting

Common issues and solutions:

1. **Line Doesn't Match Expected Assignment**
   - Ensure the target line contains a simple numerical assignment
   - Check for proper syntax in the assignment statement
   - Verify line number is correct

2. **Animation Quality Issues**
   - Adjust number of steps for smoother transitions
   - Modify frame rate for better viewing
   - Consider using the reverse flag for smooth looping

3. **File Access Problems**
   - Check write permissions in the target directory
   - Ensure file paths are correct
   - Verify MATLAB has access to all required files

## Contributing

For bug reports or feature requests, please use the [GitHub Issues page](https://github.com/gulley/Animator/issues).

## License

See the LICENSE file in the repository for detailed licensing information.

---

For additional examples and tutorials, refer to the `toolbox/examples/` directory, particularly the `GettingStarted.mlx` file.
