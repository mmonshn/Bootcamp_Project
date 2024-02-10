void activatePiezo(uint8_t on) {
    // Set the appropriate pin for the Piezo buzzer as an output
    // Assuming the pin connected to the Piezo buzzer is PORTC0
    DDRC |= (1 << DDC0);

    // Control the Piezo buzzer based on the 'on' parameter
    if (on) {
        // Turn on the Piezo buzzer by setting the pin high
        PORTC |= (1 << PORTC0);
    } else {
        // Turn off the Piezo buzzer by setting the pin low
        PORTC &= ~(1 << PORTC0);
    }
}

void commitData() {
    PORTD |= (1 << PORTD4);
    _delay_us(10);
    PORTD &= ~(1 << PORTD4);
    _delay_us(10);
}

void sendLCDCommand(uint8_t command) {
    // pull RS low
    PORTD &= ~(1 << PORTD3);

    // send high nibble of the command
    PORTB &= 0xF0;
    PORTB |= command >> 4;
    commitData();

    // send low nibble of the command
    PORTB &= 0xF0;
    PORTB |= (command & 0x0F);
    commitData();
}

void sendLCDData(uint8_t data) {
    // pull RS high
    PORTD |= (1 << PORTD3);

    // send high nibble of the data
    PORTB &= 0xF0;
    PORTB |= data >> 4;
    commitData();

    // send low nibble of the data
    PORTB &= 0xF0;
    PORTB |= (data & 0x0F);
    commitData();
}

void lcdDisplayString(const char* str) {
    while (*str != '\0') {
        sendLCDData(*str);
        str++;
    }
}

void ledRGB(float temp) {
    static float prevTemp = 0.0; // Variable to store the previous temperature

    if (temp <= 30.0) {
        PORTD |= (1 << PORTD0);
        PORTD &= ~(1 << PORTD1) & ~(1 << PORTD2);
    } else if (temp > 30.0 && temp < 50.0) {
        PORTD |= (1 << PORTD0) | (1 << PORTD2);
        PORTD &= ~(1 << PORTD1);
    } else {
        PORTD |= (1 << PORTD2);
        PORTD &= ~(1 << PORTD0) & ~(1 << PORTD1);
    }

    // Check if the temperature has crossed 50.0 degrees
    if (prevTemp <= 50.0 && temp > 50.0) {
        activatePiezo(1); // Activate Piezo for 1 second when temperature goes above 50.0 degrees
    } else if (prevTemp > 40.0 && temp <= 40.0) {
        activatePiezo(0); // Deactivate Piezo when temperature goes below 50.0 degrees
    }

    // Store the current temperature as the previous temperature for the next iteration
    prevTemp = temp;
}

void initLCD() {
    DDRB |= 0x0F; // set pins 8-11 as output
    PORTB &= 0xF0; // set pins 4-7 as low (not used)

    // set pins 0-2 as output for ledRGB1()
    DDRD |= (1 << DDD0) | (1 << DDD1) | (1 << DDD2);

    // set pins 5-7 as output for ledRGB2()
    DDRD |= (1 << DDD5) | (1 << DDD6) | (1 << DDD7);

    DDRD |= (1 << DDD3) | (1 << DDD4); // set pins 3-4 as output
    PORTD &= ~(1 << PORTD3) & ~(1 << PORTD4); // set pins 3-4 as low (not used)

    sendLCDCommand(0x33);
    sendLCDCommand(0x32);
    sendLCDCommand(0x28);
    sendLCDCommand(0x0E);
    sendLCDCommand(0x01);
    sendLCDCommand(0x80); // Cursor start line 1
}

void initADC() {
    // Set reference voltage to AVcc
    ADMUX |= (1 << REFS0);
    // Enable ADC with prescaler 128
    ADCSRA |= (1 << ADEN) | (1 << ADPS2) | (1 << ADPS1) | (1 << ADPS0);
}

void setup() {
    initLCD();
    initADC();
}

char buffer[16];

void loop() {
    sendLCDCommand(0x01); // Clear Display
    sendLCDCommand(0x80); // Show results at the beginning
    uint16_t adcValue;

    // Start conversion
    ADMUX |= (1 << MUX0);
    ADCSRA |= (1 << ADSC);

    // Wait for ADIF
    while (ADCSRA & (1 << ADSC)); // or  ->    while (!(ADCSRA & (1 << ADIF)));

    adcValue = ADC / 1024.0 * 5000.0; // adcValue/1024.0*5 = Volt
    float Vout = adcValue;
    float temp = (Vout - 500) / 10.0;

    sprintf(buffer, "Temp = ");
    lcdDisplayString(buffer);
    dtostrf(temp, 0, 2, buffer);
    lcdDisplayString(buffer);
    ledRGB(temp);

    _delay_ms(1000);
}