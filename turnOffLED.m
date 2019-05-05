function turnOffLED(a)
    writeDigitalPin(a, 'D9', 0);
    writeDigitalPin(a, 'D3', 0);
    writeDigitalPin(a, 'D4', 0);
    writeDigitalPin(a, 'D5', 0);
end