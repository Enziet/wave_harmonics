# wave_harmonics
Simple Processing program to explore two-dimensional wave harmonics.

----
## Author

Enziet (enziet@gmail.com)


## Description

A simple script to discover how wave harmonics can create amazing patterns. A lot of the patterns
will be noisy, but finding harmonics is the name of the game! There are 3 variables the user can control:
frequency(f), wavelength(w), and divisor(i). Frequency and wavelength are 32-bit floating point numbers,
so their value can get fairly high, and the divisor is capped between 128 and 1,920,000,000, in increments
of 128. (44 and its multiples are very interesting wavelengths!)


## Controls:

- ` = return to previous frequency
- 1-0 = frequency presets: 1 = 100, 2 = 200, etc...
- spacebar = pause/unpause update
- up/down = increase/decrease increment
- scrollWheel = increase/decrease wavelength
- shift + scrollWheel = increase/decrease frequency


## TODO:

- [ ] graphical UI for visual navigation through control variables, presets, other settings
- [ ] presets for wavelength and increment
- [ ] ability to bookmark current frequency/wavelength/increment combo
- [ ] ability to customize presets
- [ ] ability to customize hotkeys
- [ ] ability to take screenshots and record short gifs
- [ ] ability to scale frequency/wavelength increment amount (100, 10, 1, 0.1, 0.01, etc.)
