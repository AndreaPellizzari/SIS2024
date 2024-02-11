module MorraCinese(
  input wire [1:0] primo,
  input wire [1:0] secondo,
  input wire inizio,
  input wire clk,
  output reg [1:0] manche,
  output reg [1:0] partita
);
  
  reg[4:0] i = 5'b00000;
  reg check = 1'b0;
  typedef enum logic [2:0]{
    Inizio,
    Scelta,
    Primo1 = 3'b010,
    Primo2 = 3'b011,
    Primo_1 = 3'b100,
    Primo_2 = 3'b101,
    Pareggio = 3'b110,
    End = 3'b111
  } State;
  
  State stato = Inizio;
  State statoprossimo = Scelta;
  reg[4:0] maxpartite = 5'b00000;
  reg[1:0] lastmove = 2'b00;
  reg[1:0] lastwinner = 2'b00;
  
  reg[1:0] primopass = 2'b00;
  reg[1:0] secondopass = 2'b00;
  
  function [1:0] vincita(reg [1:0] primo, reg [1:0] secondo);
    if((primo == 2'b10 && secondo == 2'b01) || (primo == 2'b11 && secondo == 2'b10) || (primo == 2'b01 && secondo == 2'b11))
      begin
        return 2'b01;
      end
    else if(primo == secondo)
      begin 
        return 2'b11;
      end
    else
      begin
        return 2'b10;
      end
  endfunction
  
  always @(primopass, secondopass, inizio) 
    begin: FSM
      case(stato)
        Inizio: begin
          if(inizio)
            begin
              manche = 2'b00;
              partita = 2'b00;
              statoprossimo = Inizio;
            end
          else 
            begin 
              manche = 2'b00;
              partita = 2'b00;
              statoprossimo = Scelta;
            end
            manche = 2'b00;
            partita = 2'b00;
        end
        Scelta: begin
            if(inizio)
              begin
                manche = 2'b00;
                partita = 2'b00;
                statoprossimo = Inizio;
              end
            else begin
              manche = vincita(primopass, secondopass);
              case(manche)
                2'b01: statoprossimo = Primo1;
                2'b10: statoprossimo = Primo_1;
                2'b11: statoprossimo = Pareggio;
                2'b00: statoprossimo = stato;
              endcase
            end
        end
        Primo1: begin
          if(inizio)
            begin
              manche = 2'b00;
              partita = 2'b00;
              statoprossimo = Inizio;
            end
          else begin
              if(primopass == 2'b00 && secondopass == 2'b00) begin
                manche = 2'b00;
                partita = 2'b11;
                statoprossimo = End;
              end
              else if(primopass == 2'b00) begin
                manche = 2'b00;
                statoprossimo = stato;
              end
              else begin
                manche = vincita(primopass, secondopass);
                if(check == 2'b0) begin
                  case(manche)
                    2'b01: statoprossimo = Primo2;
                    2'b10: statoprossimo = Pareggio;
                    2'b11: statoprossimo = stato;
                    2'b00: statoprossimo = stato;
                  endcase
                end
                else begin
                  case(manche)
                    2'b01: begin statoprossimo = End; partita = 2'b01; end
                    2'b10: statoprossimo = Pareggio;
                    2'b11: statoprossimo = stato;
                    2'b00: statoprossimo = stato;
                  endcase
                end
              end
           end
        end
        Primo2: begin
            if(inizio)
              begin
                manche = 2'b00;
                partita = 2'b00;
                statoprossimo = Inizio;
              end
            else begin
              if(primopass == 2'b00 && secondopass ==2'b00)
                begin
                  manche = 2'b11;
                  statoprossimo = End;
                end
              if(primopass == 2'b00) begin
                manche = 2'b00;
                statoprossimo = stato;
              end
              else begin
                manche = vincita(primopass, secondopass);
                  case(manche)
                    2'b01: begin statoprossimo = End; partita = 2'b01; end
                    2'b10: statoprossimo = Primo1;
                    2'b11: statoprossimo = stato;
                    2'b00: statoprossimo = stato;
                  endcase
              end
            end
          end
        Pareggio:
          begin
            if(inizio)
              begin
                manche = 2'b00;
                partita = 2'b00;
                statoprossimo = Inizio;
              end
            else begin
              if((primopass == 2'b00) && (secondopass == 2'b00)) begin
                manche = 2'b00;
                partita = 2'b11;
                statoprossimo = End;
              end
              else if(primopass == 2'b00) begin
                manche = 2'b00;
                statoprossimo = stato;
              end
              else begin
                manche = vincita(primopass, secondopass);
                  case(manche)
                    2'b01: statoprossimo = Primo1;
                    2'b10: statoprossimo = Primo_1;
                    2'b11: statoprossimo = stato;
                    2'b00: statoprossimo = stato;
                  endcase
              end
            end
          end
        Primo_1:
          begin
            if(inizio)
              begin
                manche = 2'b00;
                partita = 2'b00;
                statoprossimo = Inizio;
              end
            else begin
              if(primopass == 2'b00 && secondopass == 2'b00) begin
                manche = 2'b00;
                partita = 2'b11;
                statoprossimo = End;
              end
              else if(primopass == 2'b00) begin
                manche = 2'b00;
                statoprossimo = stato;
              end
              else begin
                manche = vincita(primopass, secondopass);
                if(check == 2'b0) begin
                  case(manche)
                    2'b01: statoprossimo = Pareggio;
                    2'b10: statoprossimo = Primo_2;
                    2'b11: statoprossimo = stato;
                    2'b00: statoprossimo = stato;
                  endcase
                end
                else begin
                  case(manche)
                    2'b10: begin statoprossimo = End; partita = 2'b10; end
                    2'b01: statoprossimo = Pareggio;
                    2'b11: statoprossimo = stato;
                    2'b00: statoprossimo = stato;
                  endcase
                end
              end
            end
          end
        Primo_2:
          begin
            if(inizio)
              begin
                manche = 2'b00;
                partita = 2'b00;
                statoprossimo = Inizio;
              end
            else begin
              if(primopass == 2'b00 && secondopass ==2'b00)
                begin
                  manche = 2'b11;
                  statoprossimo = End;
                end
              if(primopass == 2'b00) begin
                manche = 2'b00;
                statoprossimo = stato;
              end
              else begin
                manche = vincita(primopass, secondopass);
                  case(manche)
                    2'b10: begin statoprossimo = End; partita = 2'b10; end
                    2'b01: statoprossimo = Primo_1;
                    2'b11: statoprossimo = stato;
                    2'b00: statoprossimo = stato;
                  endcase
              end
            end
          end
        End:
          begin
            if(inizio == 2'b1)
              begin
                statoprossimo = Inizio;
              end
            else
              begin
              statoprossimo = stato;
              end
            partita = 2'b00;
            manche = 2'b00;
          end
      endcase
    end
        
  always @(posedge clk) 
    begin: Datapath
      //Se STATTO è uguale a inizio, la partita è appena cominciata.
      if(stato == Inizio)
        begin
          maxpartite = {primo, secondo} + 3'b100;
          i = 5'b00000;
          check = 2'b0;
          lastwinner = 2'b00;
          lastmove = 2'b00;
          stato = Inizio;
          statoprossimo = Scelta;
        end
      //Se i è maggiore di maxpartite, la partita è finita.
      else if(i >= maxpartite)
        begin
          primopass = 2'b00;
          secondopass = 2'b00;
        end
      //La partita è ancora in gioco
      else
        begin
		  lastwinner = manche;
          case(lastwinner)
            2'b00: lastmove = lastmove;
            2'b01: lastmove = primopass;
            2'b10: lastmove = secondopass;
            2'b11: lastmove = lastmove;
      	  endcase
          primopass = primo;
          secondopass = secondo;
          if(i > 3)
            begin
              check = 2'b1;
            end 
          //Se una delle mosse è invalida
          if((lastwinner == 2'b01 && lastmove == primo) || (lastwinner == 2'b10 && lastmove == secondo))
            begin
              primopass = 2'b00;
              secondopass = secondo;
            end
          //Se la mossa è valida, conteggio la partita.
          else
            begin
              i = i+1;
            end
    	end
    end
  
  always @(posedge clk)
    begin
      stato = statoprossimo;
    end
    
  always @(posedge inizio) 
    begin: Reset
      statoprossimo = Inizio;
    end
endmodule
           