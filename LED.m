function LED(a, LED)
    switch LED
        case 'D9'
            writeDigitalPin(a, 'D3', 0);
            writeDigitalPin(a, 'D4', 0);
            writeDigitalPin(a, 'D5', 0);
            writeDigitalPin(a, LED, 1);
        case 'D3'
            writeDigitalPin(a, 'D9', 0);
            writeDigitalPin(a, 'D4', 0);
            writeDigitalPin(a, 'D5', 0);
            writeDigitalPin(a, LED, 1);
        case 'D4'
            writeDigitalPin(a, 'D9', 0);
            writeDigitalPin(a, 'D3', 0);
            writeDigitalPin(a, 'D5', 0);
            writeDigitalPin(a, LED, 1);
        case 'D5'
            writeDigitalPin(a, 'D9', 0);
            writeDigitalPin(a, 'D3', 0);
            writeDigitalPin(a, 'D4', 0);
            writeDigitalPin(a, LED, 1);
    end
end