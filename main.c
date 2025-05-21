#include <MKL25Z4.H>
#include <stdio.h>
#define VREF_FACTOR (300)
#define TEMPERATURE_SENSOR_CHN   (15)
#define Level_SENSOR_CHN   (14)
#define DISABLE_ADC  (31)

uint16_t adc_read(uint8_t ch);
static uint16_t Actual_Temp=0;
static uint16_t Actual_Level=0;
void scan_temperature(void);
void init_ADC(void);
static int adc_cal(void);


void Check_level(void);
void Take_Action(void);
void InitGPIO(void);
void delay(int);


#define SYS_ON_LED   1
#define INLET        2
#define OUTLET       3
#define Heater       4
#define Alarm        5
#define ON_Button    6
#define MASK(x) (1<< (x))


// This function is used for the declarion of pins as GPIO
void InitGPIO(void){
	  // Enable click for PortB and PORTD
	SIM->SCGC5 |= ((SIM_SCGC5_PORTB_MASK) | (SIM_SCGC5_PORTD_MASK));
	
	// configure mux settings to set all pins as GPIO
	PORTB->PCR[SYS_ON_LED] &= ~PORT_PCR_MUX_MASK;
	PORTB->PCR[SYS_ON_LED] |= ~PORT_PCR_MUX(1);
	
	PORTB->PCR[INLET] &= ~PORT_PCR_MUX_MASK;
	PORTB->PCR[INLET] |= ~PORT_PCR_MUX(1);
	
	PORTB->PCR[OUTLET] &= ~PORT_PCR_MUX_MASK;
	PORTB->PCR[OUTLET] |= ~PORT_PCR_MUX(1);
	
	PORTB->PCR[Heater] &= ~PORT_PCR_MUX_MASK;
	PORTB->PCR[Heater] |= ~PORT_PCR_MUX(1);
	
	PORTB->PCR[Alarm] &= ~PORT_PCR_MUX_MASK;
	PORTB->PCR[Alarm] |= ~PORT_PCR_MUX(1);
	
	PORTB->PCR[ON_Button] &= ~PORT_PCR_MUX_MASK;
	PORTB->PCR[ON_Button] |= ~PORT_PCR_MUX(1);
	
	// set data dirrection registers for PORTB and PORTD
	
	PTB->PDDR |= (MASK(SYS_ON_LED) | MASK(INLET) | MASK(OUTLET)| MASK(Heater) | MASK(Alarm));
	PTB->PDDR &= (0 << 6);
	     
}
// This function is used for Delay
void delay(int n) {
 int i;
 for(i = 0; i < n; i++) ;
}

// This function perform all the actions like controlling of valves, heater and leds
void Take_Action(void){
	   
	  unsigned int Max_Temp =40;
    unsigned int Min_Level =65;
    unsigned int Max_Level=200;
    

	
  if( (Actual_Level < Max_Level) & (Actual_Level > Min_Level) & (Actual_Temp < Max_Temp) ){
		// if water level is between max and 25% and temperature is below 75%
		    PTB->PDOR = MASK(INLET);   // Inlet is ON
	      PTB->PDOR = MASK(OUTLET);  // Outlet is ON
		    PTB->PDOR = MASK(Heater);   // Heater is ON
	 }
  
	if(Actual_Level < Min_Level){     // water level drops below 25% of the max 
		    PTB->PCOR = MASK(OUTLET);}  // Outlet is OFF
	if(Actual_Level > Max_Temp){ 
		    PTB->PDOR = MASK(Alarm);   // Alarm is ON
		    delay(10000000); 		// take 10s delay
		    scan_temperature();
		    if(Actual_Level > Max_Temp){
					PTB->PCOR = MASK(INLET);        // Inlet is off
	        PTB->PCOR = MASK(OUTLET);       // Outlet is off
		      PTB->PCOR = MASK(Heater);       // Heater is off
					PTB->PCOR = MASK(SYS_ON_LED);   // System_ON_Led off
				  
				}
			}
		      
}

// This function reads temperture of LM35
void scan_temperature(void){
    static uint16_t adc_result;
    static uint16_t adc_result_avg;
    //static uint16_t temp;
    static uint8_t loopcntr;
    loopcntr++;                                       /* Increments every 50msec */
    adc_result += adc_read(TEMPERATURE_SENSOR_CHN);   /* Get ADC Result for temperature sensor */
     
    /* Take 16 samples to calculate temperature */
    if (loopcntr >= 16){           
        adc_result_avg = adc_result >> 4;                /* Get ADC average value */
        Actual_Temp = ((adc_result_avg * VREF_FACTOR) >> 10);   /* Calculate temperature */
        adc_result = 0;
        loopcntr = 0;
    }
      ADC0_SC1A |= ADC_SC1_ADCH(DISABLE_ADC);       /* Disable ADC module */
}

