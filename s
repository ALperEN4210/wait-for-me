#include <SoftwareSerial.h>

SoftwareSerial co2Serial(10, 11); // RX, TX

byte cmd[9] = {0xFF, 0x01, 0x86, 0x00, 0x00, 0x00, 0x00, 0x00, 0x79};
byte response[9];

void setup() {
  Serial.begin(9600);
  co2Serial.begin(9600);
  Serial.println("Test basliyor...");
  delay(3000);
}

void loop() {
  co2Serial.write(cmd, 9);
  delay(500);

  if (co2Serial.available() >= 9) {
    for (int i = 0; i < 9; i++) {
      response[i] = co2Serial.read();
    }
    if (response[0] == 0xFF && response[1] == 0x86) {
      int co2 = (response[2] << 8) | response[3];
      Serial.print("CO2: ");
      Serial.print(co2);
      Serial.println(" ppm");
    } else {
      Serial.println("HATA: Yanlis veri!");
    }
  } else {
    Serial.println("HATA: Veri gelmiyor!");
  }

  delay(2000);
}