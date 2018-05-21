/* 
 * File:    tester.c
 * Author:  Dr.Santi Nuratch
 *          Embedded Intelligence Lab., INC-KMUTT
 * Created on 22 September 2016, 13:14
 */

#include <24FJ48GA002.h>

/******************************************************************************/
/*                           SYSTEM CONFIGURATION                             */
/******************************************************************************/


/* OSCI-RA2 is used as DO0 connected to LED0 and
 * OSCO-RA3 is used as digital input (can pin cannot be set as output)
 * connected to DRT of FT232 and RESET of ESP8266
 * It is very IMPORTANT to define "#fuses OSCIO"
 */
#fuses OSCIO

/* To use the 4MHz Internal Fast RC oscillator with x4 PLL (Phase-Locked Loop),
 * the "#fuses FRC_PLL" must be defined. With this directive, the system 
 * oscillator (FOSC) is 4MHz x 4 = 32MHz. For this MCU, PIC24FJ48GA002, the
 * processor clock frequency (FCY) = FOSC/2 = 16MHz (see data sheet for more details)
 */
#fuses FRC_PLL

/* Optional directives can be defined (see compiler user's manual for more information)
 */
#fuses NOIOL1WAY, NOWDT, NODEBUG, NOWRT, NOPROTECT, NOJTAG


/* ADC of this MCU is 10-bit */
#device *=16 ADC=10

/* Passing string through RAM */
#device PASS_STRINGS = IN_RAM 


/* Processor clock frequency (FCY) is 16MHz */
#use delay(clock=16000000)


/* Interrupt control */
#define DIS_ISR() disable_interrupts(GLOBAL)
#define ENB_ISR() enable_interrupts(GLOBAL)
#define ENTER_CRITICAL(code) {DIS_ISR(); code; ENB_ISR();}

/* Timer1 interrupt control */
#define DI_TMR1() disable_interrupts(INT_TIMER1)
#define EI_TMR1() enable_interrupts(INT_TIMER1)

/* UART1 receiver interrupt control */
#define DI_RXD1() disable_interrupts(INT_RDA)
#define EI_RXD1() enable_interrupts(INT_RDA)


/******************************************************************************/
/*                          HARDWARE CONFIGURATION                            */
/******************************************************************************/

/* OC5 (Output Compare Module #5) is used to generate signal/frequency for Buzzer 
 * The buzzer is connected to PB11
 */
#PIN_SELECT OC5 = PIN_B11 


/* UART1 connection (see in schematic diagram) */
#PIN_SELECT U1RX=PIN_B12
#PIN_SELECT U1TX=PIN_B13 

/* UART2 connection (see in schematic diagram) */
#PIN_SELECT U2RX=PIN_B14
#PIN_SELECT U2TX=PIN_B15 

/*
 * To map the standard io functions, e.g., printf(), kbhit() and others to 
 * the UART1 the UART1 must defined after UART2. The last defined UART will be
 * mapped to the standard io functions.
 */ 
#use rs232(baud=9600, UART2, ERRORS, stream=ESP)
#use rs232(baud=9600, UART1, /*ERRORS*//*, stream=COM*/) // UART1 will be mapped to the standard io functions

/* Fast io operation is used */
#use fast_io(A)
#use fast_io(B)


/******************************************************************************/
/*                                    LEDS                                    */
/******************************************************************************/
#define LED0    PIN_A2
#define LED1    PIN_A4
#define LED2    PIN_B2
#define LED3    PIN_B3

/***************************/
/* LED<3:0> are active low */
/***************************/

#define LED0_On() output_low(LED0)
#define LED1_On() output_low(LED1)
#define LED2_On() output_low(LED2)
#define LED3_On() output_low(LED3)

#define LED0_Off() output_high(LED0)
#define LED1_Off() output_high(LED1)
#define LED2_Off() output_high(LED2)
#define LED3_Off() output_high(LED3)

#define LED0_Inv() output_toggle(LED0)
#define LED1_Inv() output_toggle(LED1)
#define LED2_Inv() output_toggle(LED2)
#define LED3_Inv() output_toggle(LED3)

/* Writes LED data, d (0x0-0xF) to LED<3:0> */
void LED_Write(unsigned char d) {
    d ^= 0xFFFF;
    output_bit( LED0, d&1 );  // LED0
    output_bit( LED1, d&2 );  // LED1
    output_bit( LED2, d&4 );  // LED2
    output_bit( LED3, d&8 );  // LED3
}

/* Returns LED data (0x0-0xF) */
unsigned char LED_Read(void) {
    return( (!input(LED0)<<0) | (!input(LED1)<<1) |  
            (!input(LED2)<<2) | (!input(LED3)<<3) );
}

