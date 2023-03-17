import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:math';

void main() => runApp(JogoForca());

class JogoForca extends StatefulWidget {
  @override
  State<JogoForca> createState() => _JogoForcaState();
}

class _JogoForcaState extends State<JogoForca> {
  final textController = TextEditingController();

  var words;
  var word;
  var wordFormated;
  var list;
  var lettersPassed;
  var errorCounter;
  var succesCounter;
  var message;

  var images = [
    'images/step01.png',
    'images/step02.png',
    'images/step03.png',
    'images/step04.png',
    'images/step05.png',
    'images/step06.png',
  ];

  @override
  void initState() {
    super.initState();
    words = ['Lucas', 'Alixame', 'Prova', 'Forca', 'Flutter'];
    word = words[Random().nextInt(5)];
    lettersPassed = List.filled(word.length, 0);

    wordFormated = showLetters(word, lettersPassed);

    errorCounter = 0;
    succesCounter = 0;
    message = '';
  }

  String showLetters(String word, List list) {
    int count = 0;
    String formatedWord = "";

    for (var boolean in list) {
      if (boolean == 1) {
        formatedWord = '$formatedWord ${word[count]}';
      } else {
        formatedWord = '$formatedWord __';
      }
      count++;
    }

    return formatedWord;
  }

  List<int> validateLetter(String word, String letter, List<int> list) {
    int x = 0;
    List oldList = list.toList();

    message = '';

    for (var rune in word.runes) {
      var character = String.fromCharCode(rune);

      if (character.toLowerCase() == letter.toLowerCase()) {
        list[x] = 1;
      }

      x++;
    }

    if (listEquals(list, oldList)) {
      errorCounter = errorCounter + 1;
      message = 'Você errou';
    } else {
      for (var letter in list) {
        if (letter == 1) {
          succesCounter = 1;
        } else {
          succesCounter = 0;
          break;
        }
      }

      if (succesCounter == 1) {
        message = 'Você acertou a palavra!';
      } else {
        message = 'Você acertou, continue tentando';
      }
    }

    return list;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jogo Forca',
      home: Scaffold(
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(top: 10),
              child: Flexible(
                child: Center(
                  child: Image.asset(
                    images[errorCounter],
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(0, 20, 0, 20),
              child: Text(
                wordFormated,
                style: const TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold
                ),
                textWidthBasis: TextWidthBasis.parent,
              ),
            ),
            Center(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                    width: double.parse('10')
                  ),
                ),
                height: double.parse('100.0'),
                width: double.parse('70.0'),
                child: TextField(
                  style: const TextStyle(
                    fontSize:30,
                    fontWeight: FontWeight.bold
                  ),
                  onChanged: (value) {
                    setState(() {
                      lettersPassed = validateLetter(word, value, lettersPassed);
                      wordFormated = showLetters(word, lettersPassed);

                      textController.clear();

                      if (errorCounter >= 5 || succesCounter == 1) {
                        word = words[Random().nextInt(5)];
                        lettersPassed = List.filled(word.length, 0);
                        wordFormated = showLetters(word, lettersPassed);
                        errorCounter = 0;
                        succesCounter = 0;
                        message = '';
                      }
                    });
                  },
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                  ),
                  controller: textController,
                ),
              ),
            ),
            Center(
              child: Container(
                margin: const EdgeInsets.only(top: 10),
                child: Text(
                  message
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}