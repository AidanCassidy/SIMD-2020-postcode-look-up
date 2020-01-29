#'RIGHT' function extracts the last character from postcode string

RIGHT = function(x,n){
  substring(x,nchar(x)-n+1)
}