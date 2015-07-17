# Noronha-et-al-2015-QSR
Matlab code from soil carbon model used in Noronha, A. L., K. R. Johnson, J. R. Southon, C. Hu, J. Ruan, and S. McCabe-Glynn (2015), [Radiocarbon Evidence for Decomposition of Aged Organic Matter in the Vadose Zone as the Main Source of Speleothem Carbon](http://www.sciencedirect.com/science/article/pii/S0277379115002267), *Quaternary Science Reviews.*

Main file is in file bombC.m, all other functions are called by this file.  File heshang.txt is the new data published in the QSR manuscript, and serves of an example of the input file required by the bombC.m.

**Stalagmite data input file requires a three column matrix:**

1. calendar age of sample in Yr BP (BP = 1950)

2. a<sup>14</sup>C of sample in FM

3. 1&sigma; error of a<sup>14</sup>C (FM) measurement

Post-bomb a<sup>14</sup>C regional atmospheric records retrieved from [CALIBomb](http://calib.qub.ac.uk/CALIBomb/)

And described in detail in:
Hua, Q., M. Barbetti, and A. Rakowski (2013), [Atmospheric Radiocarbon for the Period 1950–2010](https://journals.uair.arizona.edu/index.php/radiocarbon/article/view/16177), *Radiocarbon*, 55(4), 2059–2072. 

Pre-bomb atmospheric a<sup>14</sup>C records separated into a Nothern Hemisphere and a Southern Hemisphere record based on [IntCal13](http://www.radiocarbon.org/IntCal13.htm):

Reimer, P. J., E. Bard, A. Bayliss, J. W. Beck, P. G. Blackwell, C. B. Ramsey, C. E. Buck, H. Cheng, R. L. Edwards, M. Friedrich, P. M. Grootes, T. P. Guilderson, H. Haflidason, I. Hajdas, C. Hatte, T. J. Heaton, D. L. Hoffmann, A. G. Hogg, K. A. Hughen, K. F. Kaiser, B. Kromer, S. W. Manning, M. Niu, R. W. Reimer, D. A. Richards, E. M. Scott, J. R. Southon, R. Staff, C. S. M. Turney, and J. van der Plicht (2013), [IntCal13 and Marine13 Radiocarbon Age Calibration Curves 0-50,000 Years Cal BP](https://journals.uair.arizona.edu/index.php/radiocarbon/article/view/16947), *Radiocarbon*, 55(4), 1869–1887. 

Hogg, A. G., Q. Hua, P. G. Blackwell, M. Niu, C. E. Buck, T. P. Guilderson, T. J. Heaton, J. G. Palmer, P. J. Reimer, R. W. Reimer, C. S. M. Turney, and S. R. H. Zimmerman (2013), [SHCal13 Southern Hemisphere Calibration, 0–50,000 Years Cal BP](https://journals.uair.arizona.edu/index.php/radiocarbon/article/view/16783), *Radiocarbon*, 55(4), 1889–1903. 

Script uses the function `Multistart` which is part of the Global Optimization Toolbox available from [MathWorks](http://www.mathworks.com/products/global-optimization/)