/* Writes LED status, d (1=ON, 0=OFF) to LED */
void LED_Put(unsigned char id /*0-3*/, BOOLEAN d /* TRUR, FALSE*/) {
    d = !d;
    switch(id){
        case 0: output_bit( LED0, d ); break;
        case 1: output_bit( LED1, d ); break;
        case 2: output_bit( LED2, d ); break;
        case 3: output_bit( LED3, d ); break;
    }
}

/* Turns on LED */
void LED_Set(unsigned char id) {
    LED_Put(id, 1);
}

/* Turns off LED */
void LED_Clr(unsigned char id) {
    LED_Put(id, 0);
}

/* Returns LED status
 * returns 1, if LED is ON
 * returns 0, if LED is OFF 
 */
BOOLEAN LED_Get(unsigned char id) {
    switch(id){
        case 0: return !input( LED0 ); 
        case 1: return !input( LED1 ); 
        case 2: return !input( LED2 );
        case 3: return !input( LED3 );
    }
}

/* Toggles LED status */
void LED_Inv(unsigned char id) {
    LED_Put(id, !LED_Get(id));
}


/******************************************************************************/
/*                                  SWITCHES                                  */
/******************************************************************************/
#define PSW0    PIN_B4
#define PSW1    PIN_B5
#define PSW2    PIN_B6
#define PSW3    PIN_B7

/* Returns 1, if the switch is pressed */
#define PSW0_Chk() !input(PSW0)
#define PSW1_Chk() !input(PSW1)
#define PSW2_Chk() !input(PSW2)
#define PSW3_Chk() !input(PSW3)

/* Return 1, if PSW is pressed (ON/CLOSED)
 * Return 0, if PSW is not pressed (OFF/OPEN)
 */
BOOLEAN PSW_Get(unsigned int id) {
    switch(id){
        case 0: return PSW0_Chk();
        case 1: return PSW1_Chk();
        case 2: return PSW2_Chk();
        case 3: return PSW3_Chk();
    }
}

/* Returns PSW data (0x0 - 0xF) */
unsigned char PSW_Read(void){
    return (~(input_b()>>4)) & 0xF;
}

/* Returns a pressed switch id. 
 * If the switches are pressed in the same time, the lowest id will be returned
 * If no switch is pressed, it returns 0xFF
 */
unsigned char PSW_Scan(void) {
    int d = (~(input_b()>>4)) & 0xF;
    int i;
    for(i=0; i<4; i++) {
        if(d & 1<<i) {
            return i;   // Switch PSW<i> is pressed
        }
    }
    return 0xFF;    // No switch is pressed
}



static BOOLEAN _sw_active = FALSE;
static unsigned char _sw_on_id = 0xFF;
static unsigned char _sw_state = 0;
static unsigned char _sw_ticks = 0;
/* Called by Timer1 ISR */
void Switch_Service(void) {
    #define PSW_REP_MAX 50  // 50*10ms = 500mS
    static unsigned char hold_cnt   = 0;
    static unsigned char prv_id     = 0xFF;
    static unsigned char rep_ticks  = PSW_REP_MAX; 
    if(++_sw_ticks > 10) { // 10 ticks = 10mS
        _sw_ticks = 0;
        // Get switch id
        unsigned char d = (~(input_b()>>4)) & 0xF;
        unsigned char cur_id = 0xFF;
        int i;
        for(i=0; i<4; i++) {
            if(d & 1<<i) {
                cur_id = i;
                break;
            }
        }
 
        switch(_sw_state) {
            case 0: // Wait for ON 
                if(cur_id != 0xFF) {
                    prv_id = cur_id;
                    hold_cnt = 0;
                    _sw_state++;
                }
            break;
            case 1: // Holding and ON first time
                if(cur_id == prv_id){
                    hold_cnt++;
                    if(hold_cnt >= 3){ // 5*10mS = 50mS
                        _sw_active = TRUE;
                        _sw_on_id = cur_id;
                        hold_cnt = 0;
                        rep_ticks  = PSW_REP_MAX;
                        _sw_state++;
                    }
                }
                else{
                    _sw_state = 0;
                }
            break;
            
            case 2: // Wait for repeating
                if(cur_id == prv_id){
                    if(++hold_cnt > rep_ticks){
                        _sw_active = TRUE;
                        _sw_on_id = cur_id;
                        hold_cnt = 0;
                        rep_ticks = 5; // 5*10mS = 50mS
                    }
                }else{
                    prv_id = cur_id;
                    hold_cnt = 0;
                    _sw_state++;
                }
            break;
            
            case 3: // On, Wait for OFF
                if(cur_id != prv_id){
                    if(++hold_cnt >= 3){ // 5*10mS = 50mS
                        _sw_state = 0;
                    }
                }   
            break;
        }
    }
}

