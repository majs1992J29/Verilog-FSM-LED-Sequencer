/*

Nombre del archivo: Juego_de_luces_con_velocidad_variable.v
Descripción: Integración de los diversos modulos para la creación
de un juego de luces con velocidad variable y controlable mediante
iKey1, iKey2 e iModo

*/


module Juego_de_luces_con_velocidad_variable(iENABLE,iModo,iCLK,iKey1,iKey2,iRST,oLEDG,oLEDR);

    input iCLK;
    input iRST;
    input iKey2;
    input iKey1;
	 input iENABLE;
	 input iModo;
	 
	 output [7:0] oLEDG;
	 output [7:0] oLEDR;
	 wire fin_cuenta;
	 wire fin_cuenta_2;
	 wire [3:0] cuenta;
	 
	// Módulo contador parametrizable
	count_param count_param_C1 
	(    .iCLK(iCLK),
		  .iRST_n(iRST),
		  .iENABLE(iENABLE),
		  .iUP_DOWN(iENABLE),
		  .oTC(fin_cuenta)
	); 
	 
	 // Módulo de la máquina( medveded) de estados para el juego de luces
	 FSM_luces_kit_medveded FSM_MEDVEDED
	 (.iCLK(iCLK), 
	 .iRST(iRST), 
	 .iENABLE(fin_cuenta_2), 
	 .oLEDgreen(oLEDG));

	 // Módulo contador variable para ajustar la velocidad del juego
	 contador_variable Contador_variable_1
	(	.clock(iCLK), 
	   .reset(iRST),
		.entrada(cuenta),
		.enable(fin_cuenta),
		.modo(iModo),
		.cuenta(oLEDR[7:4]),
		.fin_cuenta(fin_cuenta_2));
	
	// Módulo regulador de velocidad
	 Speed_Regulator Speed_regultaor_1
(		.iCLK(iCLK), 
	   .iRST_n(iRST),
		.iKey1(iKey1),
		.iKey2(iKey2),
    .oCuenta(cuenta));
	 
	// Asignación de las partes más bajas del registro de salida oLEDR 
	assign oLEDR[3:0] = cuenta;
 
 endmodule
	 