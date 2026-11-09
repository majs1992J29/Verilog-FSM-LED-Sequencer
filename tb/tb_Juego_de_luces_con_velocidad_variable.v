/*

Nombre del archivo: tb_Juego_de_luces_con_velocidad_variable.v
Descripción: test bencha para probar el juego de luces a dos velocidades

*/

`timescale 1 ns / 1 ps


module tb_Juego_de_luces_con_velocidad_variable  ; 
  localparam T=2;
  reg CLK,RST,enable,iKey2,iKey1,iModo;
	 
	 wire [7:0] oLEDG;
	 wire [7:0] oLEDR;
  //aqui instanciamos nuestro diseño bajo test (dut)
Juego_de_luces_con_velocidad_variable T1
(
    .iENABLE(enable),
	 .iModo(iModo),
	 .iCLK(CLK),
	 .iKey1(iKey1),
	 .iKey2(iKey2),
	 .iRST(RST),
    .oLEDG(oLEDG)
	 ,.oLEDR(oLEDR));

 

initial begin CLK = 1'b0;
forever #(T/2)  CLK = !CLK;
end

  
initial
begin
  $warning("SIMULANDO!!!");  	
  RST=1'b1;
  enable=1'b0;
  		iModo = 1'b1;
		iKey1=1'b0;
		iKey2=1'b0;
  # (T);  
  RST=1'b0;
  # (T);
  RST=1'b1;
  # (T*5);   
  CASO_1(); // Caso de Verificacion 1. SECUENCIA NORMAL	
  #(T*5);
  $stop;
end                                                    

 
  
task CASO_1;
	begin
      enable= 1'b1;

		repeat (5) 	@(negedge CLK);
		
		repeat (3) Bajar_velocidad;
	   repeat (500000000) 	@(negedge CLK);
		repeat (3) Subir_velocidad;
	   repeat (500000000) 	@(negedge CLK);

	end
endtask


task Subir_velocidad;
begin
		iKey2 = 1'b1;
		repeat (2) 	@(negedge CLK);
		iKey2 = 1'b0;
      repeat (2) 	@(negedge CLK);
		end
endtask


task Bajar_velocidad;
begin
		iKey1 = 1'b1;
		repeat (3) 	@(negedge CLK);
		iKey1 = 1'b0;
repeat (2) 	@(negedge CLK);
		end
endtask
 
endmodule





