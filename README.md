NOTE:  This file appears to not work with newer versions of Matlab.  One of these days I'll fix it, but for now, it's here just for reference, don't waste time trying to get it to run!

# Noronha-et-al-2015-QSR

Matlab code from soil carbon model used in [Noronha et al 2015] (http://www.sciencedirect.com/science/article/pii/S0277379115002267), *Quaternary Science Reviews.*

Main file is bombC.m, all other functions are called by this file.  File heshang.txt is the new data published in the QSR manuscript, and serves of an example of the input file required by the bombC.m.

**Stalagmite data input file requires a three column matrix:**

1. calendar age of sample in Yr BP (BP = 1950)

2. a<sup>14</sup>C of sample in FM

3. 1&sigma; error of a<sup>14</sup>C (FM) measurement

Post-bomb a<sup>14</sup>C regional atmospheric records retrieved from [CALIBomb](http://calib.qub.ac.uk/CALIBomb/), which is nd described in detail in [Hua et al 2013](https://journals.uair.arizona.edu/index.php/radiocarbon/article/view/16177), *Radiocarbon*.

Pre-bomb atmospheric a<sup>14</sup>C records separated into a [Nothern Hemisphere](from [Reimer et al 2013](https://journals.uair.arizona.edu/index.php/radiocarbon/article/view/16947), *Radiocarbon*) and a Southern Hemisphere (from [Hogg et al 2013](https://journals.uair.arizona.edu/index.php/radiocarbon/article/view/16783), *Radiocarbon*) record based on [IntCal13](http://www.radiocarbon.org/IntCal13.htm).

The code as described in the manuscript and uses the function `Multistart` which is part of the Global Optimization Toolbox available from [MathWorks](http://www.mathworks.com/products/global-optimization/).  The bombC.m file will check for the Toolbox, use it if it's present, or use packages that are standard to the Matlab distribution if unavialable.  Solutions produced without `Multistart` are often adquate, though generally not as good as the solutions produced by `MultiStart`.
