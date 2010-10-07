var Count = require('./count').Count

var count = new Count
count.increment()
console.log(count.value())
