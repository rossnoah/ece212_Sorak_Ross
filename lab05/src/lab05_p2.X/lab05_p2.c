/* 
 * File:   lab05_p2.c
 * Author: rossnoa
 *
 * Created on October 12, 2023, 1:20 PM
 */

#include "ece212.h"

int main() {
    ece212_lafbot_setup();
    while(1){
        RBACK = 0;
        RFORWARD = 0x8888;
        LBACK = 0;
        LFORWARD = 0x8888;
        delayms(1000);
        RBACK = 0x8888;
        RFORWARD = 0;
        LBACK = 0x8888;
        LFORWARD = 0;
        delayms(1000);
     }
 return (EXIT_SUCCESS);
}
