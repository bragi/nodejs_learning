exports.Count = function() {
  count = 0
  
  this.increment = function() {
    count += 1
    return this
  }
  
  this.value = function() {
    return count
  }
}
