should = require('should')
Periods = require('../../PayrolleeMate.Common/Periods')

describe 'TestMonthPeriod', ->
  testPeriodCodeJan = 201401
  testPeriodCodeFeb = 201402
  testPeriodCode501 = 201501
  testPeriodCode402 = 201402

  it 'Should_Compare_Different_Periods_AsEqual_When_2014_01', ->
    testPeriodOne = new Periods.MonthPeriod (testPeriodCodeJan)
    testPeriodTwo = new Periods.MonthPeriod (testPeriodCodeJan)

    true.should.equal(testPeriodOne.isEqualToPeriod(testPeriodTwo))

  it 'Should_Compare_Different_Periods_AsEqual_When_2014_02', ->
    testPeriodOne = new Periods.MonthPeriod (testPeriodCodeFeb)
    testPeriodTwo = new Periods.MonthPeriod (testPeriodCodeFeb)

    true.should.equal(testPeriodOne.isEqualToPeriod(testPeriodTwo))

  it 'Should_Compare_Different_Periods_SameYear_AsGreater', ->
    testPeriodOne = new Periods.MonthPeriod (testPeriodCodeJan)
    testPeriodTwo = new Periods.MonthPeriod (testPeriodCodeFeb)

    (testPeriodTwo.isEqualToPeriod(testPeriodOne)).should.equal false
    (testPeriodTwo.isGreaterToPeriod(testPeriodOne)).should.equal true

  it 'Should_Compare_Different_Periods_SameYear_AsLess', ->
    testPeriodOne = new Periods.MonthPeriod (testPeriodCodeJan)
    testPeriodTwo = new Periods.MonthPeriod (testPeriodCodeFeb)

    (testPeriodOne.isEqualToPeriod(testPeriodTwo)).should.equal false
    (testPeriodOne.isLessToPeriod(testPeriodTwo)).should.equal true

  it 'Should_Compare_Different_Periods_SameMonth_AsGreater', ->
    testPeriodOne = new Periods.MonthPeriod (testPeriodCodeJan)
    testPeriodTwo = new Periods.MonthPeriod (testPeriodCode501)

    (testPeriodTwo.isEqualToPeriod(testPeriodOne)).should.equal false
    (testPeriodTwo.isGreaterToPeriod(testPeriodOne)).should.equal true

  it 'Should_Compare_Different_Periods_SameMonth_AsLess', ->
    testPeriodOne = new Periods.MonthPeriod (testPeriodCodeJan)
    testPeriodTwo = new Periods.MonthPeriod (testPeriodCode501)

    (testPeriodOne.isEqualToPeriod(testPeriodTwo)).should.equal false
    (testPeriodOne.isLessToPeriod(testPeriodTwo)).should.equal true

  it 'Should_Compare_Different_Periods_DifferentYear_AsGreater', ->
    testPeriodOne = new Periods.MonthPeriod (testPeriodCode402)
    testPeriodTwo = new Periods.MonthPeriod (testPeriodCode501)

    (testPeriodTwo.isEqualToPeriod(testPeriodOne)).should.equal false
    (testPeriodTwo.isGreaterToPeriod(testPeriodOne)).should.equal true

  it 'Should_Compare_Different_Periods_DifferentYear_AsLess', ->
    testPeriodOne = new Periods.MonthPeriod (testPeriodCode402)
    testPeriodTwo = new Periods.MonthPeriod (testPeriodCode501)

    (testPeriodOne.isEqualToPeriod(testPeriodTwo)).should.equal false
    (testPeriodOne.isLessToPeriod(testPeriodTwo)).should.equal true

  it 'Should_Return_Periods_Year_And_Month_2014_01', ->
    testPeriodOne = new Periods.MonthPeriod (testPeriodCodeJan)

    (testPeriodOne.Year()).should.equal (2014)
    (testPeriodOne.Month()).should.equal (1)

    (testPeriodOne.YearInt()).should.equal (2014)
    (testPeriodOne.MonthInt()).should.equal (1)

  it 'Should_Return_Periods_Year_And_Month_2014_02', ->
    testPeriodTwo = new Periods.MonthPeriod (testPeriodCodeFeb)

    (testPeriodTwo.Year()).should.equal (2014)
    (testPeriodTwo.Month()).should.equal (2)

    (testPeriodTwo.YearInt()).should.equal (2014)
    (testPeriodTwo.MonthInt()).should.equal (2)

  it 'Should_Return_Periods_Month_And_Year_Descriptions', ->
    test_period_jan = new Periods.MonthPeriod (testPeriodCodeJan)
    test_period_feb = new Periods.MonthPeriod (testPeriodCodeFeb)
    test_period_501 = new Periods.MonthPeriod (testPeriodCode501)
    test_period_402 = new Periods.MonthPeriod (testPeriodCode402)

    (test_period_jan.description()).should.equal ("January 2014")
    (test_period_feb.description()).should.equal ("February 2014")
    (test_period_501.description()).should.equal ("January 2015")
    (test_period_402.description()).should.equal ("February 2014")

