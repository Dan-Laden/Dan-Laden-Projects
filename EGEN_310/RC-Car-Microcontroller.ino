#include <ESP32Servo.h>
#include "BluetoothSerial.h"

Servo servoLeft;
Servo servoRight;
BluetoothSerial ESP_BT;

char state = 'k';
char speed = '1';
int turn = 25;
int speed = 25;
bool isReverse = false;

void setup() {

  servoLeft.attach(13);
  servoRight.attach(12);
  Serial.begin(9600);
  ESP_BT.begin("ESP32_RC_Car"); //name of the signal

  ////Telling servos to stop
  //  servoLeft.writeMicroseconds(1500);
  //  servoRight.writeMicroseconds(1500);

}

void loop() {

  //Start in a unmoving state
  state = 'k';

  //Wait for a command to be found
  while(!ESP_BT.available()){
    delay(5);
    }
  if(ESP_BT.available()){
    state = ESP_BT.read();
  }

  //Speed controlling 1-slowest 3-fastest
  if (state == "1") {
    speed = 25;
  }
  else if (state == "2"){
    speed = 50;
  }
  else if (state == "3"){
    speed = 75;
  }
  //Reverse command to issue the car controls to be inverted
  else if (state == "r"){
    if(isReverse){
      isReverse = false;
    }
    else{
      isReverse = true;
    }
  }

  //If car is reveresed, invert controls to keep forward being forward
  if (isReverse && speed>0){
    speed = -speed;
    turn = -turn;
  }
  else if (!isReverse && speed<0{
    speed = -speed;
    turn = -turn;
  }

 if (state == 'w') {
  // move forward
  servoLeft.writeMicroseconds(1500+speed);
  servoRight.writeMicroseconds(1500-speed);
  delay(10);
  }
 else if (state == 's') {
  // move backwards
  servoLeft.writeMicroseconds(1500-speed);
  servoRight.writeMicroseconds(1500+speed);
  delay(10);
  }
 else if (state == 'a') {
  // move left
  servoLeft.writeMicroseconds(1500-turn);
  servoRight.writeMicroseconds(1500-turn);
  delay(10);
  }
  else if (state == 'd') {
  // move right
  servoLeft.writeMicroseconds(1500+turn);
  servoRight.writeMicroseconds(1500+turn);
  delay(10);
  }
  else if (state == 'k') {
   // stop moving
  servoLeft.writeMicroseconds(1500);
  servoRight.writeMicroseconds(1500);
  delay(10);
  }
//
}
