#include <wb.h>

// Error check
#define cudaCheckError() {                                                                       \
        cudaError_t e=cudaGetLastError();                                                        \
        if(e!=cudaSuccess) {                                                                     \
            printf("Cuda failure %s:%d: '%s'\n",__FILE__,__LINE__,cudaGetErrorString(e));        \
            exit(EXIT_FAILURE);                                                                  \
        }                                                                                        \
    }
    
    

__global__ void vecAdd(float *in1, float *in2, float *out, int len) 
{
  //@@ Insert code to implement vector addition here
    
  int index = blockIdx.x*blockDim.x + threadIdx.x;
  
  if(index<len)
     out[index] = in1[index] + in2[index];
     
}


int main(int argc, char **argv) 
{

  wbArg_t args;    // used by library, to pass input variables(in1, in2, out) to the executable
  int inputLength;
  float *hostInput1;
  float *hostInput2;
  float *hostOutput;
  float *deviceInput1;
  float *deviceInput2;
  float *deviceOutput;

  args = wbArg_read(argc, argv);  // read data from the files (input1, input2, output)
  
  

  wbTime_start(Generic, "Importing data and creating memory on host");//-----------------------------------------// 
  //@@ Extract data and store in host variables (allocate and populate memory with values)
  // pass by reference for 'inputLength' so variable can be modified inside the function based on the Dataset used
   hostInput1 =
      (float *)wbImport(wbArg_getInputFile(args, 0), &inputLength);// -i (path0 on terminal)
   hostInput2 =
      (float *)wbImport(wbArg_getInputFile(args, 1), &inputLength);// -i (path1 on terminal)
   hostOutput = (float *)malloc(inputLength * sizeof(float));
  wbTime_stop(Generic, "Importing data and creating memory on host");//-----------------------------------------//
  
  

  wbLog(TRACE, "The input length is ", inputLength);
  
  

  wbTime_start(GPU, "Allocating GPU memory.");//--------------------------------------------------// 
  //@@ Allocate GPU memory here
   cudaMalloc((void **)&deviceInput1,inputLength*sizeof(float)); // predefined vars, so use pass by reference
   cudaMalloc((void **)&deviceInput2,inputLength*sizeof(float));
   cudaMalloc((void **)&deviceOutput,inputLength*sizeof(float));  
  wbTime_stop(GPU, "Allocating GPU memory.");//----------------------------------------------------// 



  wbTime_start(GPU, "Copying input memory to the GPU.");//------------------------------------------// 
  //@@ Copy memory to the GPU here
   cudaMemcpy(deviceInput1,hostInput1,inputLength*sizeof(float),cudaMemcpyHostToDevice);
   cudaMemcpy(deviceInput2,hostInput2,inputLength*sizeof(float),cudaMemcpyHostToDevice);
  wbTime_stop(GPU, "Copying input memory to the GPU.");//------------------------------------------// 



  //@@ Initialize the grid and block dimensions here
   dim3 blockDim(32);
   dim3 gridDim(ceil(((float)inputLength)/((float)blockDim.x)));
  


  wbTime_start(Compute, "Performing CUDA computation");//--------------------------------------------// 
  //@@ Launch the GPU Kernel here
   vecAdd<<<gridDim,blockDim>>>(deviceInput1,deviceInput2,deviceOutput,inputLength);
   cudaDeviceSynchronize(); 
  wbTime_stop(Compute, "Performing CUDA computation");//---------------------------------------------// 
  


  wbTime_start(Copy, "Copying output memory to the CPU");//------------------------------------------// 
  //@@ Copy the GPU memory back to the CPU here 
   cudaMemcpy(hostOutput,deviceOutput,inputLength*sizeof(float),cudaMemcpyDeviceToHost);
  wbTime_stop(Copy, "Copying output memory to the CPU");//-------------------------------------------// 



  wbTime_start(GPU, "Freeing GPU Memory");//--------------------------------------------------------// 
   //@@ Free the GPU memory here
   cudaFree(deviceInput1);
   cudaFree(deviceInput2);
   cudaFree(deviceOutput);
  wbTime_stop(GPU, "Freeing GPU Memory");//---------------------------------------------------------// 


  wbSolution(args, hostOutput, inputLength);//Compares with output in dataset
  

  free(hostInput1);
  free(hostInput2);
  free(hostOutput);

  cudaCheckError();
  return 0; 
  
}
