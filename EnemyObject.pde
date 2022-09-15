interface EnemyObject extends GameObject {

  Boolean isCollision(float x, float y);
  ArrayList<BaseEnemyObject> getChildren();
}

abstract class BaseEnemyObject implements EnemyObject {

  Boolean isAlive = true; 
}
