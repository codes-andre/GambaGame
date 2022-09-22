class Bullet extends BaseEnemyObject { 
  private float x;
  private float y;
  private float size = 15;
  private float dx = 0;

  private float vel = 100;
  
  Bullet(float x, float y){
    this.x = x;
    this.y = y;
  }
  
  // BaseEnemyObject
  
  void update(float elapsedTime) {
    dx += vel * elapsedTime;
 
    if (dx > 200) {
      isAlive = false;
    }
  }

  void render() {
    rect(x + dx, y, size, size);
  }

  Boolean isCollision(float x, float y) {
    float dx_x = this.x + dx;
    return (x > dx_x && x < dx_x + this.size && y > this.y && y < this.y + this.size);
  }

  ArrayList<BaseEnemyObject> getChildren() {
    return new ArrayList<>();
  }
}
