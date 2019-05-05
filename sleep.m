function y = sleep(c, led)
    while readDigitalPin(c, 'D6') == 0
        writePWMDutyCycle(c, led, .1);
        pause(.1)
        writeDigitalPin(c, led, 0);
        pause(3)
    end
    y = 0;
end