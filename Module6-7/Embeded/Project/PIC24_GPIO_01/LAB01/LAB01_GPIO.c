#include "CONFIG_PIC24.H"
#include "CDATPIC24.H"

static void HardwareInit(void);

int main(void)
{
	int16u sw;
	int8u state = 0;
		HardwareInit();
		for(;;)
		{
			sw = input_b();
			if(((sw & 0x0010 ) >> 4)  == 0)
			{
				state++;
				if(state == 1){
					output_low(LED0);
					output_high(LED1);
					output_high(LED2);
					output_high(LED3);
				}else if(state == 2){
					output_low(LED1);
					output_high(LED2);
					output_high(LED3);
					output_high(LED0);
				}else if(state == 3){
					output_low(LED2);
					output_high(LED3);
					output_high(LED0);
					output_high(LED1);
				}else if(state == 4){
					output_low(LED3);
					output_high(LED0);
					output_high(LED1);
					output_high(LED2);
					state = 0;
				}
				delay_ms(500);
			}
		}
	return;
}

static void HardwareInit(void)
{
	setup_adc_ports(NO_ANALOGS);
	set_tris_a(get_tris_a() & 0xffeb);
	set_tris_b(get_tris_b() & 0xfff3);
	output_high(LED0);
	output_high(LED1);
	output_high(LED2);
	output_high(LED3);
	return;
}	