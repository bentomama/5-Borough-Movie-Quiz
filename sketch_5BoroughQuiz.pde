// This example code is in the public domain.
import processing.serial.*;

int boroughSelected;//sent from Arduino 
Serial myPort;

// TODO: review and test this added code (keep a variable that says when to display the question)
// showQuestion
int showQuestion = 0;
Question q;

int margin = 50;

//start tracking correct answers
int correct=0; 

//number of total questions per borough
Question[] bronxQuestions = new Question[7];
Question[] manhattanQuestions = new Question[7];
Question[] brooklynQuestions = new Question[7];
Question[] queensQuestions = new Question[7];
Question[] sIQuestions = new Question[7];

// track chosen questions
ArrayList<Integer> prevChoseBronxQ; 
ArrayList<Integer> prevChoseManhattanQ;
ArrayList<Integer> prevChoseBrooklynQ;
ArrayList<Integer> prevChoseQueensQ;
ArrayList<Integer> prevChoseStatenIslandQ;



void setup() {
  fullScreen();
  //size(800, 800);
  // List all the available serial ports
  printArray(Serial.list());  

  // I know that the first port in the serial list on my Mac is always my
  // Arduino, so I open Serial.list()[0].
  // Open whatever port is the one you're using.
  myPort = new Serial(this, Serial.list()[1], 9600);
  // don't generate a serialEvent() unless you get a newline character:
  myPort.bufferUntil('\n');

  //keeping track of previous questions
  prevChoseBronxQ = new ArrayList<Integer>();
  prevChoseManhattanQ = new ArrayList<Integer>();
  prevChoseBrooklynQ = new ArrayList<Integer>();
  prevChoseQueensQ = new ArrayList<Integer>();
  prevChoseStatenIslandQ = new ArrayList<Integer>();

  //***************************************
  //(bronxQuestions[0], 5, bronxQuestions[1], 5, bronxQuestions[2], 5, bronxQuestions[3], 5, bronxQuestions[4], 5, bronxQuestions[5], 5, bronxQuestions[6], 5);

  //Bronx
  // TODO: review and test this added code (store the correct response when you instantiate the question)
  bronxQuestions[0] = new Question(
    "Loosely based on reclusive author J.D. Salinger, Finding Forrester stars this former James Bond?", 
    "A) Sean Connery", 
    "B) Daniel Craig", 
    "C) Pierce Brosnan", 
    "D) Timothy Dalton", 
    "Sean Connery", 
    "A");
  bronxQuestions[1] = new Question(
    "What famously blue-eyed leading man starred in Fort Apache, The Bronx, a film about a hard-drinking, lonely veteran cop who works in a crime-ridden precinct in The Bronx?", 
    "A) Frank Sinatra", 
    "B) Paul Newman", 
    "C) Robert Redford", 
    "D) James Dean", 
    "Paul Newman", 
    "B");
  bronxQuestions[2] = new Question(
    "This 2019 Best Picture winner begins in the Little Italy section of the Bronx?", 
    "A) Bohemian Rhapsody", 
    "B) A Star is Born", 
    "C) Green Book", 
    "D) BlacKkKlansman", 
    "Green Book", 
    "C");
  bronxQuestions[3] = new Question(
    "This super villain origin story includes a deranged dance down a steep set of stairs?", 
    "A) The Dark Knight", 
    "B) Batman vs. Superman", 
    "C) Avengers: Endgame", 
    "D) Joker", 
    "Joker", 
    "D");
  bronxQuestions[4] = new Question(
    "This movie was Jackie Chan's first American movie?", 
    "A) Drunken Master", 
    "B) Rush Hour", 
    "C) The Karate Kid", 
    "D) Rumble In The Bronx", 
    "Rumble In The Bronx", 
    "D");
  bronxQuestions[5] = new Question(
    "What Leonardo DiCaprio starring movie was set in Boston but was filmed exclusively in New York City?", 
    "A) Inception", 
    "B) The Wolf of Wall Street", 
    "C) The Departed", 
    "D) Shutter Island", 
    "The Departed", 
    "C");
  bronxQuestions[6] = new Question(
    "This movie was set in the summer of 1977, when the serial killer named the Son of Sam, hunted brunettes in New York City?", 
    "A) I Am Sam", 
    "B) Summer of Sam", 
    "C) Play It Again, Sam", 
    "D) Good Neighbor Sam", 
    "Summer of Sam", 
    "B");
  //Manhattan
  manhattanQuestions[0] = new Question(
    "Christian Bale, the star American Psycho, a tale of the arrogance, hedonism and conspicuous consumerism of the 1980s got his debut in which Steven Spielberg movie", 
    "A) E.T.", 
    "B) Empire of the Sun", 
    "C) Raiders of the Lost Ark", 
    "D) Jaws", 
    "Empire of the Sun", 
    "B");
  manhattanQuestions[1] = new Question(
    "One of the most beloved movies shot in this hotel is Home Alone 2: Lost in New York?", 
    "A) The Four Seasons", 
    "B) The Waldorf-Astoria", 
    "C) The Plaza", 
    "D) The Pierre", 
    "The Plaza", 
    "C");
  manhattanQuestions[2] = new Question(
    "As the sole survivor of a plague that killed most of humanity in New York City, Will Smith lucks out with a home right on Washington Square Park in which movie?", 
    "A) Gemini Man", 
    "B) Hitch", 
    "C) Independence Day", 
    "D) I Am Legend", 
    "I Am Legend", 
    "D");
  manhattanQuestions[3] = new Question(
    "In Night At The Museum, Ben Stiller's character got more than he bargained as a night security guard for when the  exhibits came to life in which museum?", 
    "A) American Museum Of Natural History", 
    "B) The Whitney Museum", 
    "C) MoMA", 
    "D) The Metropolitan Museum of Art", 
    "American Museum Of Natural History", 
    "A");
  manhattanQuestions[4] = new Question(
    "Rosemary's Baby was filmed almost exclusively in and around the Dakota apartment building, which was later the sight of the murder of which Beatle?", 
    "A) John Lennon", 
    "B) Paul McCartney", 
    "C) Ringo Starr", 
    "D) George Harrison", 
    "John Lennon", 
    "A");
  manhattanQuestions[5] = new Question(
    "The Empire State Building is one of New York City's most recognizable landmarks. Its towering height, one-of-a-kind views, and art deco architecture have drawn crowds for nearly a century. What movie starring Tom Hanks and Meg Ryan, ended on top of it?", 
    "A) You've Got Mail", 
    "B) Percy Jackson", 
    "C) Sleepless in Seattle", 
    "D) King Kong", 
    "Sleepless in Seattle", 
    "C");
  manhattanQuestions[6] = new Question(
    "West Side Story tells the timeless tale of Tony and Maria, star-crossed lovers from rival New York City gangs. It is the movie adaption of what play by Shakespeare?", 
    "A) Macbeth", 
    "B) Hamlet", 
    "C) Othello", 
    "D) Romeo & Juliet", 
    "Romeo & Juliet", 
    "D");
  //Brooklyn change questions
  brooklynQuestions[0] = new Question(
    "Black Swan, which captures the life of a ballet dancer who wins the most coveted lead role in Swan Lake, stars which Star Wars heroine?", 
    "A) Queen Amidala", 
    "B) Princess Leia", 
    "C) Rey", 
    "D) Jyn Erso", 
    "Queen Amidala", 
    "A");
  brooklynQuestions[1] = new Question(
    "What was the name of Spike Lee's first hit movie, about the racial division between an Italian pizza shop owner in a black neighborhood was shot entirely in Bed-Stuy?", 
    "A) Inside Man", 
    "B) She's Gotta Have It", 
    "C) Crooklyn", 
    "D) Do the Right Thing", 
    "Do the Right Thing", 
    "D");
  brooklynQuestions[2] = new Question(
    "Filmed in Park Slope and Brooklyn Heights, this movie focuses on a man trying to rob a bank to help pay for his boyfriend’s operation but things go horrifically wrong?", 
    "A) Panic In Needle Park", 
    "B) The Godfather", 
    "C) Dog Day Afternoon", 
    "D) Serpico", 
    "Dog Day Afternoon", 
    "C");
  brooklynQuestions[3] = new Question(
    "In this Marvel Comics movie, a gigantic super hero saves the Brooklyn Bridge from destruction?", 
    "A) X-Men", 
    "B) Fantastic Four", 
    "C) Justic League", 
    "D) Avengers", 
    "Fantastic Four", 
    "B");
  brooklynQuestions[4] = new Question(
    "In which movie is the Brooklyn Bridge not destroyed?", 
    "A) Captain America: The First Avenger", 
    "B) Godzilla", 
    "C) I Am Legend", 
    "D) Cloverfield", 
    "Captain America: The First Avenger", 
    "A");
  brooklynQuestions[5] = new Question(
    "Notorious takes place in Bedford-Stuyvesant and focuses on the life and career of which Brooklyn-born rapper?", 
    "A) Jay-Z", 
    "B) ODB", 
    "C) P. Diddy", 
    "D) Biggie Smalls", 
    "Biggie Smalls", 
    "D");
  brooklynQuestions[6] = new Question(
    "When a gang is falsely accused of killing a rival gang leader the Warriors flee the Bronx to get back to their territory in what neighborhood?", 
    "A) Little Italy", 
    "B) Chinatown", 
    "C) Coney Island", 
    "D) Park Slope", 
    "Coney Island", 
    "C");
  //Queens 
  queensQuestions[0] = new Question(
    "One of the most famous movies filmed in Queens, this hilarious comedy tells the story of an African Prince who travels to America undercover in order to find the love of his life?", 
    "A) American Gangster", 
    "B) Die Hard With A Vengeance", 
    "C) Black Panther", 
    "D) Coming to America", 
    "Coming to America", 
    "D");
  queensQuestions[1] = new Question(
    "Which famous Italian-American actor does not appear in Goodfellas?", 
    "A) Joe Pesci", 
    "B) Al Pacino", 
    "C) Robert De Niro", 
    "D) Ray Liotta", 
    "Al Pacino", 
    "B");
  queensQuestions[2] = new Question(
    "Pioneering a new genre known as <gun-fu>, the first film in this trilogy starred Keanu Reeves?", 
    "A) The Matrix", 
    "B) Speed", 
    "C) John Wick", 
    "D) Constantine", 
    "John Wick", 
    "C");
  queensQuestions[3] = new Question(
    "In this film, the 1964 World's Fair towers were turned into two giant alien space ships?", 
    "A) Men In Black", 
    "B) Aliens", 
    "C) Cloverfield", 
    "D) War of the Worlds", 
    "Men In Black", 
    "A");
  queensQuestions[4] = new Question(
    "This famous super hero alter ego calls the borough of Queens home?", 
    "A) Peter Parker", 
    "B) Steve Rogers", 
    "C) Tony Stark", 
    "D) Carol Danvers", 
    "Peter Parker", 
    "A");
  queensQuestions[5] = new Question(
    "Starring in this famous Mafia movie, Marlon Brando wanted his character to resemble a bulldog so he wore a custom-made mouthpiece?", 
    "A) Once Upon a Time in America", 
    "B) The Godfather", 
    "Goodfellas", 
    "C) American Ganster", 
    "D) The Godfather", 
    "B");
  queensQuestions[6] = new Question(
    "This famous scientologists starred in this remake of the classic science fiction radio broadcast War of the Worlds?", 
    "A) Tom Hanks", 
    "B) Tom Cruise", 
    "C) John Travolta", 
    "D) Tom Hiddleston", 
    "Tom Cruise", 
    "B");
  //Staten Island 
  sIQuestions[0] = new Question(
    "Russell Crowe starred as a brilliant but mentally ill mathematician who believes that he can crack codes of an enemy telecommunication for the U.S. government in which movie? ", 
    "A) The Nice Guys", 
    "B) Gladiator", 
    "C) A Beautiful Mind", 
    "D) Robin Hood", 
    "A Beautiful Mind", 
    "C");
  sIQuestions[1] = new Question(
    "What comedian, playing a hard-core New York Giants fan struggles to deal with the aftermath of getting beat up by his favorite player in this sleeper hit?", 
    "A) Pete Davidson", 
    "B) Jim Gaffigan", 
    "C) Patton Oswalt", 
    "D) Ricky Gervais", 
    "Patton Oswalt", 
    "C");
  sIQuestions[2] = new Question(
    "What wacky film starring Jim Carrey was filmed on location at the S.I. Zoo?", 
    "A) Ace Ventura: Pet Detective", 
    "B) Liar, Liar", 
    "C) Dumb and Dumber", 
    "D) Mr. Popper's Penguins", 
    "Mr. Popper's Penguins", 
    "D");
  sIQuestions[3] = new Question(
    "Which ex-lover of Brad Pitt starred as a rogue CIA agent trying to clear her name after being accused of being a Russian sleeper spy?", 
    "A) Angelina Jolie", 
    "B) Juliette Lewis", 
    "C) Gwyneth Paltrow", 
    "D) Jennifer Anniston", 
    "Angelina Jolie", 
    "A");
  sIQuestions[4] = new Question(
    "Which musically-inclined actor starred in School of Rock?", 
    "A) Bruce Willis", 
    "B) Jack Black", 
    "C) Jack White", 
    "D) Kevin Bacon", 
    "Jack Black", 
    "B");
  sIQuestions[5] = new Question(
    "What 1977 hit film starred a young John Travolta growing up in Brooklyn and featured the newest musical craze?", 
    "A) Saturday Night Fever", 
    "B) Pulp Fiction", 
    "C) Face-Off", 
    "D) Grease", 
    "Saturday Night Fever", 
    "A");
  sIQuestions[6] = new Question(
    "Working Girl stars Melanie Griffith who's mother Tippy Hedrin starred in which Hitchcock movie?", 
    "A) Vertigo", 
    "B) Psycho", 
    "C) North By Northwest", 
    "D) The Birds", 
    "The Birds", 
    "D");
}


