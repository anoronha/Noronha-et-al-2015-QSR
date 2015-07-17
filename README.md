# Noronha-et-al-2015-QSR
Matlab code from soil carbon model used in Noronha et al 2015 published in Quaternary Science Reviews

Main file is in file bombC.m, all other functions are called by this file.  File heshang.txt is the new data published in the QSR manuscript, and serves of an example of the input file required by the bombC.m.

Input file requires a three column matrix:

First column: calendar age of sample in Yr BP (BP = 1950)

Second column: a14C of sample in FM

Third column: 1 sigma error of a14C (FM) measurement

Uses the function Multistart which is part of the Global Optimization Toolbox available from MathWorks: http://www.mathworks.com/products/global-optimization/
