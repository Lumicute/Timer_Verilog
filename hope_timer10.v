module hope_timer10
#(parameter N = 4'b1001) // Max count value
(
    input wire set_time,
    input wire Clk,
    input wire start,
    input wire stop,
    input wire reset,
    input wire pause,
    input wire UpOrDown,  // High for UP counter, Low for DOWN counter
    input wire [3:0] Init_value,
    output reg [3:0] Count,
    output reg carry
);

localparam [3:0] Count0 = 4'b0000, 
                 Count1 = 4'b0001,
                 Count2 = 4'b0010,
                 Count3 = 4'b0011,
		 Count4 = 4'b0100,
		 Count5 = 4'b0101,
		 Count6 = 4'b0110,
		 Count7 = 4'b0111,
		 Count8 = 4'b1000,
		 Count9 = 4'b1001,
		 IDE    = 4'b1010,
		 Pause_state= 4'b1011,
		 Stop_state = 4'b1100;

reg [3:0] state_reg, state_next, state_hold;


// Synchronous State Update
always @(posedge Clk or posedge reset or posedge set_time) begin
    if (reset) 
        state_reg <= IDE;
    else if (set_time)
        state_reg <= IDE;
    else begin
	if(state_reg !=Pause_state) state_hold<=state_reg;
        state_reg <= state_next;
	end 
end

