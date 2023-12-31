module t_Sequential_Binary_Multiplier;

    parameter dp_width = 4; // Set to width of datapath
    wire [2*dp_width -1: 0] Product; // Output from multiplier
    wire Ready;
    reg [dp_width -1: 0] Multiplicand, Multiplier; // Inputs to multiplier
    reg Start, clock, reset_b;

    initial begin 
        $dumpfile("tb_multiplier.vcd"); 
        $dumpvars(0,t_Sequential_Binary_Multiplier); 
    end

    // Instantiate multiplier
    Sequential_Binary_Multiplier M0 (Product, Ready, Multiplicand, Multiplier, Start, clock,
    reset_b);

    // Generate stimulus waveforms
    initial #200 $finish;

    initial
    begin
        Start = 0;
        reset_b = 0;
        #2 Start = 1; 
        reset_b = 1;
        Multiplicand = 4'b1000;
        Multiplier = 4'b1001;
        #10 Start = 0;
    end

    initial
    begin
        clock = 0;
        repeat (100) #5 clock = ~clock;
    end

    // Display results and compare with Table 8.5
    always @ ( posedge clock )
        $strobe ("C=%b A=%b Q=%b P=%b time=%0d",M0.C,M0.A,M0.Q,M0.P, $time);
endmodule