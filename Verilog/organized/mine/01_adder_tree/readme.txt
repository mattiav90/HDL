- Naive chain:

Latency: 1 cycle
Critical path: N−1 adders


- Balanced tree:

Latency: 1 cycle
Critical path: log₂(N) adders

- Pipelined tree:

Latency: log₂(N) cycles
Critical path: 1 adder per stage (very high fmax)
Throughput: 1 result per clock once full.

