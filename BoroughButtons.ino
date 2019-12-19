// constants won't change. They're used here to set pin numbers:
const int brxPin = 13;
const int manhPin = 12;
const int bknPin = 11;
const int qnsPin = 10;
const int siPin = 9;

// corresponding led pins assigned to each borough:
const int BrxledPin =  7;
const int ManhledPin =  6;
const int BknledPin =  5;
const int QnsledPin =  4;
const int SIledPin =  3;

int newBorough = 0;
int boroughSelected = 0;

// variables will change:
// variable for reading the pushbutton status
//int brxState = 0;
//int manhState = 1;
//int bknState = 2;
//int qnsState = 3;
//int siState = 4;



void setup() {
  Serial.begin(9600); //set up a serial connection with the computer
  Serial.println(boroughSelected);     //number assigned to borough

  // initialize the LED pin as an output:
  pinMode(BrxledPin, OUTPUT);
  pinMode(ManhledPin, OUTPUT);
  pinMode(BknledPin, OUTPUT);
  pinMode(QnsledPin, OUTPUT);
  pinMode(SIledPin, OUTPUT);

  // initialize the pushbutton pin as an input:
  pinMode(brxPin, INPUT);
  pinMode(manhPin, INPUT);
  pinMode(bknPin, INPUT);
  pinMode(qnsPin, INPUT);
  pinMode(siPin, INPUT);
}

void loop() {
  // put your main code here, to run repeatedly:

  // int newBorough = (digitalRead(0));
  // int boroughSelected = newBorough;



  if (digitalRead(brxPin)) {
    newBorough = 1;
    // turn LED on:
    digitalWrite(BrxledPin, HIGH);
  } else {
    digitalWrite(BrxledPin, LOW); // repeat on each borough
 
  }
  if (digitalRead(manhPin)) {
    newBorough = 2;
    // turn LED on:
    digitalWrite(ManhledPin, HIGH);
  } else {
    digitalWrite(ManhledPin, LOW);
  }
  
  if (digitalRead(bknPin)) {
    newBorough = 3;
    // turn LED on:
    digitalWrite(BknledPin, HIGH);
    } else {
    digitalWrite(BknledPin, LOW); 
  }
  
  if (digitalRead(qnsPin)) {
    newBorough = 4;
    // turn LED on:
    digitalWrite(QnsledPin, HIGH);
    } else {
    digitalWrite(QnsledPin, LOW);
  }
  
  if (digitalRead(siPin)) {
    newBorough = 5;
    // turn LED on:
    digitalWrite(SIledPin, HIGH);
    } else {
    digitalWrite(SIledPin, LOW);
  }
  
  if (newBorough != boroughSelected) {
    boroughSelected = newBorough;
    //send borough (only if it's a new one!)
    Serial.println(boroughSelected);     //number assigned to borough
  }

}
