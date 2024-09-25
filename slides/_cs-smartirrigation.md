# Watering Advice (2021-2022) [@quartieri2021effect]

:::: {.columns}
::: {.column width="50%"}

Given the following algorithm

    IF
        ((#BlueCells + #LightBlueCells)/(#Cells) < 0.50 &&
        (#BlueCells)/(#Cells) < 0.25 in the last 12h) &&
        precipitations < 7mm in the last 12h
    THEN 
        Recommended water = Evapotranspiration (ET) of the day before
    ELSE 
        Do nothing

We provide advice (recommendations) to technicians, who use (and adjust) the advice according to their experience.

- *Pro*: it relies on the experience of the technician
- *Con*:
  - can be stuck in sub-optimal irrigations (e.g., the system never converges to the optimal scenario) and requires human intervention
  - does not scale out to many fields; controlling 6 fields already entails a lot of work

:::
::: {.column width="50%"}

![](./img/pluto-optimal.svg)

:::
::::

# Automated Watering (2023-2024)

![PID](./img/PID.svg)

**PID**, a control loop mechanism employing feedback

- Calculates an error $e(t)$ as the difference between a desired setpoint (SP) and a measured process variable (PV)
    - $e(t) = r(t) - y(t)$
- Applies a correction based on *proportional*, *integral*, and *derivative* terms

# 

![PID](./img/PID.svg)

Correction is based on 3 terms: $u(t)=K_{p}e(t)+K_{i}\int_{0}^{t} e(\tau)\mathrm{d}\tau + K_{d}{\frac{\mathrm{d}e(t)}{\mathrm{d}t}}$

- **P**: proportional to the *current value* of the $SP − PV$ error $e(t)$
- **I**: integrates the *past values* of $e(t)$ over time to eliminate the residual error
    - Ensures that even small, persistent errors are eventually corrected
        - Imagine that the desired soil moisture is 60%, but the system is stuck at 57%
        - P (alone) might not be strong enough to bring the system to exactly 60%, leaving a small steady-state error
- **D**: estimate of *the future trend* of $e(t)$ based on its current rate of change
    - Adds stability to the system by damping the response and reducing oscillations
    - Acts like a brake, slowing down the response as the system nears the SP
- $K_p, K_i, K_d$ are non-negative coefficients for the proportional, integral, and derivative terms respectively
    - A higher $K_p$​ reduces the error faster but may lead to overshoot (going past the desired SP)
    - Constants are initially entered knowing the type of application and tuned by observing the system response