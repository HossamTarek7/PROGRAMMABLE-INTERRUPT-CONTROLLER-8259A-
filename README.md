# 8259 Programmable Interrupt Controller (PIC)

## Introduction

In the domain of Interrupt-Driven systems, the 8259 PIC assumes a central role by managing requests from peripheral equipment, evaluating their priority, and triggering CPU interrupts. Each peripheral device has a specialized "service routine."

Post-interrupt, the 8259 PIC guides the CPU using a "pointer" in the vectoring table, known as vectoring data.

Designed for real-time microcomputer systems, it adeptly manages eight levels of requests with provisions for seamless expandability, accommodating up to 64 additional 8259 PICs. System software handles its programming as an I/O peripheral.

## Features

- **Priority Management:** Evaluate and trigger interrupts based on priority.
- **Expandability:** Seamlessly connect up to 64 additional 8259 PICs for scalability.
- **Adaptability:** Configure priority modes dynamically to align with system requirements.

## Contributors

- Hossam Tarek  2000078
- Ahmed yousry 2000205
- SShadi Mohamed Alsaid	2000405
- Youssuf Ahmed Ebrahim	2001528
- Mohamed Fareed Mohamed	2000933

