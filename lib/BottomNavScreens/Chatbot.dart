import 'package:dialog_flowtter/dialog_flowtter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart'; // Import the Cupertino library for iOS-style widgets
import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
// Import the speech_to_text library

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);
  static const String screenId = 'chat';
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late DialogFlowtter dialogFlowtter;
  final TextEditingController _controller = TextEditingController();

  SpeechToText speech = SpeechToText(); // Create an instance of SpeechToText
  bool isListening = false;

  FlutterTts flutterTts = FlutterTts();

  List<Map<String, dynamic>> messages = [];

  @override
  void initState() {
    DialogFlowtter.fromFile().then((instance) => dialogFlowtter = instance);

    speech.initialize(onError: (error) {
      print("Speech recognition initialization error: $error");
    }, onStatus: (status) {
      setState(() {
        isListening = speech.isListening;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Icon(Icons.arrow_back_ios_rounded),
        ),
        title: Text('FarmilyBot'),
        backgroundColor: Colors.green, // Set the background color to green
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(child: MessagesScreen(messages: messages)),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              color: Colors.white,
              child: Row(
                children: [
                  Expanded(
                    child: CupertinoTextField(
                      controller: _controller,
                      style: TextStyle(color: Colors.black), // Change text color to black
                      placeholder: 'Type a message', // Add placeholder text
                      prefix: Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: Icon(Icons.message, color: Colors.black), // Add an icon before the input field
                      ),
                      suffix: IconButton(
                        onPressed: () {
                          sendMessage(_controller.text);
                          _controller.clear();
                        },
                        icon: Icon(Icons.send, color: Colors.black),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.white, // Change text field color to white
                        borderRadius: BorderRadius.circular(22.0), // Add rounded border
                        border: Border.all(color: Colors.green, width: 1.0), // Add thin green border
                      ),
                    ),
                  ),


                  IconButton(
                    icon: Icon(Icons.keyboard_voice),
                    onPressed: () {

                      if (isListening) {
                        stopListening();
                      } else {
                        showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return Container(
                              padding: EdgeInsets.all(16),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'Listening...',
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  SizedBox(height: 16),
                                  CircularProgressIndicator(),
                                ],
                              ),
                            );
                          },
                        );
                        startListening();
                      }
                    },
                  ),



                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  sendMessage(String text) async {
    if (text.isEmpty) {
      print('Message is empty');
    } else {
      setState(() {
        addMessage(Message(text: DialogText(text: [text])), true);
      });

      DetectIntentResponse response = await dialogFlowtter.detectIntent(
        queryInput: QueryInput(text: TextInput(text: text)),
      );
      if (response.message == null) return;
      setState(() {
        addMessage(response.message!);
      });
    }
  }

  addMessage(Message message, [bool isUserMessage = false]) {
    messages.add({'message': message, 'isUserMessage': isUserMessage});
  }

  void startListening() async {
    if (!isListening) {
      bool available = await speech.initialize();
      if (available) {
        setState(() {
          isListening = true;
        });

        speech.listen(
          onResult: ( SpeechRecognitionResult result) {
            if (result.finalResult) {
              String text = result.recognizedWords;
              sendMessage(text);
              stopListening();
            }
          },
        );
      } else {
        print('Speech recognition not available');
      }
    }  else {
      stopListening();
    }
  }

  void stopListening() {
    if (isListening) {
      speech.stop();
      setState(() {
        isListening = false;
      });
      Navigator.pop(context);
    }
  }




}

class MessagesScreen extends StatefulWidget {
  final List messages;
  const MessagesScreen({Key? key, required this.messages}) : super(key: key);

  @override
  _MessagesScreenState createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return ListView.separated(
      itemBuilder: (context, index) {
        bool isUserMessage = widget.messages[index]['isUserMessage'];
        Color bubbleColor = isUserMessage ? Colors.green : Colors.grey.shade300;
        Color textColor = isUserMessage ? Colors.white : Colors.black;

        return Container(
          margin: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: isUserMessage
                ? MainAxisAlignment.end
                : MainAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 14, horizontal: 14),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                    bottomRight:
                    Radius.circular(isUserMessage ? 0 : 20),
                    topLeft:
                    Radius.circular(isUserMessage ? 20 : 0),
                  ),
                  color: bubbleColor,
                ),
                constraints: BoxConstraints(maxWidth: w * 2 / 3),
                child: Text(
                  widget.messages[index]['message'].text.text[0],
                  style: TextStyle(color: textColor),
                ),
              ),


              if (!isUserMessage)
                IconButton(
                  icon: Icon(Icons.volume_up),
                  onPressed: () {
                    String text = widget.messages[index]['message'].text.text[0];
                    speak(text);
                  },
                ),


            ],
          ),
        );
      },
      separatorBuilder: (_, i) => Padding(padding: EdgeInsets.only(top: 10)),
      itemCount: widget.messages.length,
    );
  }

  void speak(String text) async {
    FlutterTts flutterTts = FlutterTts();
    await flutterTts.setLanguage('en-IN'); // Set the language for text-to-speech
    await flutterTts.setPitch(1.0); // Set the pitch for text-to-speech
    await flutterTts.setSpeechRate(0.5); // Set the speech rate for text-to-speech

    await flutterTts.speak(text); // Speak the provided text
  }


}

/*
theme: ThemeData(
primaryColor: Color(0xFF075E54), // Change primary color to WhatsApp green
primaryColorDark: Color(0xFF128C7E), // Change primary dark color
accentColor: Color(0xFF25D366), // Change accent color to WhatsApp green
brightness: Brightness.light,
fontFamily: 'Helvetica', // Change font family to WhatsApp's default font
textTheme: TextTheme(
headline6: TextStyle(
fontSize: 18,
fontWeight: FontWeight.bold,
color: Colors.white, // Change text color to white
),
bodyText2: TextStyle(
fontSize: 16,
color: Colors.black, // Change text color to black
),
),
),
*/