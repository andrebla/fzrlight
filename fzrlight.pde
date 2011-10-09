// Adalight modification using 74HC595 shiftregisters and ShiftPWM library
// Original project by Ladyada - http://www.ladyada.net/make/adalight/
// ShiftPWM library by Elco Jacobs - http://www.elcojacobs.com/shiftpwm/
// FZRLight by Andre Aureliano - http://www.fiozera.com.br/blog/
// Arduino Duemilanove Code

#include <SPI.h>

//Data pin is MOSI - pin 11 arduino duemilanove 
//Clock pin is SCK - pin 13 arduino duemilanove
const int ShiftPWM_latchPin = 8;
const bool ShiftPWM_invertOutputs = 0;

#include <ShiftPWM.h>

unsigned char maxBrightness = 255;
unsigned char pwmFrequency = 75;
int numRegisters = 10;

#define numLEDs 25

unsigned char red[numLEDs], green[numLEDs], blue[numLEDs];

byte head;
int state = 0;

byte buffer[76];

void setup()   {                
  pinMode(ShiftPWM_latchPin, OUTPUT);  
  SPI.setBitOrder(LSBFIRST);
  SPI.setClockDivider(SPI_CLOCK_DIV4); 
  SPI.begin(); 
  Serial.begin(115200);
  ShiftPWM.SetAmountOfRegisters(numRegisters);
  ShiftPWM.Start(pwmFrequency,maxBrightness);  
  head = (byte) 0x55;
}

void loop(){
  if (Serial.available()>0) {
    int input = Serial.read();
    switch (state) {
    case 0:
      if (input==head) {
        state = 1;
      }
      break;
    case 1:
    case 2:
    case 3:
    case 4:
    case 5:
    case 6:
    case 7:
    case 8:
    case 9:
    case 10:
    case 11:
    case 12:
    case 13:
    case 14:
    case 15:
    case 16:
    case 17:
    case 18:
    case 19:
    case 20:
    case 21:
    case 22:
    case 23:
    case 24:
    case 25:
    case 26:
    case 27:
    case 28:
    case 29:
    case 30:
    case 31:
    case 32:
    case 33:
    case 34:
    case 35:
    case 36:
    case 37:
    case 38:
    case 39:
    case 40:
    case 41:
    case 42:
    case 43:
    case 44:
    case 45:
    case 46:
    case 47:
    case 48:
    case 49:
    case 50:
    case 51:
    case 52:
    case 53:
    case 54:
    case 55:
    case 56:
    case 57:
    case 58:
    case 59:
    case 60:
    case 61:
    case 62:
    case 63:
    case 64:
    case 65:
    case 66:
    case 67:
    case 68:
    case 69:
    case 70:
    case 71:
    case 72:
    case 73:
    case 74:
      if((byte) input < 0) {
        buffer[state-1] = (byte) input + 256;
        state++;
        break;
      }
      else {
        buffer[state-1] = (byte) input;
        state++;
        break;
      }
    case 75:
      if((byte) input < 0) {
        buffer[state-1] = (byte) input + 256;
        state = 0;
        break;
      }
      else {
        buffer[state-1] = (byte) input;
        state = 0;
        break;
      }
    }
  }
  for(int led = 0; led < numLEDs; led++){
    ShiftPWM.SetGroupOf3(led, buffer[(3 * led) + 1], buffer[(3 * led) + 2], buffer[(3 * led) + 3]);
  }
}

