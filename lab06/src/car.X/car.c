#include "ece212.h"
int main()
{
    ece212_lafbot_setup();
    int leftSensor, rightSensor;
    RBACK = 0;
    LBACK = 0;
    // leftSensor = analogRead(LEFT_SENSOR) > 340 ? 1 : 0;
    // rightSensor = analogRead(RIGHT_SENSOR) > 340 ? 1 : 0;

    // RFORWARD = 0;
    // LFORWARD = 65535;
    // delayms(50);
    // RFORWARD = 65535;

    while (1)
    {
        leftSensor = analogRead(LEFT_SENSOR) > 340 ? 1 : 0;
        rightSensor = analogRead(RIGHT_SENSOR) > 340 ? 1 : 0;

        if (leftSensor && !rightSensor)
        {
            // go straight
            RFORWARD = 65535;
            LFORWARD = 65535;
        }
        else if (!leftSensor && !rightSensor)
        {
            // turn left
            RFORWARD = 65535;
            LFORWARD = 0;
        }
        else if ((!leftSensor && rightSensor) || (leftSensor && rightSensor))
        {
            // turn right
            RFORWARD = 0;
            LFORWARD = 65535;
        }
    }
    return (EXIT_SUCCESS);
}
