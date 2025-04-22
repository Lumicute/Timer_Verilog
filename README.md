TIMER


Thiết kế mạch Timer dùng để định thời:

❑ Bộ định thời thực hiện đếm xuống từ thời gian ban đầu được người
dùng thiết lập trước cho đến khi thời gian = 0 thì dừng lại và báo hiệu
cho người dùng biết

❑ Hiển thị phút và giây trôi qua trên 4 LED 7 đoạn (2 LED hiển thị phút,
và 2 LED hiển thị giây)

❑ Khi thời gian định thời = 0 thì báo hiệu bằng cách nháy đèn (LED
điểm hoặc LED 7 đoạn)

❑ Cho phép người dùng thiết lập thời gian định thời ban đầu (tính theo
phút) bằng các công tắc (switch)

❑ Cho phép người dùng tạm ngưng bộ định thời, và sau đó tiếp tục việc
định thời

❑ Cho phép reset bộ định thời, sau khi reset giá trị hiển thị trên các LED
7 đoạn là giá trị thời gian cần định thời

❑ SV có thể tùy biến thiết kế theo ý thích để có kết quả thiết kế tốt nhất

Youtube: https://youtu.be/5qu6w7BbWvU?si=KWX-QWE1QhkpjOig



# Digital Timer Project

![Timer Circuit](https://via.placeholder.com/400x200?text=Timer+Circuit)  
*A digital countdown timer implemented in Verilog HDL*

## Table of Contents
- [Project Overview](#project-overview)
- [Features](#features)
- [Hardware Requirements](#hardware-requirements)
- [Module Architecture](#module-architecture)
- [Installation](#installation)
- [Usage](#usage)
- [Simulation Results](#simulation-results)
- [Team](#team)
- [License](#license)

## Project Overview
This project implements a fully functional digital countdown timer using Verilog HDL. The system was developed for the Digital Circuits and Systems course at the University of Science and Technology, The University of Danang.

Key specifications:
- Countdown range: 00:00 to 59:59 (MM:SS)
- 1Hz timing resolution
- Four 7-segment LED displays
- Visual and audible alarm indicators

## Features
✔ **Precise Timing**  
- 1Hz clock derived from 50MHz system clock
- Accurate minute/second counting

✔ **User Controls**  
- Time setting with increment/decrement buttons
- Start/Pause/Resume functionality
- System reset

✔ **Visual Feedback**  
- 4-digit 7-segment display (MM:SS)
- Blinking LED alarm at countdown completion
- Protection against invalid inputs

## Hardware Requirements
- FPGA Development Board (Xilinx/Altera)
- 4x Common Anode 7-segment displays
- 5x Tactile switches (Set+, Set-, Start, Pause, Reset)
- 1x Status LED
- 50MHz clock source

