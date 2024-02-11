module Testbench();
  
  reg [1:0] primo;
  reg [1:0] secondo;
  reg clk;
  reg inizio;
  wire [1:0] manche;
  wire [1:0] partita;
  
  int fdi;
  int fdo;
  
  // Instanza del modulo da testare
  MorraCinese morra(
    .primo(primo),
    .secondo(secondo),
    .clk(clk),
    .inizio(inizio),
    .manche(manche),
    .partita(partita)
  );
  
  //instanza del clock
  always #5 clk = ~clk;
  
  initial begin
    clk = 0;
    $dumpfile("MorraCinese_TB.vcd");
    $dumpvars(1);
    fdo = $fopen("output_verilog.txt", "w");
    fdi = $fopen("testbench.script", "w");
    
    //vittoria di primo in 3 mosse (3 vittorie di fila)
    //$display("test 1");
    primo = 2'b10;
    secondo = 2'b00;
    inizio = 2'b0;
    printinput(); 
    #10;
    printoutput();
    
    primo = 2'b10;
    secondo = 2'b01;;
    printinput(); 
    #10;
    printoutput();
    
    primo = 2'b11;
    secondo = 2'b10;
    printinput(); 
    #10;
    printoutput();
    
    primo = 2'b01;
    secondo = 2'b11;
    printinput(); 
    #10;
    printoutput();
    
    //Reset
    $display("reset");
    inizio = 2'b1;
  	printinput(); 
    #10
    printoutput();
    
    //Vittoria di secondo in 3 mosse (3 vittorie di secondo di fila)
    //$display("\ntest 2");
    primo = 2'b10;
    secondo = 2'b00;
    inizio = 2'b0;
    printinput(); 
    #10
    printoutput();
    
    primo = 2'b01;
    secondo = 2'b10;
    printinput(); 
    #10;
    printoutput();
    
    primo = 2'b10;
    secondo = 2'b11;
    printinput(); 
    #10;
    printoutput();
    
    primo = 2'b11;
    secondo = 2'b01;
    printinput(); 
    #10;
    printoutput();
    
    //Reset
    //$display("reset");
    inizio = 2'b1;
  	printinput(); 
    #10
    printoutput();
    
    //TEST VITTORIA PLAYER 1 5-3 + MOSSA PRIMO INVALIDA
    //$display("\ntest 3");
    primo = 2'b01;
    secondo = 2'b00;
    inizio = 2'b0;
    printinput(); 
    #10;
    printoutput();
    
    //1-0
    primo = 2'b01;
    secondo = 2'b11;
    printinput(); 
    #10;
    printoutput();
    //2-0
    primo = 2'b11;
    secondo = 2'b10;
    printinput(); 
    #10;
    printoutput();
    //2-1
    primo = 2'b10;
    secondo = 2'b11;
    printinput(); 
    #10;
    printoutput();
    //2-2
    primo = 2'b11;
    secondo = 2'b01;
    printinput(); 
    #10;
    printoutput();
    //2-3
    primo = 2'b01;
    secondo = 2'b10;
    printinput(); 
    #10;
    printoutput();
    //3-3
    primo = 2'b10;
    secondo = 2'b01;
    printinput(); 
    #10;
    printoutput();
    //4-3
    primo = 2'b11;
    secondo = 2'b10;
    printinput(); 
    #10;
    printoutput();
    //4-3 INVALIDA
    primo = 2'b11;
    secondo = 2'b10;
    printinput(); 
    #10;
    printoutput();
    //5-3
    primo = 2'b01;
    secondo = 2'b11;
    printinput(); 
    #10;
    printoutput();
    
    
    //Reset
    $display("reset");
    inizio = 2'b1;
  	printinput(); 
    #10
    printoutput();
    
    //Vittoria di secondo in 3 mosse (3 vittorie di secondo di fila)
    //$display("\ntest 4");
    primo = 2'b10;
    secondo = 2'b00;
    inizio = 2'b0;
    printinput(); 
    #10
    printoutput();
    
    primo = 2'b01;
    secondo = 2'b10;
    printinput(); 
    #10;
    printoutput();
    
    primo = 2'b10;
    secondo = 2'b11;
    printinput(); 
    #10;
    printoutput();
    
    primo = 2'b11;
    secondo = 2'b01;
    printinput(); 
    #10;
    printoutput();
    
    //Reset
    //$display("reset");
    inizio = 2'b1;
  	printinput(); 
    #10
    printoutput();
    
    //TEST PAREGGIO 5-5
    //$display("\ntest 5");
    primo = 2'b01;
    secondo = 2'b10;
    inizio = 2'b0;
    printinput(); 
    #10;
    printoutput();
    
    //1-0
    primo = 2'b01;
    secondo = 2'b11;
    printinput(); 
    #10;
    printoutput();
    //2-0
    primo = 2'b11;
    secondo = 2'b10;
    printinput(); 
    #10;
    printoutput();
    //2-1
    primo = 2'b10;
    secondo = 2'b11;
    printinput(); 
    #10;
    printoutput();
    //2-2
    primo = 2'b11;
    secondo = 2'b01;
    printinput(); 
    #10;
    printoutput();
    //2-3
    primo = 2'b01;
    secondo = 2'b10;
    printinput(); 
    #10;
    printoutput();
    //3-3
    primo = 2'b10;
    secondo = 2'b01;
    printinput(); 
    #10;
    printoutput();
    //4-3
    primo = 2'b11;
    secondo = 2'b10;
    printinput(); 
    #10;
    printoutput();
    //4-3 INVALIDA
    primo = 2'b11;
    secondo = 2'b10;
    printinput(); 
    #10;
    printoutput();
    //4-4
    primo = 2'b01;
    secondo = 2'b10;
    printinput(); 
    #10;
    printoutput();
    //5-4
    primo = 2'b10;
    secondo = 2'b01;
    printinput(); 
    #10;
    printoutput();
    //5-5
    primo = 2'b11;
    secondo = 2'b01;
    printinput(); 
    #10;
    printoutput();
    printinput();
    #10;
    printoutput();
    
    //Reset
    //$display("reset");
    inizio = 2'b1;
  	printinput(); 
    #10
    printoutput();
    
    //RESET PRIMA DI VITTORIA
    //$display("\ntest 6");
    primo = 2'b10;
    secondo = 2'b00;
    inizio = 2'b0;
    printinput(); 
    #10;
    printoutput();
    
    primo = 2'b10;
    secondo = 2'b01;;
    printinput(); 
    #10;
    printoutput();
    
    primo = 2'b11;
    secondo = 2'b10;
    inizio = 1;
    printinput(); 
    #10;
    printoutput();
    printinput();
    #10;
    printoutput();

    $finish;
    $fclose(fdo);
    $fclose(fdi);
  end
  
  task printinput();
    begin
      $fdisplay(fdi, "simulate %b %b %b %b %b ", primo[1], primo[0], secondo[1], secondo[0], inizio);
    end
  endtask
  
    task printoutput();
    begin
      $display("%b %b %b %b", manche[1], manche[0], partita[1], partita[0]);
      $fdisplay(fdo, "Outputs: %b %b %b %b", manche[1], manche[0], partita[1], partita[0]);
    end
  endtask

      
endmodule