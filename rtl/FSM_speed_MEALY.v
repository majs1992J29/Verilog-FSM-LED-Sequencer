/*

Nombre del archivo: FSM_speed_MEALY.v
Descripción: Máquina de estados que activará oEnable y oUP_Down en 
función de iKEy1 y iKEY2.
En caso de Reset volverá a su estado incial.
Si iKEY1 y IKEY2 se activan a la vez, no se activará el oEnable.
Si iKey1 se activa una vez (o se mantiene) se activara oEnable y oUP_Down
a Down (0) durante un periodo de reloj.
Si iKey2 se activa una vez (o se mantiene) se activara oEnable y oUP_Down
a UP (1) durante un periodo de reloj.


*/

module FSM_speed_MEALY (iCLK,iRST_n,iKey1,iKey2,oENABLE,oUP_DOWN);

	input iCLK;
	input iRST_n;
	input iKey2;
	input iKey1;

	output oENABLE;
	output oUP_DOWN;

	wire [1:0] inputs;
	reg  [1:0] outputs;
  
	// Asignación de las salidas basadas en el estado actual
	assign inputs={iKey2,iKey1};
	assign oENABLE=outputs[1];
	assign oUP_DOWN=outputs[0];

	// Registro que almacena el estado actual y siguiente del sistema de estados
	reg [1:0] state,  next_state;

	// Definición de parámetros para los estados
	localparam state0=2'b00,state1=2'b01,state2=2'b10,state3=2'b11;

	// Máquina de estados Mealy para controlar las salidas basadas en las entradas y el estado actual
	always @(posedge iCLK or negedge iRST_n)
      if (!iRST_n) 
         state <= state0;
       else 
         state <= next_state;
        
    

	 // Lógica de transición de estados basada en las entradas y el estado actual
	always@(inputs or state)
		case(state)
			state0: if (inputs == 2'b01)  next_state = state1; 
					  else if (inputs == 2'b10) next_state=state2;
					  else next_state = state;
			state1: if (inputs == 2'b01) next_state = state3;
					  else next_state = state0;
			state2: if (inputs == 2'b10) next_state = state3;
					  else next_state = state0;
			state3: if (inputs == 2'b00 || inputs == 2'b11) next_state = state0;
					  else next_state = state;
			default: next_state = state;
		endcase
	 
	 
	 // Asignación de las salidas basadas en el estado actual
	always @(inputs or state)
		case (state)
			state0: outputs = 2'b0x;
			state1: outputs = 2'b11;
			state2: outputs = 2'b10;
			state3: outputs = 2'b0x;
			default: outputs = 2'b0x;
		endcase	
				
endmodule
