class Button{
  
  private int btnWidth;
  private int btnHeight;
  private int xPos;
  private int yPos;
  private int val;
  private Boolean btnActive;
  
  Button(int btnWidth, int btnHeight){
    this.btnWidth = btnWidth;
    this.btnHeight = btnHeight;
    this.xPos = width/2;
    this.yPos = height/2;
    this.btnActive = false;
  }
  
  public void btnSetAppearance(int strokeWeight, int strokeCol, int fillCol){
    strokeWeight(strokeWeight);
    stroke(strokeCol);
    fill(fillCol);
  }
  
  public void btnSetAppearance(int fillCol){
    noStroke();
    fill(fillCol);
  }
  
  public void btnDisplay(int xPos, int yPos){
    this.xPos = xPos;
    this.yPos = yPos;
    rectMode(CENTER);
    rect(this.xPos, this.yPos, this.btnWidth, this.btnHeight);
    
    if(this.btnActive){
      stroke(255,0,0);
      strokeWeight(2);
      line((this.xPos - this.btnWidth/2)-1, (this.yPos + this.btnHeight/2), (this.xPos + this.btnWidth/2), (this.yPos + this.btnHeight/2));
    }
  }
  
  public void btnDisplay(){
    rectMode(CENTER);
    rect(this.xPos, this.yPos, btnWidth, btnHeight);
  }
  
  public void btnText(int fontSize, color fillCol, String text, int xPos, int yPos){
    fill(fillCol);
    textFont(font, fontSize);
    text(text, xPos, yPos);
  }
  
  public void btnText(int fontSize, color fillCol, String text){
    fill(fillCol);
    textFont(font, fontSize);
    text(text, this.xPos, this.yPos-2);
  }
  
  public void btnSetVal(int val){
    this.val = val;
  }
  
  public int btnGetVal(){
    return this.val;
  }
  
  public int btnGetWidth(){
    return this.btnWidth;
  }
  
  public int btnGetHeight(){
    return this.btnHeight;
  }
  
  public void btnSetActive(){
    this.btnActive = true;
  }
  
  public void btnSetInactive(){
    this.btnActive = false;
  }
  
  public Boolean btnHover(){
    if(mouseX >= (this.xPos - this.btnWidth/2) && mouseX <= (this.xPos + this.btnWidth/2)
      && mouseY >= (this.yPos - this.btnHeight/2) && mouseY <= (this.yPos + this.btnHeight/2))
        return true;
        
    return false;
  }

}
