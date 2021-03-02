// Fabián Alfonso Beirutti Pérez
// 2021 - CIU

PImage image;
PShape shape;

ArrayList<Point> points;
boolean menu, sketchMode, modelMode, keyStatus;

Point currentPoint, lastPoint;
Model model;

void setup() {
  surface.setTitle("Solid of revolution");
  size(800, 600, P3D);
  stroke(95, 230, 255);
  image = loadImage("Captura.JPG");
  points = new ArrayList();
  menu = true;
  sketchMode = false;
  modelMode = false;
  model = new Model();
}

void draw() {
  if (menu) menu();
  if (modelMode) {
    pushMatrix();
    background(0);
    showHelp();
    translate(mouseX, mouseY-150, -300);
    shape(shape);
    model.rotateModel();
    popMatrix();
  }
}

// Initial screen
void menu() {
  keyStatus = false;
  background(0);
  textSize(50);
  textAlign(CENTER);
  fill(255);
  text("Solid of Revolution", 400,100);
  text("3D model", 400,150);
  textSize(25);
  text("by Fabián B.", 400, 200);
  image(image, 250, 220, 300, 300);
  text("Press ENTER to continue", 400, 550);
}

// Display help
void showHelp() {
  if (sketchMode) {
    textAlign(LEFT);
    textSize(15);
    text("> Left click on the right side to draw desired shape.", 10, 50);
    text("> Right click to display 3D model of the sketch.", 10, 100);
  }
  if (modelMode) {
    textAlign(LEFT);
    text("> Move the mouse to move the 3D model.", 20, 50);
    text("> W A S D keys to rotate 3D model.", 20, 500);
    text("> C key to change color.", 20, 550);
    text("> Press R key to restart.", 20, 100);
  }
}

// Reset all to draw a new sketch
void restart() {
  points.clear();
  currentPoint = null;
  lastPoint = null;
  menu = false;
  sketchMode = true;
  modelMode = false;
  background(0);
  centerLine();
  showHelp();
}

void drawLine() {
  if (lastPoint == null)
    lastPoint = currentPoint;  
  else {
    line(lastPoint.x, lastPoint.y, currentPoint.x, currentPoint.y);
    lastPoint = currentPoint;    
  }
}

void centerLine() {
  stroke(95, 230, 255);
  strokeWeight(2);
  line(width/2, 0, width/2, height);
}

void keyPressed() {
  if (keyCode == ENTER) restart();
  if (key == 'R' || key == 'r') restart();
  if ((key == 'C' || key == 'c') && modelMode) model.changeColor();
  
  keyStatus = true;
  if (key == 'W' || key == 'w') model.up = keyStatus;
  if (key == 'S' || key == 's') model.down = keyStatus;
  if (key == 'A' || key == 'a') model.left = keyStatus;
  if (key == 'D' || key == 'd') model.right = keyStatus;
}

void keyReleased() {
  keyStatus = false;
  if (key == 'W' || key == 'w') model.up = keyStatus;
  if (key == 'S' || key == 's') model.down = keyStatus;
  if (key == 'A' || key == 'a') model.left = keyStatus;
  if (key == 'D' || key == 'd') model.right = keyStatus;
}

void mouseClicked() {
  if (menu) return;
  if (mouseX > width/2 && sketchMode) {
    currentPoint = new Point(mouseX, mouseY, 0);
    drawLine();
    points.add(new Point(currentPoint.x - width / 2, currentPoint.y - height / 2, 0));
  }
  if (mouseButton == RIGHT && sketchMode && points.size() >= 2) {
    sketchMode = false;
    model.showModel(points);
    shape = model.getModel();
    modelMode = true;
  }
}
