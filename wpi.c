#include <stdio.h>
#include <string.h>
#include <errno.h>
#include <stdlib.h>
#include <wiringPi.h>

// Button connected to PA8, ie. Physical OPi-pin 31                    
#define BUTTON_PIN 8

// the event counter
volatile int eventCounter = 0;

// -------------------------------------------------------------------------

void myInterrupt(void) {
  eventCounter++;
}

// -------------------------------------------------------------------------

int main(void) {

  // sets up the wiringPi library
  if (wiringPiSetup () < 0) {
    fprintf (stderr, "Unable to setup wiringPi: %s\n", strerror (errno));
    return 1;
  }
  pinMode(BUTTON_PIN, INPUT);
  pullUpDnControl (BUTTON_PIN, PUD_UP) ;

  if ( wiringPiISR (BUTTON_PIN, INT_EDGE_FALLING, &myInterrupt) < 0 ) {
    fprintf (stderr, "Unable to setup ISR: %s\n", strerror (errno));
    return 1;
  }

  // display counter value every second.
  while ( 1 ) {
    //  printf( "%d\n", eventCounter );
    if (eventCounter != 0) {
      system("systemctl suspend");
      //printf("Error!!!");
    }

    eventCounter = 0;
    delay( 100 ); // wait 0.1 second
  }

  return 0;
}
