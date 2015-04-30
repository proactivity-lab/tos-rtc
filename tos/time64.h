/**
 * 64-bit time header.
 *
 * @author Raido Pahtma
 * @license MIT
 */
#ifndef TIME64_H_
#define TIME64_H_

#ifndef NESC
	#error This time.h is intended for use with NesC and TinyOS!
#endif // NESC

typedef int64_t time_t; // Also defining time_t, but time64_t should be used almost exclusively.
typedef int64_t time64_t;

// struct tm is defined to be as compact as possible.
// Care must be taken to cast the values when doing calculations to avoid overflows.
struct tm {
	uint8_t  tm_sec;  // Seconds.      [0-60] (1 leap second)
	uint8_t  tm_min;  // Minutes.      [0-59]
	uint8_t  tm_hour; // Hours.        [0-23]
	uint8_t  tm_mday; // Day.          [1-31]
	uint8_t  tm_mon;  // Month.        [0-11]
	uint16_t tm_year; // Year - 1900.
	uint8_t  tm_wday; // Day of week.  [0-6]
	uint16_t tm_yday; // Day of year.  [0-365]
};

// mktime with time64
time64_t mktime(struct tm* t) @C();

// gmtime_r with time64
struct tm* gmtime_r(const time64_t* timep, struct tm* result) @C();

#endif // TIME64_H_