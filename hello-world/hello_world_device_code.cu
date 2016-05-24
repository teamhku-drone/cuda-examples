#include<stdio.h>

// nvcc separate source code into device and host components

__global__ void mykernel(void) {
  // Device code is compiled by Nvidia compiler
  // This function is called from host code
}

int main(void) {
  // Host code goes here which is processed by standard host compiler
  // e.g. gcc

  // <<< >>> marks a call from host code to device code
  // a.k.a. kernal launch, return to the parameters (1,1)
  mykernel<<<1,1>>>();
  printf("Hello World!\n");
  return 0;
}
