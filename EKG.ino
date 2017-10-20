/* Arduino Nano based EKG monitor.
 *
 * EKG module AD8232) - Adruino Nano
 * =================================
 * GND - GND
 * 3.3V - 5V
 * OUTPUT - A1
 * LO- - D11
 * LO+ - D10
 * SDN  not connected
 * 
 * Electrodes:
 * - red R = RA (right arm)
 * - green R = LA (left arm)
 * - yellow L = RL (right leg)
*/

void setup() {
  pinMode(10,INPUT);
  pinMode(11,INPUT);
  Serial.begin(9600);
}

void loop() {
  if ((digitalRead(10)==1)||(digitalRead(11)==1)) {
    Serial.println("no valid data");
  }
  else {
    Serial.println(analogRead(A1));
  }
  //delay(10);
}


