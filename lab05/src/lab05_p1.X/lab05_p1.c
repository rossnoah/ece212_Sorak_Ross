/* 
 * File:   lab05_p1.c
 * Author: rossnoa
 *
 * Created on October 12, 2023, 12:00 PM
 */

#include "ece212.h"
int main() {
 ece212_setup();
 while(1){
 //add your code here
     int mode = 0;
     int i = 0;
     while(i<4 && i>0){
         
         switch(i){
             
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
         if(BTN11){
             break;
         }
         delayms(150);
         
         if(BTN11){
             break;
         }
         
      i+=(mode == 0 ? 1 : 0);
     }
     
     if(BTN11){
        if(mode == 0) mode =1;
        else mode = 0;
     }else{
         i = mode ==0 ? 0:3;
     }
     
 }
 return (EXIT_SUCCESS);
}
