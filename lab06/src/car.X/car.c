#include "ece212.h"

void filterSensors()
{
    if (rightSensor)
    {
        if (rDelay == 0)
        {
            rDelay = 500;
            rS = 1;
        }
        else
        {
            rDelay--;
        }
    }
    else
    {
        rDelay = 500;
        rS = 0;
    }

    if (leftSensor)
    {
        if (lDelay == 0)
        {
            lDelay = 500;
            lS = 1;
        }
        else
        {
            lDelay--;
        }
    }
    else
    {
        lDelay = 500;
        lS = 0;
    }
}

void straight()
{
    // go straight
    RFORWARD = 65535;
    LFORWARD = 65535;
}

void right()
{
    // turn right
    RFORWARD = 65535 / 2.3;
    LFORWARD = 65535;
}

void left()
{
    // turn left
    RFORWARD = 65535;
    LFORWARD = 65535 / 2.3;
}

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
    int rDelay = 20 * 625;
    int lDelay = 20 * 625;
    int rS = 0;
    int lS = 0;

    while (1)
    {
        leftSensor = analogRead(LEFT_SENSOR) > 340 ? 1 : 0;
        rightSensor = analogRead(RIGHT_SENSOR) > 340 ? 1 : 0;

        filterSensors();

        if (lS && !rS)
        {
            straight();
        }

        else if (!lS && !rS)
        {
            left();
        }
        else if ((!lS && rS) || (lS && rS))
        {
            right();
        }
    }
    return (EXIT_SUCCESS);
}
