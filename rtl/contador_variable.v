/*

Nombre del archivo: contador_variable.v
Descripción: Este módulo implementa un contador variable que cuenta
ascendente o descendente según el modo seleccionado (modo). El ancho 
del contador está definido por el parámetro width_counter. Cuando la 
señal de habilitación (enable) está activada, el contador incrementa 
o decrementa en cada pulso de reloj. Cuando la cuenta alcanza el valor 
definido por la entrada (entrada) o el valor máximo permitido por el 
ancho del contador (modulo_good), se reinicia a cero. La salida cuenta 
representala cuenta actual, y la salida fin_cuenta indica si la cuenta 
ha alcanzado su valor final. 

*/
module contador_variable
	#( parameter width_counter	=	4)
	(	input clock,
		input reset,
		input [width_counter-1:0] entrada,
		input enable,
		input modo,
		output reg [width_counter-1:0] cuenta,
		output fin_cuenta	);
	
	localparam [width_counter-1:0] modulo_good = 2**width_counter - 1;
	
	wire [width_counter-1:0] cuenta_fin;
	// Determina si la cuenta final es la entrada directa o el módulo completo
	assign cuenta_fin	=	( modo==1'b1)?entrada:modulo_good;
	// Determina si la cuenta ha llegado al final y la habilitación está activa
	assign fin_cuenta	=	((cuenta==cuenta_fin) && (	enable	==	1'b1 )) ? 1'b1 : 1'b0;
	
	always @(posedge clock or negedge reset)
		if(!reset)
			cuenta<=0;
		else
			if(enable)
				if(cuenta==cuenta_fin)
					cuenta<=0;
					
				
				else
					cuenta<=(cuenta+1'b1);

endmodule
