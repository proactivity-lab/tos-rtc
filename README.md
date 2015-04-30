# tos-rtc
Software RTC module for TinyOS.

Simple software defined RTC intended to track UNIX time with a 64bit counter. Should work nicely after 2038 as well.

Relies on a reasonably accurate LocalTimeSecondC.

The RTC is more useful if used together with mktime and gmtime_r functions from https://github.com/proactivity-lab/tos-gmtime.

Setting the RTC after boot and keeping it in sync needs to be handled externally.
On possible sync solution is available at https://github.com/proactivity-lab/tos-rtcsync.
