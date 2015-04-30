/**
 * RTC interface.
 *
 * @author Raido Pahtma
 * @license MIT
 */
#include "time64.h"
interface RealTimeClock {

	/**
	 * Return the current time or (time_t)(-1) to indicate that the current time is not available.
	*/
	command time64_t time();

	/**
	 * Set RTC value.
	 */
	command error_t stime(time64_t t);

	/**
	 * Event signalled when RTC time is adjusted.
	 */
	event void changed(time64_t old, time64_t current);

}