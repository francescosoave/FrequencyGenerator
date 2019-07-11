import processing.sound.*;

PFont font;
int freq = 0;
float drawFixed = 0.0;
float fixedFreq = 0.0;
float maxFreq = 1000;

Container topBar, intBar, freqBar, bottomBar;

Button btnsIntensity[] = new Button[11];
Button btnsFreqRange[] = new Button[3];
Button btnsOscType[] = new Button[4];
Button btnMain;
String oscNames[] = {"Sin","Sqr","Tri","Saw" };
Oscillator oscList[] = {new SinOsc(this), new SqrOsc(this), new TriOsc(this), new SawOsc(this)};
Boolean btnActive = false;

void setup()
{
  size(800,600);
  background(0);
  font = createFont("Arial",16,true);
  textFont(font,24);
  
  topBar =  new Container(CENTER, width, 50);
  intBar =  new Container(CENTER, width, 30);
  freqBar =  new Container(CENTER, width, height-130);
  bottomBar =  new Container(CENTER, width, 50);
  
  for(int i = 0; i<= 10; i++)
    btnsIntensity[i] = new Button(50, 20);
  
  for(int i = 0; i< 3; i++)
    btnsFreqRange[i] = new Button(75, 30);
  
  for(int i = 0; i< 4; i++){
    btnsOscType[i] = new Button(65, 30);
    oscList[i].freq(freq); //set initial frequency to 0
    oscList[i].stop(); //make sure no osc is playing
  }
  
  btnsIntensity[5].btnSetActive();
  btnsFreqRange[1].btnSetActive();   
}

void draw()
{  
  background(0);
  strokeCap(SQUARE);
  textAlign(CENTER, CENTER);   
  
  //Containers
  topBar.cSetAppearance(200);
  topBar.cDisplay(width/2, topBar.cGetHeight()/2);
  
  intBar.cSetAppearance(254);
  intBar.cDisplay(width/2, topBar.cGetHeight()+intBar.cGetHeight()/2);
    
  freqBar.cSetAppearance(3);
  freqBar.cDisplay(width/2, topBar.cGetHeight()+intBar.cGetHeight()+freqBar.cGetHeight()/2);
   
  bottomBar.cSetAppearance(254);
  bottomBar.cDisplay(width/2, topBar.cGetHeight()+intBar.cGetHeight()+freqBar.cGetHeight()+bottomBar.cGetHeight()/2);
  
  //Frequency selection line
  if(freqBar.cHover()){
    stroke(100);
    strokeWeight(2);
    line(mouseX, topBar.cGetHeight()+intBar.cGetHeight()+1, mouseX, height-bottomBar.cGetHeight()-2);
  }
  
  //Frequency map
  freq = (int) map(mouseX, 0.0, width, 0.0, maxFreq);
  
  //Frequency range buttons  
  for(int i=0; i<3; i++){
    btnsFreqRange[i].btnSetAppearance(color(150,(180+(i*(160/3))),50)); 
    btnsFreqRange[i].btnDisplay((width/2-btnsFreqRange[i].btnGetWidth()) + ((i+1) * 100)+100, height-25);
    btnsFreqRange[i].btnText(16, 0, Integer.toString(500*(i+1)));   
    btnsFreqRange[i].btnSetVal(500*(i+1));
  }
  
  //Intensity buttons  
  for(int i=0; i<=10; i++){
    if(i==0)
      btnsIntensity[i].btnSetAppearance(color(250,150,50));
    else if(i==10)
      btnsIntensity[i].btnSetAppearance(color(50, 150, 150));
    else
      btnsIntensity[i].btnSetAppearance(color(250, 250, 50));
      
    btnsIntensity[i].btnDisplay(65*(i+1), 65);
    btnsIntensity[i].btnText(16, 0, Integer.toString(i));
    btnsIntensity[i].btnSetVal(i);
  }
  
  //Oscillator type buttons  
  for(int i=0; i<4; i++){
    if(i==0)
      btnsOscType[i].btnSetAppearance(color(#FFCEEF));
    else if(i==1)
      btnsOscType[i].btnSetAppearance(color(#FFADE4));
    else if(i==2)
      btnsOscType[i].btnSetAppearance(color(#FF86D7));
    else
      btnsOscType[i].btnSetAppearance(color(#FF58C8));
      
    btnsOscType[i].btnDisplay((btnsOscType[i].btnGetWidth()) + ((i+1) * 100)-100, height-25);
    btnsOscType[i].btnText(16, 0, oscNames[i]);
    btnsOscType[i].btnSetVal(500*(i+1));
  }
  
  //Current frequency text
  textFont(font, 196);
  fill(100,100,100,150);
  if(mouseX >=0 && mouseX <= width && mouseY >= 80 && mouseY <= height-50)
    text(freq, width/2, height/2);
  
  //Selected frequency text
  textFont(font, 24);
  fill(255,0,0);
  text((int)map(drawFixed,0,width,0,maxFreq), width/2, 25);
  
  //Selected frequency line
  stroke(255);
  line(drawFixed, 80, drawFixed, height-50);
}

void mouseClicked(){

 //select freq and set it
 if(mouseX >=0 && mouseX <= width && mouseY >= 80 && mouseY <= height-50){
   for(int i = 0; i< 4; i++)
    oscList[i].freq(freq);

   drawFixed = mouseX;
 }
 
  //check if any btn ( OF RANGE ) was clicked
  int thisone = -1;
  for (int i=0; i<3; i++)
    if (btnsFreqRange[i].btnHover())
      thisone = i;
      
  if (thisone > -1 ) {
    for (int i=0; i<3; i++) {
      if (thisone == i) {
        maxFreq = btnsFreqRange[i].btnGetVal();
        btnsFreqRange[i].btnSetActive();
      } else
        btnsFreqRange[i].btnSetInactive();
    }
  }

  //check if any btn ( OF INTENSITY ) was clicked
  thisone = -1;
  for (int i=0; i<=10; i++)
    if (btnsIntensity[i].btnHover())
      thisone = i;
      
  if (thisone > -1) {
    for (int i=0; i<=10; i++) {
      if (thisone == i) {
        for(int j = 0; j< 4; j++)
          oscList[j].amp(float(btnsIntensity[i].btnGetVal()) / 10);
          
        btnsIntensity[i].btnSetActive();
      } else
        btnsIntensity[i].btnSetInactive();
    }
  }
  
  //check if any btn ( OF OSC ) was clicked
  thisone = -1;
  for (int i=0; i<4; i++)
    if (btnsOscType[i].btnHover())
      thisone = i;
      
  if (thisone > -1) {
    for (int i=0; i<4; i++) {
      if (thisone == i) {
        btnsOscType[i].btnSetActive();
        oscList[i].play();
      } else{
        btnsOscType[i].btnSetInactive();
        oscList[i].stop();
      }
    }
  }
  
}
