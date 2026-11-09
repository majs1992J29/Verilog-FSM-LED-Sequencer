/*

Nombre del archivo: tb_Speed_Regulator.v
Descripción: 

*/

`timescale 1 ns / 1 ps


module tb_Speed_Regulator  ; 
  localparam T=40;
  reg   [1:0] key2key1;
  reg CLK,RST;
  wire [3:0] cuenta;
  
  
Speed_Regulator T1
(
    .iCLK(CLK),.iRST_n(RST),.iKey1(key2key1[0]),.iKey2(key2key1[1]),
    .oCuenta(cuenta));



initial begin CLK = 1'b0;
forever #(T/2)  CLK = !CLK;
end

  
initial
begin
  $warning("SIMULANDO!!!");  	
  key2key1=2'b11;
  reset;
  CASO_1(); // Caso de Verificacion 1. SECUENCIA NORMAL 1 Aumento	
  #(T*5);
  CASO_2(); // Caso de Verificacion 2. SECUENCIA NORMAL 1 Disminucion	
  #(T*5);
  CASO_3(); // Caso de Verificacion 3. Casos especiales  
  #(T*5);
  CASO_4(); // Caso de Verificacion 4. Secuencia Normal 16 Aumentos
  #(T*5);
  CASO_5(); // Caso de Verificacion 5. Secuencia Normal 5 Disminuciones
  #(T*5);
  CASO_6(); // Caso de Verificacion 6. Reset
  #(T*5);
  $stop;
end                                                    

 
  
task CASO_1;
	begin
      @(negedge CLK) key2key1 = 2'b01;
      repeat (5) 	@(negedge CLK);
	  key2key1 = 2'b11;		
	end
endtask


task CASO_2;
	begin
      @(negedge CLK) key2key1 = 2'b10;
      repeat (5) 	@(negedge CLK);
	  key2key1 = 2'b11;		
	end
endtask
 
task CASO_3;
	begin
      @(negedge CLK) key2key1 = 2'b11;
      repeat (5) 	@(negedge CLK);
	  key2key1 = 2'b00;		
	end
endtask

task CASO_4;
	begin
	repeat (18) CASO_1;
	end
endtask


task CASO_5;
	begin
	repeat (5) CASO_2;
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

task CASO_6;
begin
  RST=1'b0;
  # (T);
  RST=1'b1;
  # (T*5); 
end
  endtask 
endmodule





