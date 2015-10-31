class SymbolName
  constructor: (code, name) ->
    @code = code
    @name = name

  Code: ->
    @code

  Name: ->
    @name

  description:  ->
    "#{@name}::#{@code}"

  compareToSymbol: (other) ->
    compareResult =
      if (@Code() == other.Code()) then 0
      else (@Code() - other.Code())

  isEqualToSymbol: (other) ->
    (@compareToSymbol(other)==0)

  isGreaterToSymbol: (other) ->
    (@compareToSymbol(other)>0)

  isLessToSymbol: (other) ->
    (@compareToSymbol(other)<0)

  toString:  ->
    @Code.toString()

module.exports = { SymbolName }