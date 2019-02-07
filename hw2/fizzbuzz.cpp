//RCPP_fizzbuzz.cpp
#include <Rcpp.h>
#include <iostream>
using namespace Rcpp;
using namespace std;

// [[Rcpp::export]]
void RCPP_fizzbuzz(vector<int>& input){
  for(unsigned i=1; i <= input.size();i++){
    if(i % 15 == 0){
      Rcout << "FizzBuzz" << endl;
    }
    else if(i % 3 == 0){
      Rcout << "Fizz" << endl;
    }
    else if(i % 5 == 0){
      Rcout << "Buzz" << endl;
    }
    else{
      Rcout << (i) << endl;
    }
  }
}