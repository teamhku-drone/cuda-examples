#include<stdio.h>
#include<stdlib.h>

#define N 512 
  
__global__ void add(int *a, int *b, int *c) {
  c[blockIdx.x] = a[blockIdx.x] + b[blockIdx.x];
}

void initialize(int *a, int n) {
  for (int i=0; i<n; ++i) {
    a[i] = i;
  } 
}

int main(void) {
  int *a, *b, *c;
  int *d_a, *d_b, *d_c;
  int size = N * sizeof(int);

  // Allocate space for device copies of a, b, c
  cudaMalloc((void **)&d_a, size);
  cudaMalloc((void **)&d_b, size);
  cudaMalloc((void **)&d_c, size);

  // Allocate space for host copies of a, b, c and setup input values
  a = (int *)malloc(size);
  //random_ints(a, N);
  initialize(a, N);
  b = (int *)malloc(size);
  initialize(b, N);
  //random_ints(b, N);
  c = (int *)malloc(size);

  // * Copy inputs to device
  cudaMemcpy(d_a, a, size, cudaMemcpyHostToDevice);
  cudaMemcpy(d_b, b, size, cudaMemcpyHostToDevice);
  cudaMemcpy(d_c, c, size, cudaMemcpyHostToDevice);

  // Launch add() kernal on GPU with N blocks
  add<<<N,1>>>(d_a, d_b, d_c);

  // Copy result back to host
  cudaMemcpy(c, d_c, size, cudaMemcpyHostToHost);

  // Cleanup, the functions used in cuda compiler is different
  free(a);
  free(b);
  free(c);

  cudaFree(d_a);
  cudaFree(d_b);
  cudaFree(d_c);

  return 0;
}
