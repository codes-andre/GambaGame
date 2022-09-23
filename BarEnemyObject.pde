class BarEnemyObject extends BaseEnemyObject {
  private float x;
  private float y;
  private float w;
  private float h;
  
  private float count = 0;
  
  private ArrayList<BaseEnemyObject> children = new ArrayList<>();

  BarEnemyObject(float x, float y, float w, float h){
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
  }

  // GameObject
  
  void update(float elapsedTime) {
 
    count += elapsedTime * 30;
    
    if (count > 60) {
      children.add(new Bullet(x + w, y));
      count = 0;
    }
    
    updateChildren();
  }

  void render() {
    rect(x, y, w, h);
  }
  
  Image getImage() {
    return new Image(loadImage("pew.png"), x, y, w, h);
  }
  
  // BaseEnemyObject
  
  Boolean isCollision(float x, float y) {
    return (x > this.x && x < this.x + this.w && y > this.y && y < this.y + this.h);
  }
  
  ArrayList<BaseEnemyObject> getChildren() {
    return children;
  }
  
  // Private Methods
  
  private void updateChildren() {
  ArrayList<BaseEnemyObject> toRemove = new ArrayList<>();
  ArrayList<BaseEnemyObject> toInsert = new ArrayList<>();
  
  for(BaseEnemyObject child: children) {
    if (child.isAlive) {
      if (!children.contains(child)) {
        toInsert.add(child);
      }
    } else {
      toRemove.add(child);
    }
  }
  
  for(BaseEnemyObject child: toRemove) {
    children.remove(child);
  }
 
   for(BaseEnemyObject child: toInsert) {
    children.add(child);
  }
}
}
