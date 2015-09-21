should = require('should')
Periods = require('../../PayrolleeMate.Common/Periods')

describe 'TestSpanOfYears', ->
    it 'Should_Return_IntervalName_2013', ->
      testInterval = new Periods.SpanOfYears(2013, 2013)
      testName = testInterval.className()
      "2013".should.equal(testName)
 
    it 'Should_Return_IntervalName_2011to2013', ->
      testInterval = new Periods.SpanOfYears(2011, 2013)
      testName = testInterval.className()
      "2011to2013".should.equal(testName)

    it 'Should_Return_IntervalArray_2011_2015', ->
      testChangeYears = [2011, 2012, 2014, 2016, 2017, 0]
      testYearArray = new Periods.SeqOfYears(testChangeYears)
      expsIntervalArray = [
        new Periods.SpanOfYears(2011, 2011),
        new Periods.SpanOfYears(2012, 2013),
        new Periods.SpanOfYears(2014, 2015),
        new Periods.SpanOfYears(2016, 2016),
        new Periods.SpanOfYears(2017, 2099)]
      testIntervalArray = testYearArray.yearsIntervalList()
      expsIntervalStrings = expsIntervalArray.toString()
      testIntervalStrings = testIntervalArray.toString()
      true.should.equal(expsIntervalStrings == testIntervalStrings)

    it 'Should_Return_Interval_2011_For_Period_2011', ->
      testChangeYears = [2011, 2012, 2014, 2016, 2017, 0]
      testYearArray = new Periods.SeqOfYears(testChangeYears)
      testPeriod = Periods.MonthPeriod.CreateFromYearAndMonth(2011, 1)
      expsInterval = new Periods.SpanOfYears(2011, 2011)
      testInterval = testYearArray.yearsIntervalForPeriod(testPeriod)
      true.should.equal(expsInterval.isEqualToInterval(testInterval))

    it 'Should_Return_Interval_2016_For_Period_2016', ->
      testChangeYears = [2011, 2012, 2014, 2016, 2017, 0]
      testYearArray = new Periods.SeqOfYears(testChangeYears)
      testPeriod = Periods.MonthPeriod.CreateFromYearAndMonth(2016, 1)
      expsInterval = new Periods.SpanOfYears(2016, 2016)
      testInterval = testYearArray.yearsIntervalForPeriod(testPeriod)
      true.should.equal(expsInterval.isEqualToInterval(testInterval))

    it 'Should_Return_Interval_2012to2013_For_Period_2013', ->
      testChangeYears = [2011, 2012, 2014, 2016, 2017, 0]
      testYearArray = new Periods.SeqOfYears(testChangeYears)
      testPeriod = Periods.MonthPeriod.CreateFromYearAndMonth(2013, 1)
      expsInterval = new Periods.SpanOfYears(2012, 2013)
      testInterval = testYearArray.yearsIntervalForPeriod(testPeriod)
      true.should.equal(expsInterval.isEqualToInterval(testInterval))

    it 'Should_Return_Interval_2017to2099_For_Period_2018', ->
      testChangeYears = [2011, 2012, 2014, 2016, 2017, 0]
      testYearArray = new Periods.SeqOfYears(testChangeYears)
      testPeriod = Periods.MonthPeriod.CreateFromYearAndMonth(2018, 1)
      expsInterval = new Periods.SpanOfYears(2017, 2099)
      testInterval = testYearArray.yearsIntervalForPeriod(testPeriod)
      true.should.equal(expsInterval.isEqualToInterval(testInterval))