// Combinational Next-State Logic
always @* begin
    state_next = state_reg;
    case (state_reg)
        IDE: begin
            if (start) begin
		if(UpOrDown)  begin 
			if( Init_value == N)  state_next= Count0;
			else 			 state_next = Init_value +1'b1; 

	    	end else begin 	
			if( Init_value == 1'b0)  state_next= N;
			else 			 state_next = Init_value - 1'b1; 

		end 

	    end 
 
        end

        Count0: begin
            if (pause || !start )
                state_next = Pause_state;
            else if (stop)
                state_next = Stop_state ;
	    else begin 
		if(UpOrDown) begin 
		state_next = Count1;
		end else begin 
		state_next = N;
                end 
	    end 
		
        end

        Count1: begin
            if (pause || !start )
                state_next = Pause_state;
            else if (stop)
                state_next = Stop_state ;
	    else begin 
		if(UpOrDown) begin
		   if(Count==N)      state_next=Count0;
		   else 	     state_next=Count2;
		end else begin
		   state_next = Count0;
		end 	
	    end 
		
        end

        Count2: begin
            if (pause || !start )
                state_next = Pause_state;
            else if (stop)
                state_next = Stop_state ;
	    else begin 
		if(UpOrDown) begin
		   if(Count==N)      state_next=Count0;
		   else 	     state_next=Count3;
		end else begin
		   state_next = Count1;
		end 	
	     end 
        end

        Count3: begin
            if (pause || !start )
                state_next = Pause_state;
            else if (stop)
                state_next = Stop_state ;
	    else begin 
		if(UpOrDown) begin
		   if(Count==N)      state_next=Count0;
		   else 	     state_next=Count4;
		end else begin
		   state_next = Count2;
		end 	
	    end 
		
        end

        Count4: begin
            if (pause || !start )
                state_next = Pause_state;
            else if (stop)
                state_next = Stop_state ;
	    else begin 
		if(UpOrDown) begin
		   if(Count==N)      state_next=Count0;
		   else 	     state_next=Count5;
		end else begin
		   state_next = Count3;
		end 	
	    end 
		
        end

        Count5: begin
            if (pause || !start )
                state_next = Pause_state;
            else if (stop)
                state_next = Stop_state ;
	    else begin 
		if(UpOrDown) begin
		   if(Count==N)      state_next=Count0;
		   else 	     state_next=Count6;
		end else begin
		   state_next = Count4;
		end 	
	    end 
        end

        Count6: begin
            if (pause || !start )
                state_next = Pause_state;
            else if (stop)
                state_next = Stop_state ;
	    else begin 
		if(UpOrDown) begin
		   if(Count==N)      state_next=Count0;
		   else 	     state_next=Count7;
		end else begin
		   state_next = Count5;
		end 	
	    end 
		
        end

        Count7: begin
            if (pause || !start )
                state_next = Pause_state;
            else if (stop)
                state_next = Stop_state ;
	    else begin 
		if(UpOrDown) begin
		   if(Count==N)      state_next=Count0;
		   else 	     state_next=Count8;
		end else begin
		   state_next = Count6;
		end 	
	    end 
		
        end

        Count8: begin
            if (pause || !start )
                state_next = Pause_state;
            else if (stop)
                state_next = Stop_state;
	    else begin 
		if(UpOrDown) begin
		   if(Count==N)      state_next=Count0;
		   else 	     state_next=Count9;
		end else begin
		   state_next = Count7;
		end 	
	    end 
		
        end

        Count9: begin
            if (pause || !start )
                state_next = Pause_state;
            else if (stop)
                state_next = Stop_state ;
	    else begin 
		if(UpOrDown) begin 
		state_next = Count0;
		end else begin 
		state_next = Count8;
		end 
	    end 
		
        end


        Pause_state: begin  

            if (!pause && start) begin 
		if(UpOrDown)  begin 
			if( Count == N)  state_next= Count0;
			else 			 state_next = Count + 1'b1; 

	    	end else begin 	
			if( Count == 1'b0)  state_next= N;
			else 			 state_next = Count - 1'b1; 

		end 
	   end 
   
        end

        Stop_state: begin
	// empty 
        end

        default: state_next = IDE;
    endcase
end

always @* begin 
case (state_reg) 
	IDE: begin 
		Count=Init_value;
		carry=1'b0; 
	     end 
	Count0: begin 
		Count=4'b0000;
		if(UpOrDown) carry=1'b1 ;
		else         carry=1'b0;
	        end 
	Count1: begin 
		Count=4'b0001;
		if(UpOrDown) carry=1'b0 ;
		else  begin     
			if( Count==N)  carry=1'b1;
			else           carry=1'b0;
               end 
	     end 
	Count2: begin 
		Count=4'b0010;
		if(UpOrDown) carry=1'b0 ;
		else  begin     
			if( Count==N)  carry=1'b1;
			else           carry=1'b0;
               end 
	     end 
	Count3: begin 
		Count=4'b011;
		if(UpOrDown) carry=1'b0 ;
		else  begin     
			if( Count==N)  carry=1'b1;
			else           carry=1'b0;
               end 
	     end 
	Count4: begin 
		Count=4'b0100;
		if(UpOrDown) carry=1'b0 ;
		else  begin     
			if( Count==N)  carry=1'b1;
			else           carry=1'b0;
               end 
	     end 
	Count5: begin 
		Count=4'b0101;
		if(UpOrDown) carry=1'b0 ;
		else  begin     
			if( Count==N)  carry=1'b1;
			else           carry=1'b0;
               end 
	     end 
	Count6: begin 
		Count=4'b0110;
		if(UpOrDown) carry=1'b0 ;
		else  begin     
			if( Count==N)  carry=1'b1;
			else           carry=1'b0;
               end 
	     end 
	Count7: begin 
		Count=4'b0111;
		if(UpOrDown) carry=1'b0 ;
		else  begin     
			if( Count==N)  carry=1'b1;
			else           carry=1'b0;
               end 
	     end 
	Count8: begin 
		Count=4'b1000;
		if(UpOrDown) carry = 1'b0 ;
		else  begin     
			if( Count==N)  carry = 1'b1;
			else           carry = 1'b0;
               end 
	     end 
	Count9: begin 
		Count=4'b1001;
		if(UpOrDown)	   carry=1'b0 ;
		else              carry=1'b1;
	     end 
	Pause_state: begin 
			Count=state_hold;
			if(UpOrDown)begin
				if(state_hold==4'b0000) carry=1'b1;
				else                    carry=1'b0;
			end else begin  
				if(state_hold==N)       carry=1'b1;
				else                    carry=1'b0;
			end 
	     end 
	Stop_state: begin
		Count=4'b0000;
		carry=1'b0;
		end 
	default  : begin 
		Count=4'b0000;
		carry=1'b0;
	end 
	endcase

end 
endmodule