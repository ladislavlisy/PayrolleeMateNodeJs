should = require('should')
Core = require('../../PayrolleeMate.Common/Core')

describe 'TestSymbolName', ->
  testSymbolCode1001 = 1001
  testSymbolCode2001 = 2001
  testSymbolCode3001 = 3001
  testSymbolCode4001 = 4001
  testSymbolCode5001 = 5001

  it 'Should_Compare_Different_Symbols_AsEqual', ->
    testSymbolOne = new Core.SymbolName(testSymbolCode1001, "Begining Symbol")
    testSymbolTwo = new Core.SymbolName(testSymbolCode1001, "Terminal Symbol")

    true.should.equal(testSymbolOne.isEqualToSymbol(testSymbolTwo))

  it 'Should_Compare_Different_Symbols_AsGreater', ->
    testSymbolOne = new Core.SymbolName(testSymbolCode1001, "Begining Symbol")
    testSymbolTwo = new Core.SymbolName(testSymbolCode5001, "Terminal Symbol")

    (testSymbolTwo.isEqualToSymbol(testSymbolOne)).should.equal false
    (testSymbolTwo.isGreaterToSymbol(testSymbolOne)).should.equal true

  it 'Should_Compare_Different_Symbols_AsLess', ->
    testSymbolOne = new Core.SymbolName(testSymbolCode1001, "Begining Symbol")
    testSymbolTwo = new Core.SymbolName(testSymbolCode5001, "Terminal Symbol")

    (testSymbolOne.isEqualToSymbol(testSymbolTwo)).should.equal false
    (testSymbolOne.isLessToSymbol(testSymbolTwo)).should.equal true

