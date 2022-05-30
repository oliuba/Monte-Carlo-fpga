# Monte-Carlo-fpga

This is a project for Architecture of Computer Systems course at second year of Computer Science program at Ukrainian Catholic University. The project aims to develop a FPGA-based accelerator to calculate integrals of two-dimentional function using Monte-Carlo integration method.

## Overview

**Monte Carlo methods**, or **Monte Carlo experiments**, are a broad class of computational algorithms that rely on repeated random sampling to obtain numerical results. The underlying concept is to use randomness to solve problems that might be deterministic in principle. They are often used in physical and mathematical problems and are most useful when it is difficult or impossible to use other approaches. Monte Carlo methods are mainly used in three problem classes: optimization, numerical integration, and generating draws from a probability distribution. 

  
 Despite its conceptual and algorithmic simplicity, the computational cost associated with a Monte Carlo simulation can be staggeringly high. In general the method requires many samples to get a good approximation, which may incur an arbitrarily large total runtime if the processing time of a single sample is high. Although this is a severe limitation in very complex problems, the embarrassingly parallel nature of the algorithm allows this large cost to be reduced (perhaps to a feasible level) through parallel computing strategies in local processors, clusters, cloud computing, GPU, FPGA etc.

Monte Carlo methods vary, but tend to follow a particular pattern:

    1. Define a domain of possible inputs
    2. Generate inputs randomly from a probability distribution over the domain
    3. Perform a deterministic computation on the inputs
    4. Aggregate the results
    
In particaler, to find a definite integral of function `f(x, y)` we have to:
    
    1. Limit function at the third axis
    2. Generate N triplets of points (x_i, y_i, t_i) that are uniformly randomly chosen from the limits of integration
    3. Calculate function in all (x_i, y_i) and determine now many points are under the graph
    4. Estimate the result of integration
    
 <p align="center">
  <img src="https://github.com/oliuba/Monte-Carlo-fpga/blob/main/images/plot.png" alt="Example function"/>
</p>

A **field-programmable gate array (FPGA)** is an integrated circuit designed to be configured by a customer or a designer after manufacturing – hence the term field-programmable. The FPGA configuration is generally specified using a hardware description language (HDL), similar to that used for an application-specific integrated circuit (ASIC). Circuit diagrams were previously used to specify the configuration, but this is increasingly rare due to the advent of electronic design automation tools.

FPGAs contain an array of programmable logic blocks, and a hierarchy of reconfigurable interconnects allowing blocks to be wired together. Logic blocks can be configured to perform complex combinational functions, or act as simple logic gates like AND and XOR. In most FPGAs, logic blocks also include memory elements, which may be simple flip-flops or more complete blocks of memory.[1] Many FPGAs can be reprogrammed to implement different logic functions, allowing flexible reconfigurable computing as performed in computer software.

FPGAs have a remarkable role in embedded system development due to their capability to start system software (SW) development simultaneously with hardware (HW), enable system performance simulations at a very early phase of the development, and allow various system partitioning (SW and HW) trials and iterations before final freezing of the system architecture.

## Implementation

Sources for FPGA were written in `SystemVerilog` and are located in [design](https://github.com/oliuba/Monte-Carlo-fpga/tree/main/design) directory. There are four files:

`lfsr.sv` — pseudo-random number generator. It is implemented using **Linear Feedback Shift Register**.

LFSR is a shift register whose input bit is a linear function of its previous state. The most commonly used linear function of single bits is
exclusive-or (XOR). Thus, an LFSR is most often a shift register whose input bit is driven by the XOR of some bits of the overall shift register value.
The initial value of the LFSR is called the seed, and because the operation of the register is deterministic, the stream of values produced by the register
is completely determined by its current (or previous) state. Likewise, because the register has a finite number of possible states, it must eventually
enter a repeating cycle. However, an LFSR with a well-chosen feedback function can produce a sequence of bits that appears random and has a very long 
cycle. Applications of LFSRs include generating pseudo-random numbers, pseudo-noise sequences, fast digital counters, and whitening sequences. Both 
hardware and software implementations of LFSRs are common. The mathematics of a cyclic redundancy check, used to provide a quick check against transmission
errors, are closely related to those of an LFSR. In general, the arithmetics behind LFSRs makes them very elegant as an object to study and implement. One
can produce relatively complex logics with simple building blocks.

`function.sv` —  function that we want to integrate.

`comparator.sv` — module for comparing `f(x_i, y_i)` and `t_i` to determine is the pseudo-random generated piont lies under the graph.

`fsm.sv` —  main module that implements logic of the program, is based on a **Finite State Mashine** that is desribed with the following state diagram:

<p align="center">
  <img src="https://github.com/oliuba/Monte-Carlo-fpga/blob/main/images/fsm.png" alt="Finite state machine"/>
</p>

## Usage

## Authors

[Olha Liuba](https://github.com/oliuba)

[Hanna Yershova](https://github.com/hannusia)

@ UCU, 2022
