clc; clear all; close all;

len = 100;
count = 0;
startTime = time();

for i = 1:len
  if isprime(i)
    i
    count = count + 1;
  endif
endfor

endTime = time();

count
time = endTime - startTime
