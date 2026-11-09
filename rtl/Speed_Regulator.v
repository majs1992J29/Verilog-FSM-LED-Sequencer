/*

Nombre del archivo: Speed_Regulator.v
Descripción: Archivo que junta la máquina de estados de mealy con el 
contador cuenta_up_down. 
Si se pulsa el KEY2 se debera incrementar el contador oCuenta
Si se pulsa el KEY1 se deberá decrementar el contador oCuenta
Si se pulsar el reset, se debera reiniciar oCuenta a 0

*/

module Speed_Regulator(iCLK,iRST_n,iKey1,iKey2,oCuenta);

    input iCLK;
    input iRST_n;
    input iKey2;
    input iKey1;

    output [3:0] oCuenta;
	 
	 wire ENABLE;
	 wire UP_DOWN;
	 wire TC;
	 
	 //Instanciacion de la máquina de estados mealy
	 FSM_speed_MEALY  FSM_speed_MEALY_T1 (   .iCLK(iCLK),
														  .iRST_n(iRST_n),
														  .iKey1(iKey1), 
														  .iKey2(iKey2), 
														  .oENABLE(ENABLE),
														  .oUP_DOWN(UP_DOWN));
														  
   //Instanciación del contador UP_DOWN
	count_UP_DOWN #(.fin_cuenta(16)) count_UP_DOWN_C1 
	(    .iCLK(iCLK),
		  .iRST_n(iRST_n),
		  .iENABLE(ENABLE),
		  .iUP_DOWN(UP_DOWN),
		  .oCOUNT(oCuenta),
		  .oTC(TC)
	); 
	 
endmodule
	 