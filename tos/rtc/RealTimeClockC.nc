/**
 * RTC configuration.
 *
 * @author Raido Pahtma
 * @license MIT
*/
configuration RealTimeClockC {
	provides interface RealTimeClock;
}
implementation {

	components new RealTimeClockP();
	RealTimeClock = RealTimeClockP;

	components LocalTimeSecondC;
	RealTimeClockP.LocalTime -> LocalTimeSecondC;

}