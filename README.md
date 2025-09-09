![](../../workflows/gds/badge.svg) ![](../../workflows/docs/badge.svg) ![](../../workflows/test/badge.svg) ![](../../workflows/fpga/badge.svg)

ring_counter_bc

Tiny Tapeout Verilog Project Template

Description

This project implements an 8-bit ring counter using Verilog and is structured as a Tiny Tapeout project. The ring counter cycles a single "1" through 8 bits, wrapping around once it reaches the end. It's ideal as a fundamental sequential design demonstration for educational or ASIC prototyping purposes.

This project is integrated into the Tiny Tapeout ecosystem, enabling automated ASIC design flow via GitHub Actions and OpenLane.

Setup Guide

Follow these steps to set up and modify the project for your needs:

Verilog Sources
Add or update your ring counter module(s) in the src/ directory.

Configuration (info.yaml)
Open and edit info.yaml to specify your design's entry point:

source_files: include your Verilog files.

top_module: set to your ring counter's top-level module name.

Documentation (docs/info.md)
Provide a clear description of how your design works, its functionality, and any usage notes.

Testbench Adaptation
Adjust or create testbench files in the test/ folder to simulate and validate your design. Reference test/README.md for guidance.

Automated Build
Once committed, the GitHub Actions pipeline will run the OpenLane toolchain to generate ASIC files automatically.

Resources

Tiny Tapeout Overview & Docs → 
GitHub

info.yaml migration tool → 
GitHub

OpenLane ASIC build integration → 
GitHub

