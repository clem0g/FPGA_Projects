module led (
    // LED Output
    output  led_0,

    // Button Input
    input   pmod_0,
    input   pmod_1
);

assign led_0 = !pmod_0 & !pmod_1;

endmodule