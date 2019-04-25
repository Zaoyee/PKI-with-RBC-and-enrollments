#include <TrueRandom.h>
#define BINS_SIZE 256
#define CALIBRATION_SIZE 50000

#define NO_BIAS_REMOVAL 0
#define EXCLUSIVE_OR 1
#define VON_NEUMANN 2

#define ASCII_BYTE 0
#define BINARY 1
#define ASCII_BOOL 2

/***  Configure the RNG **************/
int bias_removal = NO_BIAS_REMOVAL;
int output_format = BINARY;
int baud_rate = 19200;
/*************************************/


unsigned int bins[BINS_SIZE];
int adc_pin = 0;
int led_pin = 13;
boolean initializing = true;
unsigned int calibration_counter = 0;


void setup()
{
  Serial.begin(baud_rate);
  pinMode(led_pin, OUTPUT);
  for (int i = 0; i < BINS_SIZE; i++) {
    bins[i] = 0;
  }
}

void loop()
{
  if (Serial.available() > 0) {
    String data = Serial.readString();
    if (Serial.readString()) {
      if (data == "2")
      {
        uint8_t const *p;
        uint8_t i;
        p = 2048;
        i = 0;
        int lineNum = 0;
        while ((i < 32) && (lineNum < 16))
        {
          Serial.print(*p, HEX);
          Serial.print(' ');

          i++;
          p++;
          if (i == 32)
          {
            Serial.println();
            i = 0;
            lineNum++;
          }
        }
      } else if (data == "1")
      {
        int times = 0;
//        double value;
        int value;
        while(times < 256){
          value = TrueRandom.randomBit();
          Serial.print(value);
          times++;
        }
        Serial.println();
        times = 0;
        while(times < 256){
          value = TrueRandom.randomBit();
          Serial.print(value);
          times++;
        }
//
//        while (times < 256) {
//          double value = analogRead(0);
//          delay(1);
//          if (value > 38.5)
//            Serial.print(1);
//          else
//            Serial.print(0);
//          times++;
//        }
//        Serial.println();
//        times = 0;
//        while (times < 256) {
//          double value = analogRead(0);
//          delay(1);
//          if (value > 38.5)
//            Serial.print(1);
//          else
//            Serial.print(0);
//          times++;
//        }

      }
    }
  }
}
