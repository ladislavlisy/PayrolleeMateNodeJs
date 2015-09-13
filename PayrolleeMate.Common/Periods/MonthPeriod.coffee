require("../Libs/date.format")

class MonthPeriod
  constructor: (code) ->
    @code = code

  Code: ->
    @code

  Year: ->
    (@code / 100) >> 0

  Month: ->
    (@code % 100)

  YearInt: ->
    (@code / 100) >> 0

  MonthInt: ->
    (@code % 100)

  MonthOrder: ->
    Math.max(0, @YearInt - 2000) * 12 + @MonthInt()

  DaysInMonth: ->
    Date.getDaysInMonth(@YearInt(), @MonthInt()-1);

  BeginOfMonth: ->
    periodDate = new Date(@YearInt(), @MonthInt()-1, 1, 0, 0, 0, 0)

  EndOfMonth: ->
    periodDate = new Date(@YearInt(), @MonthInt()-1, @DaysInMonth(), 0, 0, 0, 0)

  DateOfMonth: (dayOrdinal) ->
    periodDay = Math.min(Math.max(1, dayOrdinal), @DaysInMonth())
    periodDate = new Date(@YearInt(), @MonthInt()-1, periodDay, 0, 0, 0, 0)

  WeekDayOfMonth: (dayOrdinal) ->
    periodDate = @DateOfMonth(dayOrdinal)
    @DayOfWeekMonToSun(periodDate)

  DayOfWeekMonToSun: (periodDate) ->
    periodDateCwd = periodDate.getDay()
    # DayOfWeek Sunday = 0
    # Monday = 1, Tuesday = 2, Wednesday = 3, Thursday = 4, Friday = 5, Saturday = 6
    if (periodDateCwd == 0) then 7 else periodDateCwd

  Description:  ->
    firstPeriodDay = @BeginOfMonth()
    firstPeriodDay.format ("mmmm yyyy")

  compareToPeriod: (other) ->
    compareResult = if (@Code() == other.Code()) then 0 else (@Code() - other.Code())

  isEqualToPeriod: (other) ->
    (@compareToPeriod(other)==0)

  isGreaterToPeriod: (other) ->
    (@compareToPeriod(other)>0)

  isLessToPeriod: (other) ->
    (@compareToPeriod(other)<0)

  toString:  ->
    @Code.toString()

module.exports = MonthPeriod