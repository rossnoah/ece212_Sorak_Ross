#include "ece212.h"

int main() {
    ece212_lafbot_setup();
    int leftSensor, rightSensor;
    RBACK = 0;
    LBACK = 0;
    int rVal, lVal;
    int SENSOR_CUTOFF = 340;
    while (1) {
        //    delayms(1);

        leftSensor = analogRead(LEFT_SENSOR) > SENSOR_CUTOFF ? 1 : 0;
        rightSensor = analogRead(RIGHT_SENSOR) > SENSOR_CUTOFF ? 1 : 0;
        lVal = analogRead(LEFT_SENSOR);
        rVal = analogRead(RIGHT_SENSOR);

        if (leftSensor && rightSensor) {
            writeLEDs(0b1001);


        } else if (leftSensor) {

            writeLEDs(0b1000);
        } else if (rightSensor) {
            writeLEDs(0b0001);
        }
        if ((leftSensor && rightSensor) || (!leftSensor && !rightSensor)) {
            RFORWARD = 65535;
            LFORWARD = 65535;
        } else if (leftSensor) {
            RFORWARD = 65535 / 1;
            LFORWARD = 65535 / (3.2+((lVal-SENSOR_CUTOFF)/100));
        } else if (rightSensor) {
            RFORWARD = 65535 / (3.2+((rVal-SENSOR_CUTOFF)/100));
            LFORWARD = 65535 / 1;
        }


    }
    return (EXIT_SUCCESS);
}