// ********************************************************
void draw() {

  //text size question/answers and positions on screen?
  background(0);
  fill(255, 0, 153);

  if (boroughSelected==0) { //introduction on screen
    clear();
    textSize(60);
    textAlign(CENTER);
    // for later - would be easier to make a varioable called margin and set it to 50 or whatever 
    text("Welcome to the NYC Movie Quiz!", margin, 50, (width-margin*2), 400);
    textSize(30);
    text("Select a borough to begin", margin, 300, (width-margin*2), 400);
  }
  if (boroughSelected==6) { //prompt if correct
    clear();
    textSize(50);
    text("Correct. Select another borough to continue", margin, 200, (width-margin*2), 400);
  }
  if (boroughSelected==7) { //prompt if incorrect
    clear();
    textSize(50);
    text("Incorrect. Select another borough to continue", margin, 200, (width-margin*2), 400);
  }

  if (boroughSelected==1) {
    clear();
    bronxDisplay();
  }
  if (boroughSelected==2) {
    println("Manhattan selected");
    clear();      
    manhDisplay();
  }
  if (boroughSelected==3) {
    clear();
    bklynDisplay();
  } 
  if (boroughSelected==4) {
    clear();
    qnDisplay();
  }
  if (boroughSelected==5) {
    clear();
    siDisplay();
  }
}
// ********************************************************


