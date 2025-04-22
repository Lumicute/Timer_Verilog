# Thiết kế mạch Timer dùng để định thời:

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



# Timer System Design and Implementation on FPGA

## Project Overview

This project involves the design and implementation of a digital timer system on an FPGA, developed as part of the "Design of Digital Circuits and Systems" course at the University of Danang, University of Science and Technology. The timer supports countdown functionality, displaying minutes and seconds on four seven-segment LEDs, with user controls for setting the initial time, pausing, resuming, resetting, and an alarm feature indicated by a blinking LED when the countdown reaches zero. The system is implemented in Verilog and verified using ModelSim simulations.

## Repository Contents

- **Verilog Files**:
  - `FSM_timer_final.v`: Top-level module integrating all sub-modules (Listing in Report, Page 7).
  - `FSM_timer_minsec.v`: Finite State Machine for minute and second counting (Page 23).
  - `timer60.v`: Module for counting up to 60 (minutes or seconds) (Page 32).
  - `timer10.v`: Module for counting up to 10 (units or dozens) (Page 37).
  - `frequency_1hz.v`: Generates a 1 Hz clock from a 50 MHz input (Page 49).
  - `led_7_segment.v`: Decodes BCD to seven-segment display (Page 52).
  - `led_blinker.v`: Controls the blinking LED for the alarm (Page 55).
  - Testbenches for each module (e.g., `FSM_timer_final_tb.v`, `timer60_tb.v`, etc.).
- **Documentation**:
  - `Timer_report.pdf`: Comprehensive project report detailing requirements, design, simulation results, and conclusions.
- **Quartus II Project Files** (optional, not included by default):
  - `.qsf`: Pin assignments and project settings.
  - `.qpf`: Quartus project file.

## System Description

The timer system is composed of several sub-modules:

1. **Frequency Divider (`frequency_1hz`)**:
   - Converts a 50 MHz input clock to a 1 Hz clock for real-time counting.
2. **Finite State Machine (`FSM_timer_minsec`)**:
   - Manages the countdown logic, handling user inputs for setting time, start, pause, and reset.
   - Outputs minute and second values for display.
3. **Timer Modules (`timer60` and `timer10`)**:
   - `timer60`: Handles counting for minutes and seconds (0-59).
   - `timer10`: Manages units (0-9) and dozens (0-5) for BCD representation.
4. **Display Module (`led_7_segment`)**:
   - Converts BCD values to seven-segment LED signals for displaying minutes and seconds.
5. **Alarm Module (`led_blinker`)**:
   - Toggles an LED when the countdown reaches zero, indicating the alarm state.

### Features
- **Countdown**: Counts down from a user-set initial time (in minutes) to zero.
- **Display**: Shows minutes and seconds on four seven-segment LEDs (two for minutes, two for seconds).
- **User Inputs**:
  - Set initial time using switches (`set_time_increase`, `set_time_decrease`).
  - Start, pause, resume, and reset the timer.
- **Alarm**: Blinks an LED when the countdown reaches zero.
- **States**: Idle, counting, paused, stopped (with logic to prevent invalid operations, e.g., setting time during counting).

## Verification Setup

- **Simulation Tool**: ModelSim for functional verification.
- **Testbenches**:
  - Each module includes a testbench to verify functionality (e.g., `FSM_timer_final_tb.v` tests the full system).
  - Test cases cover setting initial time, counting, pausing, resetting, and alarm triggering.
- **Simulation Results**:
  - Countdown sequences (e.g., 00:59 to 00:00) verified (Pages 16-20).
  - Seven-segment decoding validated (Page 17).
  - LED blinking confirmed when timer reaches zero.

## Setup Instructions

1. **Prerequisites**:
   - Install Quartus II (version 12.0 or later).
   - Install ModelSim for simulation.
   - FPGA board (e.g., Altera DE2, if targeting hardware implementation).
2. **Project Setup**:
   - Create a new Quartus II project:
     - Name: `Timer_FPGA`.
     - Device: Cyclone II (or compatible FPGA).
   - Add the provided Verilog files and testbenches.
   - Set `FSM_timer_final.v` as the top-level module.
3. **Pin Assignments** (for DE2 board, example):
   - `sys_clk`: PIN_AD15 (50 MHz clock).
   - `reset`: PIN_AA23 (SW[0]).
   - `set_time_increase`: PIN_T29 (KEY[0]).
   - `set_time_decrease`: PIN_T30 (KEY[1]).
   - `start`: PIN_U29 (KEY[2]).
   - `pause`: PIN_U30 (KEY[3]).
   - `min1_led[6:0]`, `min0_led[6:0]`, `sec1_led[6:0]`, `sec0_led[6:0]`: Assign to seven-segment display pins.
   - `blink_led`: PIN_AE23 (LEDR[0]).
   - Configure in Quartus II Pin Planner or edit the `.qsf` file.
4. **Simulation**:
   - Open ModelSim and compile all Verilog files.
   - Run the testbench (e.g., `FSM_timer_final_tb.v`) to verify functionality.
   - Check waveforms for countdown, LED outputs, and alarm behavior.
5. **Hardware Implementation** (optional):
   - Connect the FPGA board to the PC via USB Blaster.
   - Compile the project in Quartus II and program the FPGA.
   - Test by setting the initial time with switches, starting the countdown, and observing the seven-segment display and blinking LED.

## Results

- **Simulation**:
  - Successfully counts down from user-set values (e.g., 00:59 to 00:00).
  - Seven-segment displays correctly show minutes and seconds.
  - LED blinks when the timer reaches zero.
  - Pause and reset functions operate as expected.
- **Example**:
  - Set initial time to 2 minutes (02:00).
  - Countdown progresses to 00:00, with the LED blinking to indicate completion.

## Limitations

- **State Management**: Multiple states for counting may lead to resource inefficiency and potential output conflicts.
- **Input Controls**: Separate switches for start and pause could be combined for simplicity.
- **Scalability**: Limited to 99 minutes; larger ranges require modifications.
- **Clock Precision**: The 1 Hz clock assumes a stable 50 MHz input.

## Future Improvements

- **Optimization**: Simplify the finite state machine to reduce resource usage and avoid output conflicts.
- **Enhanced Features**:
  - Add repeat timers or multiple interval settings.
  - Support for hours in addition to minutes and seconds.
- **User Interface**: Develop a mobile app or graphical display for easier time setting.
- **Smart Integration**:
  - Combine with sensors (e.g., temperature, motion) for smart home applications.
  - Integrate with IoT for remote control and synchronization.
- **Energy Efficiency**: Explore solar-powered or low-power designs for sustainability.

## Applications

- **Household**: Timers for appliances (microwaves, washing machines).
- **Industrial**: Timing production line processes or maintenance schedules.
- **Transportation**: Countdown timers for traffic lights.
- **Education/Sports**: Timing exams or sports events.
- **Security**: Timed locks or alarm systems.

## References

- University of Washington. (2009). Finite State Machines (FSM) [Lecture slides]. Retrieved from https://courses.cs.washington.edu/courses/cse370/09wi/LectureSlides/18FSM.pdf.
- YouTube. CpE 100 Module 23: FSM Counters. Retrieved from https://www.youtube.com/watch?v=FmiyDP3O6ag.
- YouTube. [VLSIEO01] Bài 11 - Mô tả máy trạng thái (FSM) bằng Verilog. Retrieved from https://www.youtube.com/watch?v=I6TqiRhBank.

## Contributors

- Luong Nhu Quynh
- Vo Van Buu
- Tran Hoang Minh
- Nguyen Thi Tam
- Instructor: Huynh Viet Thang

