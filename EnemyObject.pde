interface EnemyObject extends GameObject {

  Boolean isCollision(float x, float y);
  ArrayList<BaseEnemyObject> getChildren();
}