int getBronxRandomNum() {
  float r = random(0, 6);
  int randomNum = int(r);
  // then see if it that number is in prevChoseBronxQ
  Boolean wasChosen = prevChoseBronxQ.contains(randomNum);
  // if it is, then choose another number
  // if it is not, then show the question and add the number to prevChoseBronxQ
  if (wasChosen) {
    return getBronxRandomNum();
  } else {
    prevChoseBronxQ.add(randomNum);
    return randomNum;
  }
}

int getManhattanRandomNum() {
  float r = random(0, 6);
  int randomNum = int(r);
  // then see if it that number is in prevChoseBronxQ
  Boolean wasChosen = prevChoseManhattanQ.contains(randomNum);
  println("random #: " + randomNum);
  printArray(prevChoseManhattanQ);
  delay(1000);
  // if it is, then choose another number
  // if it is not, then show the question and add the number to prevChoseBronxQ
  if (wasChosen) {
    println("already asked, find another");
    return getManhattanRandomNum();
  } else {
    prevChoseManhattanQ.add(randomNum);
    return randomNum;
  }
}

int getBrooklynRandomNum() {
  float r = random(0, 6);
  int randomNum = int(r);
  // then see if it that number is in prevChoseBronxQ
  Boolean wasChosen = prevChoseBrooklynQ.contains(randomNum);
  // if it is, then choose another number
  // if it is not, then show the question and add the number to prevChoseBronxQ
  if (wasChosen) {
    return getBrooklynRandomNum();
  } else {
    prevChoseBrooklynQ.add(randomNum);
    return randomNum;
  }
}