/* Returns switch status, TRUE: Active, FALSE: Non-Active */
/* It resets the switch active flag automatically */
/* If switch is holding down, the switch active flag will be set to TRUE repeatedly */
BOOLEAN PSW_Check(void) {
    if(_sw_active == TRUE){
        _sw_active = FALSE;
        return TRUE;
    }
    return FALSE;
}

/* Returns an id of active switch, 0-3      */
/* If no switch is pressed, it returns 0xFF */
/* The active flag and switch id will be reset to non-active automatically */
/* If switch is holding down, the switch active flag will be set to TRUE and
 * the switch id will be set to id of the holding switch automatically, repeatedly */
unsigned char PSW_GetId(void) {
    unsigned char ret = _sw_on_id;
     _sw_active = FALSE;
     _sw_on_id  = 0xFF;
    return ret;
}


/******************************************************************************/
/*                                   BUZZER                                   */
/******************************************************************************/
#define BUZZ    PIN_B11

static unsigned char _beep_tone   = 90;        // 0 - 100 
static unsigned char _beep_power  = 50;        // 0 - 100
static unsigned int  _beep_period = 30;        // Number of ticks of Timer1
static unsigned int  _beep_ticks  = 0;         // Number of ticks of Timer1
static BOOLEAN _beep_playing      = FALSE;
static BOOLEAN _beep_updated      = FALSE;

unsigned int _beep_tmrval = 1500;
unsigned int _beep_pwmval =  700;

/* Called by Timer1 ISR */
void Beep_Service(void){
    if(_beep_playing == TRUE){
        _beep_ticks++;
        if(_beep_ticks >= _beep_period && _beep_period != 0xFFFF){
            _beep_ticks = 0;
            _beep_playing = FALSE;
            setup_timer2(TMR_DISABLED);
            setup_compare(5, COMPARE_OFF);
        }
    }
}

void Beep_Update(void) {
    _beep_tmrval = 100 + (100-_beep_tone)*49;           // 100 - 5000
    _beep_pwmval = (_beep_tmrval>>1)*_beep_power/100;   // 0 - 50%, (50% is maximum power)
    _beep_updated = TRUE;
}

void Beep_SetTone(unsigned char tone) {
    _beep_tone = tone>100?100:tone;
    _beep_updated = FALSE;
}

void Beep_SetPower(unsigned char power) {
    _beep_power = power>100?100:power;
   _beep_updated = FALSE;
}

void Beep_SetPeriod(unsigned int period) {
    _beep_period = period;
    _beep_updated = FALSE;
}

void Beep_Setup(unsigned char tone, unsigned char power, unsigned int period) {
    _beep_tone   = tone>100?100:tone;
    _beep_power  = power>100?100:power;
    _beep_period = period;
    _beep_updated = FALSE;
}

void Beep_Start(void) {
    
    /* Be sure beep parameters are update on the first call */
    if(!_beep_updated){
        Beep_Update();
    }
    /* Setup timer2 to generate clock signal for OC5 (Buzzer) */
    /* 16MHz/8/(500 + _beep_tone*32) = xkHz */
    if(_beep_power <= 0 || _beep_period <= 0 || _beep_playing == TRUE) {
        return;
    }

    setup_compare(5, COMPARE_OFF);
    
    setup_timer2(TMR_INTERNAL |TMR_DIV_BY_8, _beep_tmrval);
    
    /* Setup Output Compare Module #5 (OC5) to work in PWM generator mode */
    /* The OC5 uses Timer2 output as clock input */
    set_timer2(0); // Required
    setup_compare(5, COMPARE_PWM | COMPARE_TIMER2); 
    
    /* Turn ON with 50% duty cycle (maximum sound energy) */
    set_pwm_duty(5, _beep_pwmval);  
    
    _beep_ticks = 0;
    _beep_playing = TRUE;
}

void Beep_Stop(void){
    setup_timer2(TMR_DISABLED);
    setup_compare(5, COMPARE_OFF);
}

void Beep(void) {
    Beep_Start();
}

void Sound(unsigned char tone, unsigned char power, unsigned int period) {
    Beep_Setup(tone>100?100:tone, power>100?100:power, period);
    Beep_Start();
}

/******************************************************************************/
/*                                     ADC                                    */
/******************************************************************************/

#define ADC_NUM_CHANNELS 4
int _adc_value[ADC_NUM_CHANNELS];
int _ach_ch_idx = 0;

void ADC_Service(void) {
    _adc_value[_ach_ch_idx++] = read_adc()&0x3FF;
    if(_ach_ch_idx>3) _ach_ch_idx = 0;
    set_adc_channel(_ach_ch_idx);
}

int ADC_Read(unsigned char ch) {
    ch = ch>3?3:ch;
    return _adc_value[ch];
}



