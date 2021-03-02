// Fabián Alfonso Beirutti Pérez
// 2021 - CIU

class Model {
  
  PShape model;
  boolean up, down, left, right;
  
  void showModel(ArrayList<Point> points) {
    
  int numberOfPoints = points.size();
  
    if (numberOfPoints >= 2) {
      int numberOfRotations = 45;
      int angle = 360 / numberOfRotations;
      float radians = angle * 3.141592 / 180;
      
      model = createShape();
      model.beginShape(TRIANGLE_STRIP);
      
      model.stroke(255);
      model.fill(95, 230, 255);
      model.strokeWeight(2);
      
      Point currentLevelPoint, nextLevelPoint;
      
      for (int i = 0; i < numberOfPoints - 1; i++) {
        
        currentLevelPoint = points.get(i);
        nextLevelPoint = points.get(i + 1);
        
        model.vertex(currentLevelPoint.x, currentLevelPoint.y, currentLevelPoint.z);
        model.vertex(nextLevelPoint.x, nextLevelPoint.y, nextLevelPoint.z);
        
        for (int j = angle; j <= 360; j += angle) {
          currentLevelPoint = points.get(i);
          currentLevelPoint = new Point(getNewX(currentLevelPoint, radians),
                                        currentLevelPoint.y,
                                        getNewZ(currentLevelPoint, radians));
          model.vertex(currentLevelPoint.x, currentLevelPoint.y, currentLevelPoint.z);
    
          nextLevelPoint = points.get(i + 1);
          nextLevelPoint = new Point(getNewX(nextLevelPoint, radians),
                                     nextLevelPoint.y,
                                     getNewZ(nextLevelPoint, radians));
          model.vertex(nextLevelPoint.x, nextLevelPoint.y, nextLevelPoint.z);
          
          radians = (angle + j) * 3.141592 / 180;
        }    
      }
      model.endShape();
    }
  }
  
  int getNewX(Point point, float radians) {
    return (int) (point.x * cos(radians) - point.z * sin(radians));
  }
  
  int getNewZ(Point point, float radians) {
    return (int) (point.x * sin(radians) + point.z * cos(radians));
  }
  
  PShape getModel() { 
    return model; 
  }
  
  void changeColor() {
    model.setFill(color(random(130,255), random(130,255), random(130,255)));
  }
  
  void rotateModel() {
    if (up) model.rotateX(-0.1);
    if (down) model.rotateX(0.1);
    if (left) model.rotateY(0.1);
    if (right) model.rotateY(-0.1);
  }
  
}
