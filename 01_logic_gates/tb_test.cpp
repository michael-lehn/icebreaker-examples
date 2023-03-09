#include "Vtest.h"

#include <cstdlib>
#include <iomanip>
#include <iostream>
#include <verilated.h>
#include <verilated_vcd_c.h>

#define MAX_SIM_TIME 70

int
main(int argc, char **argv, char **env)
{
    Vtest *dut = new Vtest;

    Verilated::traceEverOn(true);
    VerilatedVcdC *m_trace = new VerilatedVcdC;
    dut->trace(m_trace, 5);
    m_trace->open("waveform.vcd");

    std::uint64_t sim_time = 0;

    while (sim_time < MAX_SIM_TIME) {
	switch (sim_time) {
	    case 5:
		dut->BTN1 = 1;
		dut->BTN2 = 0;
		break;
	    case 8:
		dut->BTN1 = 1;
		dut->BTN2 = 1;
		break;
	    case 11:
		dut->BTN1 = 0;
		dut->BTN2 = 1;
		break;
	    default:
		dut->BTN1 = 0;
		dut->BTN2 = 0;
	}
	dut->eval();

	m_trace->dump(sim_time);
	sim_time++;
    }

    m_trace->close();
    delete dut;
    exit(EXIT_SUCCESS);
}
