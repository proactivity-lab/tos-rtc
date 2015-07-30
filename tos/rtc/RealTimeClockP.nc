/**
 * Simple RTC module. Records a known reference point between localtime and
 * global time. Assumes that localtime is constantly increasing, and accurate.
 *
 * @author Raido Pahtma
 * @license MIT
 */
#include "time64.h"
generic module RealTimeClockP() {
	provides {
		interface RealTimeClock;
		interface Get<time64_t> as Time;
	}
	uses {
		interface LocalTime<TSecond>;
	}
}
implementation {

	time64_t m_time = -1; // Time not known
	uint32_t m_local = 0;

	command time64_t Time.get() {
		return call RealTimeClock.time();
	}

	command time64_t RealTimeClock.time() {
		if(m_time == -1) {
			return -1;
		}
		return m_time + call LocalTime.get() - m_local;
	}

	/**
	 * Set the RTC. This can cause the time to jump into the past, so users
	 * should listen to the changed event and take appropriate action. Should
	 * not be a problem, if RTC updates are handled responsibly
	*/
	command error_t RealTimeClock.stime(time64_t t) {
		time64_t old = call RealTimeClock.time();
		m_time = t;
		m_local = call LocalTime.get();
		if(m_time != old) {
			signal RealTimeClock.changed(old, m_time);
		}
		return SUCCESS;
	}

}
