Count = require('./count').Count

count = new Count

count.increment()
console.log(count.value())
