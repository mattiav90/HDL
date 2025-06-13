
implementation of a Finite State Machine (FSM).
We'll implement a 4-state FSM that recognizes a specific input 
pattern: "010" pattern detector — the FSM outputs 1 when it 
detects the sequence:

0 -> 1 -> 0 on a serial input stream.


it will be imoplemented starting from a simple one and then
make it more efficient. 


after the first naive implementation, I can try to optimize it with 
this strategies:

- one hot encoding. Replace 2-bit state encoding with one-hot — faster in 
  FPGAs due to simpler logic.

- combine state + output logic.
  in low latency applications, pipeline multiple times will introduce
  more delay. if I care about latency and not throughput, which is the
  case for a FSM, then I dont want to pipeline it too much. 
  it make sense to pipeline only if I process a stream of data.

- another optimization that can be done is to use one hot encoding.
  using one hot encoding simplify the logic to check the state.
  not each bit tells the precise state the machine is in.
  instead with regular binary format more than one bit have to be
  controlled. 

  with a binary state
  (state == 2'b10) → 2-bit comparator = LUT + carry chain

  with a 1 hot state
  state[2]
  one wire, no logic needed.



  The benefit of one-hot encoding is:
  Not that it eliminates the clock latency, but
  That it allows higher max clock frequency (Fmax) because:
  Logic per state is simpler
  State decode is one wire, not a comparator
  Next state logic is shallower (less LUT depth)
  Fewer logic levels → better timing closure
  This means:
  If you need your FSM to react every 2.5 ns, not every 5 ns
  The one-hot version is more likely to meet that requirement

  


-- what if I dont want to 1 cycle delay ?
 then I can compute the match using combinatorial logic and assign the
 value directly. in this way I dont even have to wait for one clock
 cycle but the match will show up immediately. 

 I did 2 implementations of this pattern_fsm2 and pattern_fsm3.
 2) uses traight combinatorial logic in the output. that is fast but 
 might be not super stable and generate glitches.

 3) use combinatorial logic but assign the value to a register. 
 in this way some glitches are filtered away. putting a ff on the outptut
 is more safe. 

Output is glitch-free
Still responds instantly to pattern
 
