## parsing command arguments
for (arg in commandArgs(TRUE)) {
  eval(parse(text=arg))
}

## check if a given integer is prime
isPrime = function(n) {
  if (n <= 3) {
    return (TRUE)
  }
  if (any((n %% 2:floor(sqrt(n))) == 0)) {
    return (FALSE)
  }
  return (TRUE)
}

## estimate mean only using observation with prime indices
estMeanPrimes = function(x) {
  n = length(x)
  ind = sapply(1:n, isPrime)
  return(mean(x[ind]))
}

## simulate data
MSE <- function(est, true, N) {
  return(sum((est - true)^2)/N)
}

Sim <- function(seed, n, dist, rep) {
  set.seed(seed)
  if (dist == "gaussian"){
    x <- replicate(rep, rnorm(n))
  }
  else if (dist == "t1"){
    x <- replicate(rep, rt(n, df = 1))
  }
  else if (dist == "t5"){
    x <- replicate(rep, rt(n, df = 5))
  }
  PrimeAvg <- apply(x, 2, estMeanPrimes)
  SampAvg <- apply(x, 2, mean)
  result <- cbind(MSE(PrimeAvg, 0, rep), MSE(SampAvg, 0, rep))
  colnames(result) <- c("PrimeMSE", "SampMSE")
  return(result)
}


Sim(seed, n, dist, rep)

