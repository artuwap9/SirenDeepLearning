function y = sleepOnOff(y, a, greenLED, whiteLED, button)
    if readDigitalPin(a, button) == 1
        LED(a, greenLED);
        pause(3)
        if readDigitalPin(a, button) == 1
            LED(a, whiteLED);
            pause(3)
            if readDigitalPin(a, button) == 1
                turnOffLED(a);
                pause(2)
                y = 1;
            else
                y = sleep(a, whiteLED);
                LED(a, whiteLED);
                pause(1)
                LED(a, greenLED);
            end
        else
            pause(7)
        end
    end
end