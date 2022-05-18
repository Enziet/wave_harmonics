import g4p_controls.*;

/* File: codename:program (actual name still tbd... I want this community driven)
   Author: Enziet (enziet@gmail.com)
   Date: 10 May, 2022
   Version: a.0.0-unreleased
   
   Description: 
   A simple script to discover how wave harmonics can create amazing patterns. A lot of the patterns
   will be noisy, but finding harmonics is the name of the game! There are 3 variables the user can control:
   frequency(f), wavelength(w), and divisor(i). Frequency and wavelength are 32-bit floating point numbers,
   so their value can get fairly high, and the divisor is capped between 128 and 1,920,000,000, in increments
   of 128. (44 and its multiples are very interesting wavelengths!)
   
   Controls:
   ` = return to previous frequency
   1-0 = frequency presets: 1 = 100, 2 = 200, etc...
   spacebar = pause/unpause update
   up/down = increase/decrease increment
   scrollWheel = increase/decrease wavelength
   shift + scrollWheel = increase/decrease frequency
   
   TODO:
   graphical UI for visual navigation through control variables, presets, other settings
   presets for wavelength and increment
   ability to bookmark current frequency/wavelength/increment combo
   ability to customize presets
   ability to customize hotkeys
   ability to take screenshots and record short gifs
   ability to scale frequency/wavelength increment amount (100, 10, 1, 0.1, 0.01, etc.)
*/

// system variables
int gridSize = 128; // gridSize is the scalar for each 'pixel'; 128 makes them 1/128th of the program width
int presetCnt = 10; // number of presets (10 because I use 1-0 on the keyboard for hotkeys)
boolean drawStats = true; // controls drawing overlay
boolean pause = false; // controls pause state of wave udates
boolean mod = false; // tracks if shift is held down

// wave control variables
float frequency  = 100;
float wavelength = 1;
int i_scalar = 128;
float inc = TWO_PI/i_scalar; // time increment (slice up the unit circle into i_scalar pieces)
int c = 299999999;

// data variables
int presets[]; // list of presets
float grid[][]; // 2D pixel matrix
float a = 0.0; // current time (for wave functions)
int presetNum = 0; // holds current preset #
float previous; // stores previous frequency before preset change

void setup() {
  size(768, 768); // should be square, and preferably a multiple of gridSize
  frameRate(29.9);
  background(0);
  noSmooth(); // is this needed?
  noStroke();
  textSize(10);
  
  previous = frequency; // default previous frequency value is current value
  
  // initiate presets
  presets = new int[presetCnt];
  for(int b=0; b<presetCnt; b++) {
    presets[b] = (b+1)*100; // set presets 100-1000
  }
  
  // initiate pixel grid (default sets all to 0, aka black)
  grid = new float[gridSize][gridSize];
  for(int x=0; x<gridSize; x++) {
    for(int y=0; y<gridSize; y++) { 
      grid[x][y] = 0; // can replace 0 with any fun equation and draw a nice picture; make sure pause is on by default
    }
  }
}

void draw() {
  // keeping track of time this way seems to be very unforgiving; I prefer using the unit circle
  int m = millis();
  
  // loop through the grid and perform work on each pixel
  for(int x=0; x<gridSize; x++) {
    for(int y=0; y<gridSize; y++) {
      float col = grid[x][y]; // store the current color before modification
      
      // only update pixel if paused
      if(!pause) {
        // increment time
        a += inc;
        if(a >= TWO_PI) a -= TWO_PI; // make sure a stays between 0 and TWO_PI

        //todo: I orinigally wanted to add some sort of responsivity reactions (like conway's game of life)
        //float col_top = (y-1 > 0) ? grid[x][y-1] : 255;
        //float col_bot = (y+1 < gridSize) ? grid[x][y+1] : 255;
        //float col_left = (x-1 > 0) ? grid[x-1][y] : 255;
        //float col_right = (x+1 < gridSize) ? grid[x+1][y] : 255;
        
        // todo: this wave function is extremely ripe with potential for additional variation and complication
        float a_x = cos(wavelength*x-a*frequency);
        float a_y = sin(wavelength*y-a*frequency);
        
        // default equation
        //col = 255*a_x - 255*a_y;
        
        // testing equation for working with euler's number (my favorite so far)
        //col = map(exp(a_x)+exp(a_y), exp(-2),exp(2), 0,255); 
        
        // testing equation for working with perlin noise
        col = 127*(a_x*noise(x)) + 127*(a_y*noise(y));
        
        //todo: for a color(), you can use red(),blue(),green() to extract the individual color values!
        
        // update the grid with the new color
        grid[x][y] = col;
      }
      
      // todo: offload drawing shapes to another object?
      // note: a grid of pixels is not the only way (nor is it likely the best way) to draw the wavefunction; try other ways?
      fill(col);
      square(map(x, 0,gridSize, 0,width), map(y, 0,gridSize, 0,height), width/gridSize);
   }
 }
 
 // draw the stats overlay so we can track the control variables
 if(drawStats) {
    fill(0);
    rect(0,0, width,18); // draw a black background behind so the text is legible
    fill(255);
    text("f: "+frequency+", w: "+wavelength+", i: "+i_scalar+", a: "+a, 8, 12);
  }
}

void keyPressed() {
  switch(key) {
    case CODED:
      switch(keyCode) {
        // mod control
        case SHIFT:
          mod = true;
          break;
      }
  }
}

void keyReleased() {
  switch(key) {
    // presets switch; there is probably a better way to do this....
    case '`':
      presetNum = 0;
      frequency = previous;
      break;
    case '1':
      previous = frequency;
      frequency = presets[0];
      break;
    case '2':
      previous = frequency;
      frequency = presets[1];
      break;
    case '3':
      previous = frequency;
      frequency = presets[2];
      break;
    case '4':
      previous = frequency;
      frequency = presets[3];
      break;
    case '5':
      previous = frequency;
      frequency = presets[4];
      break;
    case '6':
      previous = frequency;
      frequency = presets[5];
      break;
    case '7':
      previous = frequency;
      frequency = presets[6];
      break;
    case '8':
      previous = frequency;
      frequency = presets[7];
      break;
    case '9':
      previous = frequency;
      frequency = presets[8];
      break;
    case '0':
      previous = frequency;
      frequency = presets[9];
      break;
   
    // hotkey for drawing stats
    case 'p': 
    case 'P':
      drawStats = !drawStats;
      break;
    
    // spacebar for pausing (yes, spacebar is an empty space character)
    case ' ': 
      pause = !pause;
      break;
    
    case CODED:
      switch(keyCode) {
        // increment control
        case UP:
          i_scalar += 128;
          if(i_scalar > 1920000000) i_scalar = 1920000000; // prevent overflow
          inc = TWO_PI/i_scalar;
          break;
        case DOWN:
          i_scalar -= 128;
          if(i_scalar < gridSize) i_scalar = gridSize; // prevent scalar below gridSize
          inc = TWO_PI/i_scalar;
          break;
        
        // mod control
        case SHIFT:
          mod = false;
          break;
      }
  }
}

void mouseWheel(MouseEvent e) {
  float c_val = -(e.getCount()); // invert; I want scrolling away to cause an increase
  
  // mod controls which of wavelength/frequency get modified
  if(!mod)
    wavelength += c_val;
  else
    frequency += c_val;

  // cap these at 0, negative values do produce results but its a mirror image of the absolute value anyways
  if(wavelength < 0f) wavelength = 0f;
  if(frequency < 0f) frequency = 0f;
}
