class Container{
  
  private int cWidth;
  private int cHeight;
  private int xPos;
  private int yPos;
  private int cMode;
  
  public Container(int cMode, int cWidth, int cHeight){
    this.cMode = cMode;
    this.cWidth = cWidth;
    this.cHeight = cHeight;
    this.xPos = width/2;
    this.yPos = height/2;
  }
  
  public void cSetAppearance(int strokeWeight, int strokeCol, int fillCol){
    strokeWeight(strokeWeight);
    stroke(strokeCol);
    fill(fillCol);
  }
  
  public void cSetAppearance(int fillCol){
    noStroke();
    fill(fillCol);
  }
  
  public void cDisplay(int xPos, int yPos){
    rectMode(this.cMode);
    this.xPos = xPos;
    this.yPos = yPos;
    rect(this.xPos, this.yPos, this.cWidth, this.cHeight);
  }
  
  public void cDisplay(){
    rectMode(CENTER);
    rect(this.xPos, this.yPos, this.cWidth, this.cHeight);
  }
  
  public int cGetWidth(){
    return this.cWidth;
  }
  
  public int cGetHeight(){
    return this.cHeight;
  }
  
  public Boolean cHover(){
    if(mouseX >= (this.xPos - this.cWidth/2) && mouseX <= (this.xPos + this.cWidth/2)
      && mouseY >= (this.yPos - this.cHeight/2) && mouseY <= (this.yPos + this.cHeight/2))
        return true;
        
    return false;
  }
  
}
