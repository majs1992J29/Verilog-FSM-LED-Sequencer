/*

Nombre del archivo: count_UP_DOWN.v
Descripción: Contador que incrementara oCount si iEnable es activo y 
iUP_DOWN es UP (1) en cada subida de flanco de reloj.
El contador disminuirá oCount si iEnable es activo y iUP_DOWN es Down (0) 
en cada subida de flanco de reloj.
El contador se reiniciara a su valor 0 si se activa el reset.
El contador activara la señal oTC en caso de estar a 0 o en su máximo.

*/


module count_UP_DOWN(iCLK,iRST_n,iENABLE,iUP_DOWN, oCOUNT, oTC);

	parameter fin_cuenta = 16;
	parameter n	= $clog2(fin_cuenta);
	
	input iCLK, iRST_n, iENABLE, iUP_DOWN;
	output reg [n-1:0] oCOUNT;
	output oTC;
	
	always @(posedge iCLK or negedge iRST_n)
	
		if(!iRST_n)
			oCOUNT <= 1'b0 ;
		else
		
			if(iENABLE == 1'b1)
			
				if(iUP_DOWN == 1'b1)
					if(oCOUNT == fin_cuenta-1)
						oCOUNT <= oCOUNT;
					else
						oCOUNT <= oCOUNT + 1'b1;
				else 
					if(oCOUNT == 1'b0)
						oCOUNT <= oCOUNT;
					else
						oCOUNT <= oCOUNT - 1'b1;					
			
	assign oTC = ((iRST_n == 0) || (iENABLE == 0))? 1'b0: ((oCOUNT == fin_cuenta-1) && (iUP_DOWN == 1'b1))?1'b1: ((oCOUNT == 1'b0) && (iUP_DOWN == 1'b0))? 1'b1:1'b0;		
endmodule
