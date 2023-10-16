#include <wb.h>

//@@ Complete this function
__global__ void d_axpy(const float * x, float * y, float a, int len)
{
  int i = blockIdx.x*blockDim.x + threadIdx.x;
  if(i<len)
     y[i] = a* x[i] + y[i];
}

//Sequential Implementation
void h_axpy(const float * x, float * y, float a, int len) 
{
    for (int i = 0; i < len; i++) 
    {
        y[i] += a * x[i];
    }
}

int main(int argc, char **argv) {
  wbArg_t args;
  int inputLength;
  float *h_x;
  float *h_y;
  float a;
  float *d_x;
  float *d_y;

  args = wbArg_read(argc, argv);

  wbTime_start(Generic, "Importing data and creating memory on host");
  h_x =
      (float *)wbImport(wbArg_getInputFile(args, 0), &inputLength);
  h_y =
      (float *)wbImport(wbArg_getInputFile(args, 1), &inputLength);
  {
      int aLength;
      float * pA = (float *)wbImport(wbArg_getInputFile(args, 2), &aLength);
      a = *pA;

      free(pA);
  }

  wbTime_stop(Generic, "Importing data and creating memory on host");
  
  wbLog(TRACE, "The input length is ", inputLength);
  
  //@@ Allocate memory
  cudaMalloc((void **)&d_x,inputLength*sizeof(float));
  cudaMalloc((void **)&d_y,inputLength*sizeof(float));
  
  // Copy memory to the GPU
  cudaMemcpy(d_x,h_x,inputLength*sizeof(float),cudaMemcpyHostToDevice);
  cudaMemcpy(d_y,h_y,inputLength*sizeof(float),cudaMemcpyHostToDevice);
  
  //@@ Initialize the grid and block dimensions here  
   dim3 blockDim(32);
   dim3 gridDim(ceil(((float)inputLength)/((float)blockDim.x)));
  
  //@@ Performing CUDA compute
  wbTime_start(GPU, "Doing GPU Computation (memory + compute)");
  d_axpy<<<gridDim,blockDim>>>(d_x,d_y,a,inputLength);
  cudaDeviceSynchronize();
  wbTime_stop(GPU, "Doing GPU Computation (memory + compute)");
  
  //@@ Copy the GPU memory back to the CPU here  
  cudaMemcpy(h_y,d_y,inputLength*sizeof(float),cudaMemcpyDeviceToHost);
  
  //@@ Free the GPU memory here 
   cudaFree(d_x);
   cudaFree(d_y);

  // Verify correctness of the results
  wbLog(TRACE, "The result is ", h_y[0]);
  wbLog(TRACE, "The result is ", h_y[1]);
  wbLog(TRACE, "The result is ", h_y[2]);
  wbLog(TRACE, "The result is ", h_y[3]);
  wbLog(TRACE, "The result is ", h_y[4]);
  wbLog(TRACE, "The result is ", h_y[5]);
  wbLog(TRACE, "The result is ", h_y[6]);
  wbLog(TRACE, "The result is ", h_y[7]);
  wbLog(TRACE, "The result is ", h_y[8]);
  wbLog(TRACE, "The result is ", h_y[9]);
  
   wbSolution(args, h_y, inputLength);


  //Free the host memory
  free(h_x);
  free(h_y);

  return 0;
}
