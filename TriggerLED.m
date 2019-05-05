function y = TriggerLED(i, y, o, g, r, b, a)
    o(1) = o(2); 
    o(2) = i;
    if o(1) == 5 && i ~= 5
        LED(a, g);
    else
        if i == 6 || i == 5
            LED(a, g);
        else
            writeDigitalPin(a, g, 0);
            if y == 0
                LED(a, r);
                y = 1;
            else
                LED(a, b);
                y = 0;
            end
        end
    end
end