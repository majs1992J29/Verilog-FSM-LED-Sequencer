/*

Nombre del archivo: FSM_luces_kit_medveded.v
Descripción: Máquina de estados de medveded que encendera led diferente
en cada estado (haciendo una escalera de subida/bajada) 

*/
module FSM_luces_kit_medveded(iCLK, iRST, iENABLE, oLEDgreen);

	input iCLK, iRST ,iENABLE;
	output reg[7:0] oLEDgreen;
					
	reg  [7:0] state, next_state;
	
	//Definicion de los estados posibles de 1 a 14
	parameter [6:0] S1= 7'b0000000 ,
						 S2= 7'b1000000 ,
						 S3= 7'b1100000 ,
						 S4= 7'b1110000 ,
						 S5= 7'b1111000 , 
						 S6= 7'b1111100 ,
						 S7= 7'b1111110 ,
						 S8= 7'b1111111 ,
						 S9= 7'b0111111 ,
						 S10=7'b0011111 ,
						 S11=7'b0001111 ,
						 S12=7'b0000111 ,
						 S13=7'b0000011 ,
						 S14=7'b0000001 ;
	
	
	//Actualización del estado 
	always@(posedge iCLK or negedge iRST)
		begin
			if(!iRST)
				state <= S1;
			else
				state <= next_state;
		end
		
	//Funcionamiento del cambio de estados:
	//Si enable = 1 continuamos al siguiente estado,
	//Si enable = 0 nos quedamos el estado
	always @(state or iENABLE)
		begin
			case(state)
				S1: 	begin //estado1
							if(iENABLE)
								next_state = S2;
							else
								next_state = S1;
						end
				S2: 	begin //estado2
							if(iENABLE)
								next_state = S3;
							else
								next_state = S2;
						end
				S3: 	begin //estado3
							if(iENABLE)
								next_state = S4;
							else
								next_state = S3;
						end
				S4: 	begin //estado4
							if(iENABLE)
								next_state = S5;
							else
								next_state = S4;
						end 
				S5: 	begin //estado5
							if(iENABLE)
								next_state = S6;
							else
								next_state = S5;
						end
				S6: 	begin //estado6
							if(iENABLE)
								next_state = S7;
							else
								next_state = S6;
						end
				S7: 	begin //estado7
							if(iENABLE)
								next_state = S8;
							else
								next_state = S7;
						end
				S8: 	begin //estado8
							if(iENABLE)
								next_state = S9;
							else
								next_state = S8;
						end
				S9: 	begin //estado9
							if(iENABLE)
								next_state = S10;
							else
								next_state = S9;
						end
				S10: 	begin //estado10
							if(iENABLE)
								next_state = S11;
							else
								next_state = S10;
						end
				S11: 	begin //estado11
							if(iENABLE)
								next_state = S12;
							else
								next_state = S11;
						end
				S12: 	begin //estado12
							if(iENABLE)
								next_state = S13;
							else
								next_state = S12;
						end	
				S13: 	begin //estado13
							if(iENABLE)
								next_state = S14;
							else
								next_state = S13;
						end 
				S14: 	begin //estado14
							if(iENABLE)
								next_state = S1;
							else
								next_state = S14;
						end
						
				default: 
						next_state =  S1;

			endcase
		end

	//Actualización de la salida en funcion del estado (1 led encendido cada vez)
    always @(state)
		begin
			case (state)
				S1 : 	oLEDgreen = 8'b10000000;//1	
				S2 : 	oLEDgreen = 8'b01000000;//2
				S3 : 	oLEDgreen = 8'b00100000;//3
				S4 : 	oLEDgreen = 8'b00010000;//4
				S5 : 	oLEDgreen = 8'b00001000;//5
				S6 : 	oLEDgreen = 8'b00000100;//6
				S7 : 	oLEDgreen = 8'b00000010;//7
				S8 : 	oLEDgreen = 8'b00000001;//8
				S9 : 	oLEDgreen = 8'b00000010;//9
				S10 : oLEDgreen = 8'b00000100;//10
				S11 : oLEDgreen = 8'b00001000;//11
				S12 : oLEDgreen = 8'b00010000;//12
				S13 : oLEDgreen = 8'b00100000;//13
				S14 : oLEDgreen = 8'b01000000;//14	
				
				default
						oLEDgreen = 8'b00000000;
			endcase
		end

endmodule