// This fuction reads the level of water 

void Check_level(void){
    static uint16_t adc_result1;
    static uint16_t adc_result_avg1;
    //static uint16_t temp;
    static uint8_t loopcntr1;
    loopcntr1++;                                       /* Increments every 50msec */
    adc_result1 += adc_read(Level_SENSOR_CHN);   /* Get ADC Result for temperature sensor */
     
    /* Take 16 samples to calculate temperature */
    if (loopcntr1 >= 16){           
        adc_result_avg1 = adc_result1 >> 4;                /* Get ADC average value */
        Actual_Level = ((adc_result_avg1 * VREF_FACTOR) >> 10);   /* Calculate temperature */
        adc_result1 = 0;
        loopcntr1 = 0;
    }
      ADC0_SC1A |= ADC_SC1_ADCH(DISABLE_ADC);       /* Disable ADC module */
}
// This functions initilaizes ADC
void init_ADC(void){
    int cal_res;
    SIM_SCGC6 |= SIM_SCGC6_ADC0_MASK;  // Enable ADC0 Clock
     
    do{
      cal_res = adc_cal();            // Calibrate ADC
    } while (cal_res == -1);
 
    // Configure ADC
    ADC0_SC1A |= (ADC_SC1_AIEN_MASK);  // Interrupt enabled
    ADC0_SC1A &= ~ADC_SC1_DIFF_MASK;   // Single Ended ADC
     
    ADC0_CFG1 = 0; // Reset register
    ADC0_CFG1 |= (ADC_CFG1_MODE(2)  |   // 10 bits mode
                        ADC_CFG1_ADICLK(1)|   // Input Bus Clock/2 (24 Mhz)
                        ADC_CFG1_ADIV(3)  |     // Clock divide by 8 (3 Mhz)
                                ADC_CFG1_ADLPC_MASK); // Low power mode
     
    ADC0_SC3  &= ~ADC_SC3_AVGE_MASK;
}
 
 

static int adc_cal(void){
    uint16_t calib;
    ADC0_CFG1 |= (ADC_CFG1_MODE(3)  |  // 16 bits mode
                        ADC_CFG1_ADICLK(1)|  // Input Bus Clock divided by 2 (48Mhz / 2)
                        ADC_CFG1_ADIV(3));   // Clock divide by 8 (3 MHz)
    // Enable HW average  Set HW average of 32 samples  Start calibration process
    ADC0_SC3  |= (ADC_SC3_AVGE_MASK | ADC_SC3_AVGS(3) | ADC_SC3_CAL_MASK);      
    while (ADC0_SC3 & ADC_SC3_CAL_MASK); // Wait for calibration to end
    if (ADC0_SC3 & ADC_SC3_CALF_MASK)   // Check for successful calibration
        return -1; 
     
    calib = 0;
    calib += ADC0_CLPS + ADC0_CLP4 + ADC0_CLP3 + ADC0_CLP2 + ADC0_CLP1 + ADC0_CLP0;
    calib /= 2;
    calib |= 0x8000;    // Set MSB 
    ADC0_PG = calib;
    calib = 0;
    calib += ADC0_CLMS + ADC0_CLM4 + ADC0_CLM3 + ADC0_CLM2 + ADC0_CLM1 + ADC0_CLM0;
    calib /= 2;
    calib |= 0x8000;    // Set MSB
    ADC0_MG = calib;
     
    return 0;
}
 
 

uint16_t adc_read(uint8_t ch){
    // Write to SC1A to start conversion
ADC0_SC1A = ((ch & ADC_SC1_ADCH_MASK) | (ADC0_SC1A & (ADC_SC1_AIEN_MASK | ADC_SC1_DIFF_MASK)));
while(ADC0_SC2 & ADC_SC2_ADACT_MASK);             // Conversion in progress
while(!(ADC0_SC1A & ADC_SC1_COCO_MASK));          // Run until the conversion is complete
return ADC0_RA ;
}

// This is main function to call all other fuctions	
int main (void){
	SystemCoreClockUpdate();
	InitGPIO();
	while(1){
		 if(PTB->PDIR & MASK(ON_Button)){ } //if ON/Reset switch is not pressed
		 else{                              //if ON/Reset switch is  pressed
			  PTB->PDOR = MASK(SYS_ON_LED);}  // then system on LED is ON
		 Check_level();
		 scan_temperature();
		 Take_Action();
		 
}
	}	



