int getQueensRandomNum() {
  float r = random(0, 6);
  int randomNum = int(r);
  // then see if it that number is in prevChoseBronxQ
  Boolean wasChosen = prevChoseQueensQ.contains(randomNum);
  // if it is, then choose another number
  // if it is not, then show the question and add the number to prevChoseBronxQ
  if (wasChosen) {
    return getQueensRandomNum();
  } else {
    prevChoseQueensQ.add(randomNum);
    return randomNum;
  }
}

int getStatenIslandRandomNum() {
  float r = random(0, 6);
  int randomNum = int(r);
  // then see if it that number is in prevChoseBronxQ
  Boolean wasChosen = prevChoseStatenIslandQ.contains(randomNum);
  // if it is, then choose another number
  // if it is not, then show the question and add the number to prevChoseBronxQ
  if (wasChosen) {
    return getStatenIslandRandomNum();
  } else {
    prevChoseStatenIslandQ.add(randomNum);
    return randomNum;
  }
}
class Question {
  String questionText;
  String optionA;
  String optionB;
  String optionC;
  String optionD;
  String answerCorrect;
  String letterCorrect;

  // Constructor
  Question(String inQuestionText, String inOptionA, String inOptionB, String inOptionC, String inOptionD, String inAnswerCorrect, String inLetterCorrect) {
    questionText = inQuestionText;
    optionA = inOptionA;
    optionB = inOptionB;
    optionC = inOptionC;
    optionD = inOptionD;
    answerCorrect = inAnswerCorrect;
    letterCorrect = inLetterCorrect;
  }
}

