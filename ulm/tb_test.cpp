#include "Vtest.h"
#include "Vtest_test.h"
#include "Vtest_dev_rx_pipe.h"
#include "Vtest_uart_rx__B2580.h"

#include <cstdlib>
#include <iomanip>
#include <iostream>
#include <verilated.h>
#include <verilated_vcd_c.h>

#define MAX_SIM_TIME 70 
std::uint64_t sim_time = 0;
std::uint64_t posedge_cnt = 0;

int
main(int argc, char **argv, char **env)
{
    Vtest *dut = new Vtest;

    Verilated::traceEverOn(true);
    VerilatedVcdC *m_trace = new VerilatedVcdC;
    dut->trace(m_trace, 5);
    m_trace->open("waveform.vcd");

    while (sim_time < MAX_SIM_TIME) {
	dut->CLK ^= 1;

	dut->eval();
	if (dut->CLK == 1) {
	    posedge_cnt++;

	    switch (posedge_cnt) {
		// 0x31
		case 10:
		    dut->test->dev_rx_pipe0->uart_rx0->rx_ready = 1;
		    dut->test->dev_rx_pipe0->uart_rx0->rx_data = '3';
		    break;
		case 12:
		    dut->test->dev_rx_pipe0->uart_rx0->rx_ready = 1;
		    dut->test->dev_rx_pipe0->uart_rx0->rx_data = '1';
		    break;
		// 0x41
		case 14:
		    dut->test->dev_rx_pipe0->uart_rx0->rx_ready = 1;
		    dut->test->dev_rx_pipe0->uart_rx0->rx_data = '4';
		    break;
		case 16:
		    dut->test->dev_rx_pipe0->uart_rx0->rx_ready = 1;
		    dut->test->dev_rx_pipe0->uart_rx0->rx_data = '1';
		    break;
		// 0x00
		case 18:
		    dut->test->dev_rx_pipe0->uart_rx0->rx_ready = 1;
		    dut->test->dev_rx_pipe0->uart_rx0->rx_data = '0';
		    break;
		case 20:
		    dut->test->dev_rx_pipe0->uart_rx0->rx_ready = 1;
		    dut->test->dev_rx_pipe0->uart_rx0->rx_data = '0';
		    break;
		// 0x00
		case 22:
		    dut->test->dev_rx_pipe0->uart_rx0->rx_ready = 1;
		    dut->test->dev_rx_pipe0->uart_rx0->rx_data = '0';
		    break;
		case 24:
		    dut->test->dev_rx_pipe0->uart_rx0->rx_ready = 1;
		    dut->test->dev_rx_pipe0->uart_rx0->rx_data = '0';
		    break;

		case 26:
		    dut->test->dev_rx_pipe0->uart_rx0->rx_ready = 1;
		    dut->test->dev_rx_pipe0->uart_rx0->rx_data = '\n';
		    break;
	    }
	}

	m_trace->dump(sim_time);
	sim_time++;
    }

    m_trace->close();
    delete dut;
    exit(EXIT_SUCCESS);
}