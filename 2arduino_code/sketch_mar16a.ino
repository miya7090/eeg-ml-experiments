#include <SoftwareSerial.h>

/*
  Sending Data to Processing via the Serial Port

  Hardware:
  Sensors connected to Arduino input pins
  Arduino connected to computer via USB cord

*/

/*Declare your sensor pins as variables. Pro tip: If you're pressed for memory, use #define to declare your sensor pins without using any memory. Just be careful that your pin name shows up NOWHERE ELSE in your sketch!
  for more info, see: http://arduino.cc/en/Reference/Define
*/
int sensor1Pin = 0;
int sensor2Pin = 1;
int sensor3Pin = 2;

/*Create an array to store sensor values. I'm using floats. Customize the array's size to be equal to your number of sensors.
*/
float sensorVal[] = {0, 0, 0};

void setup() {
  Serial.begin(4800); //This line tells the Serial port to begin communicating at 9600 bauds
}

void loop() {
  //read each sensor value: assuming analog values
  sensorVal[0] = analogRead(sensor1Pin);
  sensorVal[1] = analogRead(sensor2Pin);
  sensorVal[2] = analogRead(sensor3Pin);

  //print over the serial line in a regular format, will be read in Processing
  //separates loop cycles with newlines, and values with commas
  Serial.print(sensorVal[0]);
  Serial.print(",");
  Serial.print(sensorVal[1]);
  Serial.print(",");
  Serial.println(sensorVal[2]);
  delay(100);
}