void showText() {
  textSize(50);
  textAlign(CENTER);
  text(q.questionText, margin, 50, (width-margin*2), 400);
  textSize(30);
  textAlign(LEFT);
  text(q.optionA, margin*1.5, 450, (width/2-margin*1.5), 400);
  textSize(30);
  textAlign(LEFT);
  text(q.optionB, margin*1.5, 500, (width/2-margin*1.5), 400);
  textSize(30);
  textAlign(LEFT);
  text(q.optionC, (width/2 + margin/2), 450, (width/2-margin*1.5), 400);
  textSize(30);
  textAlign(LEFT);
  text(q.optionD, (width/2 + margin/2), 500, (width/2-margin*1.5), 400);
}

void checkKey() {
  if (keyPressed) {
    String keyLetter = str(key);
    keyLetter = keyLetter.toUpperCase();
    println(keyLetter);
    println("correct = " + q.letterCorrect);

    if (keyLetter.equals(q.letterCorrect)) {
      clear();
      correct+=1;
      boroughSelected=6;
    } else {
      clear();
      boroughSelected=7;
    }
  }
}



void bronxDisplay() {
  clear();

  println("showQuestion: " + showQuestion);
  if (showQuestion == 1) {
    // TODO: review and test this added code (once the question is shown keep it until the next button press)
    if (prevChoseBronxQ.size() < bronxQuestions.length) {
      // there are still some questions not asked yet
      println("ask a question");
      int randNum = getBronxRandomNum();
      q = bronxQuestions[randNum];
    } else {
      // no questions left for this borough
      println("no questions left for Bronx");
      clear();
      text("You've answered all the Bronx questions, try a new borough", 50, 50, 200, 400);
    }
    showQuestion = 0;
  }
  showText();
  checkKey();
}

