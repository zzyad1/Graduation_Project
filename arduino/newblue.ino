#include <SoftwareSerial.h> 
#define echoPin 8 
#define trigPin 9

long duration; 
int distance; 

SoftwareSerial Car(2, 3);
int speed_limit[]={0,25,50,80,100,130,155,180,205,230};
int RWF=4;
int RWB=5;
int LWF=6;
int LWB=7;
int enA=10;
int enB=11;
int space;
int wheel_speed;
char order;
//founctions
void Forward();
void Backward();
void Right();
void Left();
void Stop();

void setup() {
  
  Serial.begin(9600);
  Car.begin(9600);
  
  pinMode(RWF, OUTPUT);
  pinMode(RWB, OUTPUT);
  
  pinMode(LWF, OUTPUT);
  pinMode(LWB, OUTPUT);

  pinMode(enA, OUTPUT);
  pinMode(enB, OUTPUT);

  pinMode(trigPin, OUTPUT);
  pinMode(echoPin, INPUT);


}

void loop() {
    
 
  while (Car.available()) {
    order = Car.read();
    
    
    if(order -'0'>=0 && order -'0'<=9 ){
    wheel_speed=((order-'0'));
    Serial.println(speed_limit[wheel_speed]);
   analogWrite(enA,speed_limit[wheel_speed] );
   analogWrite(enB, speed_limit[wheel_speed]);
  }
  else if(order=='q'){
    Serial.println(order);
    analogWrite(enA, 255);
   analogWrite(enB, 255);
  }
    
 if(order=='F'){
      while(order=='F' && cal_distance()>=30 )
      {
        
       Forward();
       if(Car.available()){
       order = Car.read();
       
       }

      }
      Stop();
      }

 if(order=='B'){
     while (order == 'B' ) {
        Serial.print(order);
       Backward();
      if(Car.available()){
       order = Car.read();
       Serial.print(order);
       }

      }
        Stop();
      }
if(order=='R'){

     while (order == 'R' ) {
        Serial.print(order);
     Right();
     if(Car.available()){
       order = Car.read();
       Serial.print(order);
       }

      }

        Stop();
}
if(order=='L'){
     while (order == 'L' ) {
        Serial.print(order);
     Left();
     if(Car.available()){
       order = Car.read();
       Serial.print(order);
       }


      }
      
        Stop();
      } 
     if (order == 'S') {
      Stop();
   
     }
  }
  
  
  delay(100);
  
}


void Forward(){
   digitalWrite(RWF, HIGH);
  digitalWrite(LWF, HIGH);
  delay(100);
 
}
void Backward(){
   digitalWrite(RWB, HIGH);
     digitalWrite(LWB, HIGH);
     delay(100);
     Stop();
  }
void Right(){
  digitalWrite(RWB, HIGH);
  digitalWrite(LWF, HIGH);
       delay(100);
       Stop();
}
void Left(){
  digitalWrite(RWF, HIGH);
  digitalWrite(LWB, HIGH);
   delay(100);
   Stop();
  }
void Stop(){
       digitalWrite(RWF, LOW);
       digitalWrite(RWB, LOW);
       digitalWrite(LWF, LOW);
       digitalWrite(LWB, LOW);
  }
  
int cal_distance(){
  digitalWrite(trigPin, LOW);//clear echo
  delayMicroseconds(2);

   digitalWrite(trigPin, HIGH);
  delayMicroseconds(10);
  digitalWrite(trigPin, LOW);
   duration = pulseIn(echoPin, HIGH);
   distance = duration * 0.034 / 2;

   return distance;
  
  }
