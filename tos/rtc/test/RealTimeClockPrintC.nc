/**
 * RTC print configuration.
 *
 * @author Raido Pahtma
 * @license MIT
*/
#include "time64.h"
generic configuration RealTimeClockPrintC(uint32_t period_s) { }
implementation {

	components new RealTimeClockPrintP(period_s);

	components RealTimeClockC;
	RealTimeClockPrintP.RealTimeClock -> RealTimeClockC;

	components new TimerMilliC();
	RealTimeClockPrintP.Timer -> TimerMilliC;

	components MainC;
	RealTimeClockPrintP.Boot -> MainC.Boot;

}