void manhDisplay() {
  clear();

  println("showQuestion: " + showQuestion);
  if (showQuestion == 1) {
    // TODO: review and test this added code (once the question is shown keep it until the next button press)
    if (prevChoseManhattanQ.size() < manhattanQuestions.length) {
      // there are still some questions not asked yet
      int randNum = getManhattanRandomNum();
      q = manhattanQuestions[randNum];
    } else {
      // no questions left for this borough
      println("no questions left for Manhattan");
      clear();
      text("You've answered all the Manhattan questions, try a new borough", 50, 50, 200, 400);
    }
    showQuestion = 0;
  }
  showText();
  checkKey();
}


void bklynDisplay() {
  clear();

  if (showQuestion == 1) {
    if (prevChoseBrooklynQ.size() < brooklynQuestions.length) {
      // there are still some questions not asked yet
      int randNum = getBrooklynRandomNum();
      q = brooklynQuestions[randNum];
    } else {
      // no questions left for this borough
      println("no questions left for Brooklyn");
      clear();
      text("You've answered all the Brooklyn questions, try a new borough", 50, 50, 200, 400);
    }
    showQuestion = 0;
  }
  showText();
  checkKey();
}

void qnDisplay() {
  clear();

  if (showQuestion == 1) {
    if (prevChoseQueensQ.size() < queensQuestions.length) {
      // there are still some questions not asked yet
      int randNum = getQueensRandomNum();
      q = queensQuestions[randNum];
    } else {
      // no questions left for this borough
      println("no questions left for Queens");
      clear();
      text("You've answered all the Queens questions, try a new borough", 50, 50, 200, 400);
    }
    showQuestion = 0;
  }
  showText();
  checkKey();
}

void siDisplay() {
  clear();

  if (showQuestion == 1) {
    if (prevChoseStatenIslandQ.size() < sIQuestions.length) {
      // there are still some questions not asked yet
      int randNum = getStatenIslandRandomNum();
      q = sIQuestions[randNum];
    } else {
      // no questions left for this borough
      println("no questions left for Queens");
      clear();
      text("You've answered all the Queens questions, try a new borough", 50, 50, 200, 400);
    }
    showQuestion = 0;
  }
  showText();
  checkKey();
}

void serialEvent(Serial myPort) {
  // get the ASCII string:
  String inString = myPort.readStringUntil('\n');
  if (inString != null) {
    // trim off any whitespace:
    inString = trim(inString);
    // convert to an int and map to the screen height:
    // into an integer array:
    boroughSelected = int(inString);
    println("borough selected = " + boroughSelected);

    // TODO: review and test this added code (when you receive something from the arduino, show a question)
    showQuestion = 1;
  }
}
