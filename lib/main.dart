//PACKAGES:
import 'package:flutter/material.dart';
//import 'package:audioplayers/audioplayers.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:math';
import 'quiz_brain.dart';
//import 'random.dart';

QuizBrain quizBrain = QuizBrain();

void main() {
  runApp(MyApp());
}

//USER OBJECT
class User {
  String fbLink;
  String inLink;
  String whLink;

  User({
    this.fbLink,
    this.inLink,
    this.whLink,
  });
}

final user = User(
  fbLink: 'https://www.facebook.com/daniel.o.arango',
  inLink: 'https://www.linkedin.com/in/daniel-armando-ortiz-arango/',
  whLink: 'https://web.whatsapp.com/.............................',
);

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int LeftImage = 1;
  int RightImage = 1;

  //Images picture = Images();
  // Images photo = Images();

  void changeImage() {
    setState(() {
      LeftImage = Random().nextInt(3) + 1;
      RightImage = Random().nextInt(3) + 1;
    });
  }

  //void resetDice() {
  //setState(() {
  //LeftImage = 1;
  // RightImage = 1;
  //});
  //}

  void PlaySound(int soundNumber) {
    final player = AudioCache();
    player.play('note$soundNumber.wav');
  }

  Expanded buildKey({int soundNumber}) {
    return Expanded(
      child: FlatButton(
        onPressed: () {
          PlaySound(soundNumber);
        },
        child: Text('sound me'),
      ),
    );
  }

  //BUILDER FUNCTION
  IconButton iconButtonBuilder(IconData icon, String link) {
    return IconButton(
      icon: FaIcon(icon),
      color: Colors.white,
      iconSize: 56,
      onPressed: () async {
        final url = link;
        if (await canLaunch(url)) {
          await launch(url);
        } else {
          throw 'Could not launch $url';
        }
      },
    );
  }

  List<Icon> scoreKeeper = [];

  int questionNumber = 0;

  @override
  Widget build(BuildContext context) {
    //LeftImage = 2;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.deepOrange),
          title: Text('Who I am', style: TextStyle(color: Colors.deepOrange)),
          backgroundColor: Colors.white,
          actions: [
            IconButton(
              icon: const Icon(Icons.shopping_cart),
              //color: Colors.teal,
              tooltip: 'Open shopping cart',
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.settings),
              //color: Colors.teal,
              tooltip: 'Setting Icon',
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.navigate_next),
              tooltip: 'Go to the next page',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) {
                      return Scaffold();
                    },
                  ),
                );
              },
            ),
          ],
        ),
        backgroundColor: Colors.teal,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Expanded(
                    child: FlatButton(
                      onPressed: () {
                        setState(() {
                          //picture.cImage(LeftImage);
                        });
                      },
                      child: CircleAvatar(
                        radius: 50.0,
                        backgroundImage:
                            AssetImage('images/apto$LeftImage.png'),
                      ),
                    ),
                  ),
                  Expanded(
                    child: FlatButton(
                      onPressed: () {
                        setState(() {
                          //photo.cImage1(RightImage);
                        });
                        changeImage();
                      },
                      child: CircleAvatar(
                        radius: 50.0,
                        backgroundImage:
                            AssetImage('images/apto$RightImage.png'),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  buildKey(soundNumber: 1),
                  buildKey(soundNumber: 2),
                  buildKey(soundNumber: 3),
                ],
              ),
              Text(
                'Team Arduino',
                style: TextStyle(
                    fontFamily: 'Pacifico',
                    fontSize: 40.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                'ENGINEER ARDUINO UNO',
                style: TextStyle(
                  fontFamily: 'Source Sans pro',
                  color: Colors.teal.shade100,
                  fontSize: 20.0,
                  letterSpacing: 2.5,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                quizBrain.questionBank[questionNumber].questionText,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15.0,
                  color: Colors.white,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Card(
                      margin: EdgeInsets.symmetric(
                          vertical: 30.0, horizontal: 30.0),
                      color: Colors.white,
                      child: TextButton(
                          child: Text(
                            'True',
                            style: TextStyle(
                              color: Colors.greenAccent,
                              fontSize: 15.0,
                            ),
                          ),
                          onPressed: () {
                            bool correctAnswer = quizBrain
                                .questionBank[questionNumber].answerText;
                            if (correctAnswer == true) {
                              print('ok');
                            } else {
                              print('wrong');
                            }
                            setState(() {
                              questionNumber = questionNumber + 1;
                            });
                          }),
                    ),
                  ),
                  Expanded(
                    child: Card(
                      margin: EdgeInsets.symmetric(
                          vertical: 30.0, horizontal: 30.0),
                      color: Colors.white,
                      child: TextButton(
                          child: Text(
                            'False',
                            style: TextStyle(
                              color: Colors.redAccent,
                              fontSize: 15.0,
                            ),
                          ),
                          onPressed: () {
                            bool correctAnswer = quizBrain
                                .questionBank[questionNumber].answerText;
                            if (correctAnswer == false) {
                              print('ok');
                            } else {
                              print('wrong');
                            }
                            setState(() {
                              questionNumber++;
                            });
                          }),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20.0,
                width: 150,
                child: Divider(
                  color: Colors.teal.shade100,
                ),
              ),
              Card(
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                color: Colors.white,
                child: ListTile(
                  leading: Icon(
                    Icons.phone,
                    color: Colors.teal,
                  ),
                  title: GestureDetector(
                    onTap: () => launch('https://wa.link/mmzkiv'),
                    child: Text(
                      '3163673804',
                      style: TextStyle(
                        color: Colors.teal.shade900,
                        fontFamily: 'Source Sans Pro',
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                  subtitle: Container(
                    margin: EdgeInsets.only(top: 10),
                    child: Text(
                      '   Sat-Thu: 8:00am-4:00pm',
                      style: TextStyle(
                        fontFamily: 'Merriweather',
                        fontSize: 12,
                        fontStyle: FontStyle.italic,
                        color: Colors.cyan[500],
                      ),
                    ),
                  ),
                ),
              ),
              Card(
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                child: ListTile(
                  leading: Icon(
                    Icons.email,
                    color: Colors.teal,
                  ),
                  title: Text(
                    'danielor6@hotmail.com',
                    style: TextStyle(
                      color: Colors.teal.shade900,
                      fontFamily: 'Source Sans Pro',
                      fontSize: 20.0,
                    ),
                  ),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                      topRight: Radius.circular(20)),
                  side: BorderSide(width: 3, color: Colors.teal.shade900),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  iconButtonBuilder(FontAwesomeIcons.facebook, user.fbLink),
                  iconButtonBuilder(FontAwesomeIcons.linkedin, user.inLink),
                  iconButtonBuilder(FontAwesomeIcons.whatsapp, user.whLink),
                  TextButton(
                    onPressed: () {
                      PlaySound(2);
                    },
                    child: Text('sound me'),
                  ),
                ],
              ),
              Row(
                children: scoreKeeper,
              ),
            ],
          ),
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: const <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.teal,
                ),
                child: Text(
                  'Drawer Header',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.message),
                title: Text('Messages'),
              ),
              ListTile(
                leading: Icon(Icons.account_circle),
                title: Text('Profile'),
              ),
              ListTile(
                leading: Icon(Icons.settings),
                title: Text('Settings'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
