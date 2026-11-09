/*

Nombre del archivo: tb_FSM_Medveded.v
Descripción: Verificación de la máquina de estados de Medveded mediante
3 casos de prueba (comportamiento nominal, disable del enable y reset)

*/

`timescale 1 ns / 1 ps


module tb_FSM_Medveded  ; 
  localparam T=40;
  reg CLK,RST,enable;
  wire [7:0] oLEDgreen;
  
 //DUT
FSM_luces_kit_medveded T2
(
    .iCLK(CLK),.iRST(RST),.iENABLE(enable),
    .oLEDgreen(oLEDgreen));

 

initial begin CLK = 1'b0;
forever #(T/2)  CLK = !CLK;
end

  
initial
begin
  $warning("SIMULANDO!!!");  	
  enable=1'b0;
  reset;
  CASO_1(); // Caso de Verificacion 1. SECUENCIA Nominal	
  #(T*5);
  CASO_2(); // Caso de Verificacion 2. Quitar el Enable
  #(T*5);
    CASO_3(); // Caso de Verificacion 2. Quitar el Enable
  #(T*5);
  $stop;
end                                                    

 
  
task CASO_1; //caso 1 comportamiento nominal
	begin
      enable= 1'b1;
      repeat (40) 	@(negedge CLK);
		enable= 1'b0;
	end
endtask


task CASO_2; //caso 2 quitar enable
	begin
      enable= 1'b0;
      repeat (5) 	@(negedge CLK);
		enable= 1'b1;
	end
endtask
task CASO_3; //caso 3 reset
	begin
      RST=1'b0;
      repeat (2) 	@(negedge CLK);
		RST=1'b1;
	end
endtask
task reset;
begin
  RST=1'b1;
  # (T);  
  RST=1'b0;
  # (T);
  RST=1'b1;
  # (T*5); 
end
  endtask
endmodule





