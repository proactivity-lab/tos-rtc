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

typedef int64_t time64_t;
typedef nx_int64_t nx_time64_t;

#ifndef TOSSIM
typedef int64_t time_t; // Also defining time_t, but time64_t should be used almost exclusively.

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
#endif // TOSSIM

// mktime with time64
time64_t mktime(struct tm* t) @C();

// gmtime_r with time64
struct tm* gmtime_r(const time64_t* timep, struct tm* result) @C();

// Add/subtract seconds from a struct tm
struct tm* tm_add_seconds(struct tm* tm, time64_t seconds) @C();

void yxkzero(struct tm* yxk) {
	yxk->tm_sec = 0;
	yxk->tm_min = 0;
	yxk->tm_hour = 0;
	yxk->tm_mday = 1;
	yxk->tm_mon = 0;
	yxk->tm_year = ((yxk->tm_year) / 100) * 100; // Beginning of century, 2000-01-01 00:00:00 = 946684800
	yxk->tm_wday = 0; // Does not really matter
	yxk->tm_yday = 0; // Does not really matter
}

uint32_t yxktime(time64_t* t) {
	if(*t != (time64_t)(-1)) {
		struct tm yxk;
		if(gmtime_r(t, &yxk) != NULL) {
			yxkzero(&yxk);
			return (uint32_t)(*t - mktime(&yxk));
		}
	}
	return UINT32_MAX;
}

time64_t yxktime_reverse(uint32_t yxks, time64_t* now) {
	if(*now != (time64_t)(-1)) {
		struct tm yxk;
		if(gmtime_r(now, &yxk) != NULL) {
			yxkzero(&yxk);
			return mktime(&yxk) + yxks;
		}
	}
	return -1;
}

#endif // TIME64_H_
