// Generated by CoffeeScript 1.9.3
(function() {
  var Periods, should;

  should = require('should');

  Periods = require('../../PayrolleeMate.Common/Periods');

  describe('TestSpanOfYears', function() {
    it('Should_Return_IntervalName_2013', function() {
      var testInterval, testName;
      testInterval = new Periods.SpanOfYears(2013, 2013);
      testName = testInterval.className();
      return "2013".should.equal(testName);
    });
    it('Should_Return_IntervalName_2011to2013', function() {
      var testInterval, testName;
      testInterval = new Periods.SpanOfYears(2011, 2013);
      testName = testInterval.className();
      return "2011to2013".should.equal(testName);
    });
    it('Should_Return_IntervalArray_2011_2015', function() {
      var expsIntervalArray, expsIntervalStrings, testChangeYears, testIntervalArray, testIntervalStrings, testYearArray;
      testChangeYears = [2011, 2012, 2014, 2016, 2017, 0];
      testYearArray = new Periods.SeqOfYears(testChangeYears);
      expsIntervalArray = [new Periods.SpanOfYears(2011, 2011), new Periods.SpanOfYears(2012, 2013), new Periods.SpanOfYears(2014, 2015), new Periods.SpanOfYears(2016, 2016), new Periods.SpanOfYears(2017, 2099)];
      testIntervalArray = testYearArray.yearsIntervalList();
      expsIntervalStrings = expsIntervalArray.toString();
      testIntervalStrings = testIntervalArray.toString();
      return true.should.equal(expsIntervalStrings === testIntervalStrings);
    });
    it('Should_Return_Interval_2011_For_Period_2011', function() {
      var expsInterval, testChangeYears, testInterval, testPeriod, testYearArray;
      testChangeYears = [2011, 2012, 2014, 2016, 2017, 0];
      testYearArray = new Periods.SeqOfYears(testChangeYears);
      testPeriod = Periods.MonthPeriod.CreateFromYearAndMonth(2011, 1);
      expsInterval = new Periods.SpanOfYears(2011, 2011);
      testInterval = testYearArray.yearsIntervalForPeriod(testPeriod);
      return true.should.equal(expsInterval.isEqualToInterval(testInterval));
    });
    it('Should_Return_Interval_2016_For_Period_2016', function() {
      var expsInterval, testChangeYears, testInterval, testPeriod, testYearArray;
      testChangeYears = [2011, 2012, 2014, 2016, 2017, 0];
      testYearArray = new Periods.SeqOfYears(testChangeYears);
      testPeriod = Periods.MonthPeriod.CreateFromYearAndMonth(2016, 1);
      expsInterval = new Periods.SpanOfYears(2016, 2016);
      testInterval = testYearArray.yearsIntervalForPeriod(testPeriod);
      return true.should.equal(expsInterval.isEqualToInterval(testInterval));
    });
    it('Should_Return_Interval_2012to2013_For_Period_2013', function() {
      var expsInterval, testChangeYears, testInterval, testPeriod, testYearArray;
      testChangeYears = [2011, 2012, 2014, 2016, 2017, 0];
      testYearArray = new Periods.SeqOfYears(testChangeYears);
      testPeriod = Periods.MonthPeriod.CreateFromYearAndMonth(2013, 1);
      expsInterval = new Periods.SpanOfYears(2012, 2013);
      testInterval = testYearArray.yearsIntervalForPeriod(testPeriod);
      return true.should.equal(expsInterval.isEqualToInterval(testInterval));
    });
    return it('Should_Return_Interval_2017to2099_For_Period_2018', function() {
      var expsInterval, testChangeYears, testInterval, testPeriod, testYearArray;
      testChangeYears = [2011, 2012, 2014, 2016, 2017, 0];
      testYearArray = new Periods.SeqOfYears(testChangeYears);
      testPeriod = Periods.MonthPeriod.CreateFromYearAndMonth(2018, 1);
      expsInterval = new Periods.SpanOfYears(2017, 2099);
      testInterval = testYearArray.yearsIntervalForPeriod(testPeriod);
      return true.should.equal(expsInterval.isEqualToInterval(testInterval));
    });
  });

}).call(this);

//# sourceMappingURL=TestSpanOfYears.js.map
