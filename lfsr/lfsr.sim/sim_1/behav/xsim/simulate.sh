#!/bin/bash -f
# ****************************************************************************
# Vivado (TM) v2021.2 (64-bit)
#
# Filename    : simulate.sh
# Simulator   : Xilinx Vivado Simulator
# Description : Script for simulating the design by launching the simulator
#
# Generated by Vivado on Wed Apr 27 22:38:12 EEST 2022
# SW Build 3367213 on Tue Oct 19 02:47:39 MDT 2021
#
# IP Build 3369179 on Thu Oct 21 08:25:16 MDT 2021
#
# usage: simulate.sh
#
# ****************************************************************************
set -Eeuo pipefail
# simulate design
echo "xsim test_behav -key {Behavioral:sim_1:Functional:test} -tclbatch test.tcl -log simulate.log"
xsim test_behav -key {Behavioral:sim_1:Functional:test} -tclbatch test.tcl -log simulate.log

