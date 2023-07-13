import 'dart:math';
import 'package:flutter/material.dart';

List<String> alphabet = ['A', 'Ă', 'Â', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'Î', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'Ș', 'T', 'Ț', 'U', 'V', 'W', 'X', 'Y', 'Z'];
List<String> words = [
  "Fericire",
  "Frumos",
  "Mână",
  "Câine",
  "Copac",
  "Pâine",
  "Soare",
  "Mănânc",
  "Apă",
  "Pădure",
  "Înger",
  "Muzică",
  "Înțelept",
  "Sticlă",
  "Plajă",
  "Foc",
  "Mașină",
  "Timp",
  "Încet",
  "Ciocolată",
  "Porumb",
  "Școala",
  "Răsărit",
  "Roșu",
  "Flori",
  "Carte",
  "Adevăr",
  "Îmbrățișare",
  "Încântat",
  "Joc",
  "Călătorie",
  "Inimă",
  "Noroc",
  "Înălțime",
  "Bluză",
  "Anotimp",
  "Vin",
  "Vioară",
  "Fructe",
  "Gând",
  "Fierbinte",
  "Îngheț",
  "Înțeles",
  "Cafea",
  "Vară",
  "Căpșuni",
  "Primăvară",
  "Hoinărie",
  "Vacanță",
  "Râu",
  "Curaj",
  "Încăpățânat",
  "Cerc",
  "Piatră",
  "Încrezător",
  "Toamnă",
  "Vânt",
  "Strălucitor",
  "Înăbușit",
  "Casă",
  "Ciupercă",
  "Vârf",
  "Înțelegere",
  "Pisică",
  "Cățel",
  "Furtună",
  "Luna",
  "Întuneric",
  "Creion",
  "Copii",
  "Înaltă",
  "Furtunos",
  "Reușită",
  "Televizor",
  "Spumă",
  "Părinte",
  "Bicicletă",
  "Nisip",
  "Frigider",
  "Împăcat",
  "Dragoste",
  "Cremă",
  "Cartof",
  "Munți",
  "Plăcere",
  "Acvariu",
  "Felicitare",
  "Zăpadă",
  "Nevoie",
  "Măsură",
  "Supărat",
  "Adevărul",
  "Oameni",
  "Pescuit",
  "Sat",
  "Prăjituri",
  "Profesor",
  "Înfricoșător",
  "Roțile",
  "Modest",
];

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Hangman',
    home: HangmanGame(),
  ));
}


class Hangman {
  String word = "";
  int remainingAttempts  = 7;
  Set<String> correctLetters = {};
  Set<String> incorrectLetters = {};

  Hangman() {
    Random random = Random();
    word = words[random.nextInt(words.length)];
    word = word.toUpperCase();

    remainingAttempts  = 7;
    correctLetters = {};
    incorrectLetters = {};
  }
  bool isLetterUsed(String letter){
    return correctLetters.contains(letter) || incorrectLetters.contains(letter);
  }

  bool guessLetter(String letter) {
    if (isLetterUsed(letter)) {
      return false;
    }

    if (word.contains(letter)) {
      correctLetters.add(letter);
    } else {
      incorrectLetters.add(letter);
      remainingAttempts --;
    }
    return true;
  }

  String composeWord() {
    String result = '';

    for (int i = 0; i < word.length; i++) {
      String letter = word[i];

      if (correctLetters.contains(letter)) {
        result += letter;
      } else {
        result += '_';
      }
      result += ' ';
    }
    return result;
  }

  bool isGameOver() {
    if(remainingAttempts  == 0 ){
      for (var elem in alphabet){
        if (!(correctLetters.contains(elem) || incorrectLetters.contains(elem))){
          incorrectLetters.add(elem);
        }
      }
      return true;
    }
    return false;
  }

  String eliminateSpaces(String word){
    String res = "";
    for (int i = 0; i < word.length; i++){
      if(word[i] != ' ') {
        res += word[i];
      }
    }
    return res;
  }

  bool isGameWin(){
    String checker = eliminateSpaces(composeWord());
    if(checker == word){
      for (var elem in alphabet){
        if (!(correctLetters.contains(elem) || incorrectLetters.contains(elem))){
          incorrectLetters.add(elem);
        }
      }
      return true;
    }
    return false;
  }
}

class HangmanGame extends StatefulWidget {
  const HangmanGame({super.key});

  @override
  HangmanGameState createState() => HangmanGameState();
}

class HangmanGameState extends State<HangmanGame> {
  late Hangman hangman;

  @override
  void initState() {
    super.initState();
    hangman = Hangman();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Hangman'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Remaining attempts : ${hangman.remainingAttempts }',
                style: const TextStyle( fontSize: 20.0),),
              const SizedBox(height: 16.0),
              Text(
                  hangman.composeWord(), style: const TextStyle(fontSize: 26.0)),
              const SizedBox(height: 10.0, width: 6.0,),
              GridView.count(
                crossAxisCount: 8,
                shrinkWrap: true,
                children: List.generate(alphabet.length, (index) {
                  String letter = alphabet[index];
                  bool isUsed = hangman.isLetterUsed(letter);
                  return InkWell(
                    onTap: isUsed ? null : () {
                      setState(() {
                        hangman.guessLetter(letter);});},
                    child: Container(
                      width: 1.0,
                      height: 1.0,
                      margin: const EdgeInsets.all(30.0),
                      padding: const EdgeInsets.all(4.0),
                      decoration: BoxDecoration(
                        border: Border.all(width: 2.0),
                        borderRadius: BorderRadius.circular(8.0),
                        color: isUsed ? Colors.blueGrey : null,
                      ),
                      child: Text(
                          letter, style: TextStyle(fontSize: 20.0, color: isUsed
                          ? Colors.white : null)),
                    ),
                  );
                }),
              ),
              const SizedBox(height: 12.0),
              if (hangman.isGameOver())
                Center(
                child: Column(
                  children: [
                    Text('Game over! The word was: ${hangman.word}', style: const TextStyle(fontSize: 20.0),),
                    const SizedBox(height: 16.0),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          hangman = Hangman();
                        });
                      },
                      child: const Text('Play again', style: TextStyle(fontSize: 20.0),),
                    ),
                  ],
                ),
                )
              else if(hangman.isGameWin())
                Center(
                  child: Column(
                    children: [
                    const Text("You win!", style: TextStyle(fontSize: 20.0),),
                    const SizedBox(height: 20.0),
                    TextButton(onPressed: () {
                      setState(() {
                        hangman = Hangman();
                      });
                    },
                      child: const Text('Play again', style: TextStyle(fontSize: 20.0),),
                    )
                  ],
                )
                )
            ],
          ),
        ),
      ),
    );
  }
}