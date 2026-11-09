/*

Nombre del archivo: count_param.v

Descripción: 
Diseño de un contador parametrizado que puede contar 
hacia arriba o hacia abajo, reiniciarse, generar una señal de salida 
"oTC" para indicar el final del conteo tanto hacia arriba como hacia
abajo, y un registro de salida con la cuenta.

Entradas:
-iCLK: señal de reloj que controla cuándo se actualiza el contador.
-iRST_n: señal de reinicio síncrona con alta prioridad y se activa a nivel bajo
-iENABLE: señal que habilita o deshabilita el contador
-iUP_DOWN: señal que controla la dirección del conteo, arriba=1;abajo=0

Salidas:
-oCOUNT: registro de salida que almacena el valor actual del contador
-oTC: señal que indica si se ha alcanzado el valor máximo o mínimo del contador 

*/



module count_param (iCLK,iRST_n,iENABLE,iUP_DOWN, oCOUNT, oTC);

	parameter fin_cuenta = 5000000;	
	parameter n	= $clog2(fin_cuenta-1); 				//determina el número de bits requeridos.
	
	input iCLK, iRST_n, iENABLE, iUP_DOWN;
	output reg [n-1:0] oCOUNT;
	output oTC;
	
	always @(posedge iCLK)
	
		if(!iRST_n)										  //reinicio sincrono, se activa en nivel bajo
			if (iUP_DOWN == 1'b1)
			oCOUNT <= {n{1'b0}};
			else
			oCOUNT <= fin_cuenta-1;
		else
		
			if(iENABLE == 1'b1)
				//cuenta hacia arriba
				if(iUP_DOWN == 1'b1)					 
					if(oCOUNT == fin_cuenta-1)
						oCOUNT <= {n{1'b0}};
					else
						oCOUNT <= oCOUNT + 1'b1;	
				else 
				//cuenta hacia abajo	
					if(oCOUNT == 1'b0)
						oCOUNT <= fin_cuenta-1;
					else
						oCOUNT <= oCOUNT - 1'b1;					
			
	assign oTC = ((iRST_n == 0) || (iENABLE == 0))? 1'b0: ((oCOUNT == fin_cuenta-1) && (iUP_DOWN == 1'b1))?1'b1: ((oCOUNT == 1'b0) && (iUP_DOWN == 1'b0))? 1'b1:1'b0;		

endmodule
