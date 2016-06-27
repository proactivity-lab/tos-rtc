/**
 * RTC print module. Print out time periodically and when changed.
 *
 * @author Raido Pahtma
 * @license MIT
 */
#include "time64.h"
generic module RealTimeClockPrintP(uint32_t period_s) {
	uses {
		interface RealTimeClock;
		interface Timer<TMilli>;
		interface Boot @exactlyonce();
	}
}
implementation {

	#warning "Periodically printing RTC time!"

	#define __MODUUL__ "rtcp"
	#define __LOG_LEVEL__ ( LOG_LEVEL_RealTimeClockPrintP & BASE_LOG_LEVEL )
	#include "log.h"

	norace time64_t m_old = (time64_t)(-1);
	norace time64_t m_new = (time64_t)(-1);

	event void Boot.booted() {
		call Timer.startPeriodic(SEC_TMILLI(period_s));
	}

	task void changed() {
		if(m_old != (time64_t)(-1)) {
			if(m_new != (time64_t)(-1)) {
				debug1("sync %"PRIu32"->%"PRIu32, (uint32_t)m_old, (uint32_t)m_new);
			} else {
				debug1("sync %"PRIu32"->-1", (uint32_t)m_old);
			}
		} else {
			if(m_new != (time64_t)(-1)) {
				debug1("sync -1->%"PRIu32, (uint32_t)m_new);
			} else {
				debug1("sync -1->-1");
			}
		}
	}

	async event void RealTimeClock.changed(time64_t old, time64_t current) {
		m_old = old;
		m_new = current;
		post changed();
	}

	event void Timer.fired() {
		time64_t t = call RealTimeClock.time();
		if(t != (time64_t)(-1)) {
			debug1("time %"PRIu32, (uint32_t)t);
		} else {
			debug1("time -1");
		}
	}

}
