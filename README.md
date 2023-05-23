[![View Animator on File Exchange](https://www.mathworks.com/matlabcentral/images/matlab-file-exchange.svg)](https://www.mathworks.com/matlabcentral/fileexchange/119683-animator) 
[![Open in MATLAB Online](https://www.mathworks.com/images/responsive/global/open-in-matlab-online.svg)](https://matlab.mathworks.com/open/github/v1?repo=gulley/Animator&project=Animator.prj&file=code/doc/GettingStarted.mlx) 

[![Animator CI/CD](https://github.com/gulley/Animator/actions/workflows/main.yml/badge.svg)](https://github.com/gulley/Animator/actions/workflows/main.yml) [![GitHub issues by-label](https://img.shields.io/github/issues-raw/gulley/Animator/bug)](https://github.com/gulley/Animator/issues?q=is%3Aissue+is%3Aopen+label%3Abug) ![GitHub Repo stars](https://img.shields.io/github/stars/gulley/Animator?style=social)


# Animator

Animator is a tool for making GIF animation files from MATLAB® code.

![Rotating membrane](code/doc/logo_demo.gif)

## Setup

Here's how it works.

1. Create an M-file that generates the plot that you want to animate.
2. Indicate which parameter you want to change and how (this needs to be an assignment statement of the form "a = 1").

The Animator then manipulates your code and takes snapshots of the resulting plot. These snapshots are
gathered into the GIF animation file and saved to disk.
 
![How it works](img/howto.png)

For more information, look at the documentation files in the code/doc/ directory, especially GettingStarted.mlx

## MathWorks Products

Animator requires MATLAB release R2022a or newer.

## License

The license is available in the License file within this repository.
