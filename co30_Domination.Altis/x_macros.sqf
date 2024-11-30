// uncomment for debugging with __TRACE. see below
//#define __DEBUG__

#ifdef __DEBUG__

//#define __TRACE(tmsg) diag_log format ["T%1,DT%2,F%3,FPS%4,%5,%6,'%7'", time, diag_tickTime, diag_frameno, diag_fps, call {_xarsx = __FILE__ splitString "\";_xarsx select (count _xarsx - 1)}, __LINE__, tmsg];
//#define __TRACE_1(tmsg,parame1) diag_log format ["T%1,DT%2,F%3,FPS%4,%5,%6,'%7',%8: %9", time, diag_tickTime, diag_frameno, diag_fps, call {_xarsx = __FILE__ splitString "\";_xarsx select (count _xarsx - 1)}, __LINE__, tmsg, parame1, call compile format ["%1", parame1]];
//#define __TRACE_2(tmsg,parame1,parame2) diag_log format ["T%1,DT%2,F%3,FPS%4,%5,%6,'%7',%8: %9,%10: %11", time, diag_tickTime, diag_frameno, diag_fps, call {_xarsx = __FILE__ splitString "\";_xarsx select (count _xarsx - 1)}, __LINE__, tmsg, parame1, call compile format ["%1", parame1], parame2, call compile format ["%1", parame2]];
//#define __TRACE_3(tmsg,parame1,parame2,parame3) diag_log format ["T%1,DT%2,F%3,FPS%4,%5,%6,'%7',%8: %9,%10: %11,%12: %13", time, diag_tickTime, diag_frameno, diag_fps, call {_xarsx = __FILE__ splitString "\";_xarsx select (count _xarsx - 1)}, __LINE__, tmsg, parame1, call compile format ["%1", parame1], parame2, call compile format ["%1", parame2], parame3, call compile format ["%1", parame3]];

#define __TRACE(tmsg) diag_log format ["[T] %1,%2,'%3'", call {_xarsx = __FILE__ splitString "\";_xarsx select (count _xarsx - 1)}, __LINE__, tmsg];
#define __TRACE_1(tmsg,parame1) diag_log format ["[T] %1,%2,'%3',%4: %5", call {_xarsx = __FILE__ splitString "\";_xarsx select (count _xarsx - 1)}, __LINE__, tmsg, parame1, call compile format ["%1", parame1]];
#define __TRACE_2(tmsg,parame1,parame2) diag_log format ["[T] %1,%2,'%3',%4: %5,%6: %7", call {_xarsx = __FILE__ splitString "\";_xarsx select (count _xarsx - 1)}, __LINE__, tmsg, parame1, call compile format ["%1", parame1], parame2, call compile format ["%1", parame2]];
#define __TRACE_3(tmsg,parame1,parame2,parame3) diag_log format ["[T] %1,%2,'%3',%4: %5,%6: %7,%8: %9", call {_xarsx = __FILE__ splitString "\";_xarsx select (count _xarsx - 1)}, __LINE__, tmsg, parame1, call compile format ["%1", parame1], parame2, call compile format ["%1", parame2], parame3, call compile format ["%1", parame3]];

#else

#define __TRACE(tmsg)
#define __TRACE_1(tmsg,parame1)
#define __TRACE_2(tmsg,parame1,parame2)
#define __TRACE_3(tmsg,parame1,parame2,parame3)

#endif
