$$bits = 25

algorithm main(output uint$NUM_LEDS$ leds) {
  uint$bits$ cnt = 0;
  uint5 pwm = 0;
  uint4 pwm_input := cnt[$bits-1$,1] ? cnt[$bits-5$,4] : ~cnt[$bits-5$,4];

  $$for i = 0, NUM_LEDS-1 do
    leds[$i$,1] := pwm[4,1];
  $$end

  while (1) {
    cnt = cnt + 1;
    pwm = pwm[0,4] + pwm_input;
  }
}



    
    

  
