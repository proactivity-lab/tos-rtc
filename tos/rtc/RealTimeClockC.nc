/**
 * RTC configuration.
 *
 * @author Raido Pahtma
 * @license MIT
*/
#include "time64.h"
configuration RealTimeClockC {
	provides {
		interface RealTimeClock;
		interface Get<time64_t> as Time;
	}
}
implementation {

	components new RealTimeClockP();
	RealTimeClock = RealTimeClockP;
	Time = RealTimeClockP;

	components LocalTimeSecondC;
	RealTimeClockP.LocalTime -> LocalTimeSecondC;

	components TimeConversionC;

}
