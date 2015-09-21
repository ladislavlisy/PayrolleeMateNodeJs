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
    if (@periodFrom.isEqualToPeriod(other.periodFrom)) then @periodUpto.compareToPeriod(other.periodUpto)
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

  @Empty: ->
    new SpanOfYears(0, 0)

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

  @transformZeroToUpto: (year) ->
    if year == 0 then SeqOfYears.END_YEAR_ARRAY else year

  @transformZeroYear: (year1, year2) ->
    compYear1 = SeqOfYears.transformZeroToUpto year1
    compYear2 = SeqOfYears.transformZeroToUpto year2
    (compYear1 - compYear2)

  @transformYearsToSpans: (yearFrom, yearUpto) ->
    tranUpto = SeqOfYears.transformZeroToUpto(yearUpto)
    spanUpto = if tranUpto == yearFrom then tranUpto else (tranUpto - 1)
    new SpanOfYears(yearFrom, spanUpto)

  constructor: (years) ->
    zip = (xss, yss) -> xss.map (_, i) -> [xss[i], yss[i]]
    sortedYears = years.slice(0)
    sortedYears.sort(SeqOfYears.transformZeroYear)
    beginsYears = sortedYears.filter((x) -> x != 0)
    finishYears = sortedYears[1..sortedYears.length]
    sortedZiped = zip(beginsYears, finishYears)
    this.milestones = sortedZiped.map((x) => SeqOfYears.transformYearsToSpans(x[0], x[1]));

  yearsIntervalForPeriod: (period) ->
    selectForPeriod = (span, period) ->
      period.Year() >= span.YearFrom() && period.Year() <= span.YearUpto()

    validSpan = this.milestones.filter((x) -> selectForPeriod(x, period))
    validSpan[0] ?= SpanOfYears.Empty()

  yearsIntervalList: ->
    @milestones.slice(0)

module.exports = { MonthPeriod, SpanOfMonths, SpanOfYears, SeqOfYears }