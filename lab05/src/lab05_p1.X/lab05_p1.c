/* 
 * File:   lab05_p1.c
 * Author: rossnoa
 *
 * Created on October 12, 2023, 12:00 PM
 */

#include "ece212.h"
int main() {
 ece212_setup();
 int pos = 0;
 int mode = 0;
 int held = 0;
 while(1){
     if(!BTN11){
         held = 0;
     }
     
     if(BTN11 && !held){
         if(mode == 1 ){ 
             mode = 0;
         }
         else if (mode == 0){
            mode = 1;    
         }
         held = 1;
     }
     switch(pos){
             
             case(0): 
                writeLEDs(0b1000);
                break;             
             case(1): 
                writeLEDs(0b0100);
                break;             
             case(2): 
                writeLEDs(0b0010);
                break;             
             case(3): 
                writeLEDs(0b0001);
                break;    
         }
     
     pos += (mode ==1 ? -1 : 1);
     if(pos>3) pos = 0;
     if(pos<0) pos = 3;
     
     delayms(150);

 }
 return (EXIT_SUCCESS);
}
