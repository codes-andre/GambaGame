class BarMovimentEnemyObject extends BaseEnemyObject {
  
  private float dx = 0;
  private float dy = 0;
  private float shift = 100;
  private float direcaoX = 1;
  private float vel = 50;
  MovimentDirection direction;
  
  private float x;
  private float y;
  private float w;
  private float h;
  
  private ArrayList<BaseEnemyObject> children = new ArrayList<>();

  BarMovimentEnemyObject(float x, float y, float w, float h, MovimentDirection direction){
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.direction = direction;
  }

  // GameObject
  
  void update(float elapsedTime) {
 
    switch(direction) {
    case HORIZONTAL:
      dx += elapsedTime * direcaoX * vel;
      
      if (dx > shift) {
        direcaoX = -1;
      }
      
      if (dx < 0) {
        direcaoX = 1;
      }
      
      break;
    case VERTICAL: break;
    }
  }

  void render() {
    rect(x + dx, y + dy, w, h);
  }
  
  Image getImage() {
    return new Image(loadImage("pew.png"), x + dx, y + dy, w, h);
  }
  
  // BaseEnemyObject
  
  Boolean isCollision(float x, float y) {
    return (x > realX() && x < realX() + this.w && y > this.y && y < this.y + this.h);
  }
  
  ArrayList<BaseEnemyObject> getChildren() {
    return children;
  }
  
  // Private Methods
  
  private float realX() {
    return x + dx;
  }
}
