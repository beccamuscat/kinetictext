/*

This code displays a visual representation of words using a character-index mapping.
The user can input characters which will be translated into words on the screen.
The visual display is created using a PGraphics object with a tiled effect.
*/
// Import the necessary libraries
import processing.core.*;

// Declare global variables
PFont font; // Font for displaying the words
PGraphics pg; // PGraphics object for creating the visual display
String[] words = {"ordinary", "heroes"}; // Array of words to be displayed
String input = ""; // User input string

// Mapping of characters to their corresponding indices
HashMap<Character, Integer> charIndexMap;

void setup() {
  // Initialize the font and PGraphics object
  font = createFont("RobotoMono-Light.ttf", 100);
  size(400, 1000, P2D);
  pg = createGraphics(400, 1000, P2D);

  // Initialize the character-index mapping
  charIndexMap = new HashMap<Character, Integer>();

  // Populate the character-index mapping
  for (int i = 0; i < words.length; i++) {
    String word = words[i];
    char firstChar = Character.toLowerCase(word.charAt(0));
    charIndexMap.put(firstChar, i);
  }
}

void draw() {
  // Set a transparent background
  background(0, 0);

  // Draw on the PGraphics object
  pg.beginDraw();
  pg.background(0, 0); // Transparent background
  pg.fill(255); // White text
  pg.textFont(font);
  pg.textSize(75);
  pg.pushMatrix();
  pg.translate(width/2, height/2-215);
  pg.textAlign(CENTER, CENTER);

  // Display the word corresponding to each letter
  for (int i = 0; i < input.length(); i++) {
    char letter = Character.toLowerCase(input.charAt(i));
    if (charIndexMap.containsKey(letter)) {
      int index = charIndexMap.get(letter);
      pg.text(words[index], i * 70, 0);
    }
  }

  pg.popMatrix();
  pg.endDraw();

  // Create a tiled effect using the PGraphics object
  int tilesX = 16;
  int tilesY = 16;

  int tileW = int(width/tilesX);
  int tileH = int(height/tilesY);

  for (int y = 0; y < tilesY; y++) {
    for (int x = 0; x < tilesX; x++) {

      // WARP
      int wave = int(sin(frameCount * 0.05 + (x * y) * 0.07) * 100);

      // SOURCE
      int sx = x*tileW + wave;
      int sy = y*tileH;
      int sw = tileW;
      int sh = tileH;

      // DESTINATION
      int dx = x*tileW;
      int dy = y*tileH;
      int dw = tileW;
      int dh = tileH;

      // Copy the specified portion of the PGraphics object to the main canvas
      copy(pg, sx, sy, sw, sh, dx, dy, dw, dh);
    }
  }
}

void keyPressed() {
  // Add the pressed character to the input string
  if (key != CODED) {
    input += Character.toLowerCase(key);
  }
}

void keyReleased() {
  // Remove the released character from the input string
  if (key != CODED) {
    input = input.substring(0, input.length() - 1);
  }
}
