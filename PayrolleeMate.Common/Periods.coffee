require('datejs')

class MonthPeriod
  @PRESENT = 0

  @DayOfWeekMonToSun: (periodDateCwd) ->
    # DayOfWeek Sunday = 0
    # Monday = 1, Tuesday = 2, Wednesday = 3, Thursday = 4, Friday = 5, Saturday = 6
    if (periodDateCwd == 0) then 7 else periodDateCwd

  @CreateFromYearAndMonth: (year, month) ->
    new MonthPeriod(100 * year + month)

  @Empty: ->
    new MonthPeriod(MonthPeriod.PRESENT)

  @BeginOfYear: (year) ->
    new MonthPeriod(100 * year + 1)

  @EndOfYear: (year) ->
    new MonthPeriod(100 * year + 12)

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

  CreateDate: (day) ->
    Date.today().
      set({
        day: day,
        year: @YearInt(),
        month: @MonthInt()-1,
        hour: 0,
        minute: 0,
        second: 0,
        millisecond: 0 })

  MonthOrder: ->
    Math.max(0, @YearInt - 2000) * 12 + @MonthInt()

  DaysInMonth: ->
    Date.getDaysInMonth(@YearInt(), @MonthInt()-1);

  BeginOfMonth: ->
    periodDate = @CreateDate(1)

  EndOfMonth: ->
    periodDate = @CreateDate(@DaysInMonth())

  DateOfMonth: (dayOrdinal) ->
    periodDay = Math.min(Math.max(1, dayOrdinal), @DaysInMonth())
    periodDate = @CreateDate(periodDay)

  WeekDayOfMonth: (dayOrdinal) ->
    periodDate = @DateOfMonth(dayOrdinal)
    periodDateCwd = periodDate.getDay()
    @DayOfWeekMonToSun(periodDateCwd)

  description:  ->
    firstPeriodDay = @BeginOfMonth()
    firstPeriodDay.toString("MMMM yyyy")

  compareToPeriod: (other) ->
    compareResult =
      if (@Code() == other.Code()) then 0
      else (@Code() - other.Code())

  isEqualToPeriod: (other) ->
    (@compareToPeriod(other)==0)

  isGreaterToPeriod: (other) ->
    (@compareToPeriod(other)>0)

  isLessToPeriod: (other) ->
    (@compareToPeriod(other)<0)

  toString:  ->
    @Code.toString()

class SpanOfMonths
  @CreateFromYear: (year) ->
    new SpanOfMonths(MonthPeriod.BeginOfYear(year), MonthPeriod.EndOfYear(year))

  @CreateFromMonth: (period) ->
    new SpanOfMonths(period, period)

  constructor: (from, upto) ->
    @periodFrom = from
    @periodUpto = upto

  PeriodFrom: ->
    @periodFrom

  PeriodUpto: ->
    @periodUpto

  compareToInterval: (other) ->
    if (@periodFrom == other.periodFrom) then @periodUpto.compareToPeriod(other.periodUpto)
    else @periodFrom.compareToPeriod(other.periodUpto)

  isEqualToInterval: (other) ->
    @compareToInterval(other) == 0

  isGreaterToInterval: (other) ->
    @compareToInterval(other) > 0

  isLessToInterval: (other) ->
    @compareToInterval(other) < 0

  className: ->
    className =
      if (@periodFrom.isEqualToPeriod(@periodUpto)) then "#{@periodFrom.toString()}to#{@periodUpto.toString()}"
      else @periodFrom.toString()

  toString: ->
    @className()

class SpanOfYears
  @CreateFromYear: (year) ->
    new SpanOfYears(year, year)

  @CreateFromYearToYear: (from, upto) ->
    new SpanOfYears(from, upto)

  constructor: (from, upto) ->
    @yearFrom = from
    @yearUpto = upto

  YearFrom: ->
    @yearFrom

  YearUpto: ->
    @yearUpto

  compareToInterval: (other) ->
    if (@yearFrom == other.yearFrom) then @yearUpto - other.yearUpto
    else @yearFrom - other.yearFrom

  isEqualToInterval: (other) ->
    @compareToInterval(other) == 0

  isGreaterToInterval: (other) ->
    @compareToInterval(other) > 0

  isLessToInterval: (other) ->
    @compareToInterval(other) < 0

  className: ->
    className =
      if (@yearFrom != @yearUpto) then "#{@yearFrom.toString()}to#{@yearUpto.toString()}"
      else @yearFrom.toString()

  toString: ->
    @className()

class SeqOfYears
  @END_YEAR_ARRAY = 2100
  @END_YEAR_INTER = 2099

  @transformZeroYear: (year1, year2) ->
    compYear1 = if year1 == 0 then SeqOfYears.END_YEAR_ARRAY else year1
    compYear2 = if year2 == 0 then SeqOfYears.END_YEAR_ARRAY else year2
    (compYear1 - compYear2)

  constructor: (years) ->
    @milestones = years.slice(0)
    @milestones.sort(SeqOfYears.transformZeroYear)

  yearsIntervalForPeriod: (period) ->
    forPeriodAccumulator = (agr, year) ->
      intYear = if (year==0) then SeqOfYears.END_YEAR_ARRAY else year
      intFrom = if (period.Year() >= intYear) then intYear else agr.YearFrom()
      intUpto = if (period.Year() < intYear && agr.YearUpto() == 0) then (intYear-1) else agr.YearUpto()

      new SpanOfYears(intFrom, intUpto)

    initsSpan = SpanOfYears.CreateFromYear(0);
    validSpan = this.milestones.reduce(forPeriodAccumulator, initsSpan)

  toYearsIntervalList: ->
    nextListEnd = (from, year) ->
      if (year == 0)
        upto = SeqOfYears.END_YEAR_INTER
        [new SpanOfYears(from, upto)]
      else
        upto = Math.max(year - 1, from)
        [new SpanOfYears(from, upto), new SpanOfYears(year, 0)]

    makeListEnd = (preparedList) ->
      [..., lastHistoryPart] = preparedList
      if (lastHistoryPart.YearUpto() == 0)
        firstHistoryPart = preparedList.filter((y) -> y.YearUpto() != 0)
        lastHistoryFrom = lastHistoryPart.YearFrom()
        lastHistoryUpto = lastHistoryPart.YearFrom()

        return firstHistoryPart.concat [new SpanOfYears(lastHistoryFrom, lastHistoryUpto)]
      preparedList

    toListAccumulator = (agr, year) ->
      if (agr.length == 0)
        nextEmptyPartList = [new SpanOfYears(year, 0)]
      else
        firstPart = agr.filter((y) -> (y.YearUpto() != 0))
        [..., lastPart] = agr
        lastHistoryFrom = lastPart.YearFrom()
        nextSpanPartList = nextListEnd(lastHistoryFrom, year)
        firstPart.concat nextSpanPartList

    history = @milestones.reduce(toListAccumulator, [])
    makeListEnd(history)

module.exports = { MonthPeriod, SpanOfMonths, SpanOfYears, SeqOfYears }