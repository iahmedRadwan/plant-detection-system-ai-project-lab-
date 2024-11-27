import 'package:ai_project_lab_pannon/features/common/core/view/components/custom_appbar.dart';
import 'package:ai_project_lab_pannon/shared/style/colors_manager.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

import '../../../common/core/view/components/custom_dot_loading.dart';

class ChatBotPage extends StatefulWidget {
  const ChatBotPage({super.key});

  @override
  State<ChatBotPage> createState() => _ChatBotPageState();
}

class _ChatBotPageState extends State<ChatBotPage> {
  final TextEditingController userInputController = TextEditingController();
  final List<Message> messages = [];
  bool isLoading = false;

  void botApi() async {
    if (userInputController.text.isNotEmpty) {
      final userMessage = userInputController.text;
      setState(() {
        messages.add(Message(text: userMessage, isUser: true));
        isLoading = true;
      });
      userInputController.clear();

      try {
        final response = await Dio().post(
          'https://api.openai.com/v1/chat/completions',
          options: Options(
            headers: {
              'Authorization': 'Bearer ${dotenv.env['OPENAIKEY']}',
              'Content-Type': 'application/json',
            },
          ),
          data: {
            'model': 'gpt-3.5-turbo',
            'messages': [
              {'role': 'user', 'content': userMessage},
            ],
          },
        );

        final botResponse = response.data['choices'][0]['message']['content'];
        setState(() {
          if (kDebugMode) {
            print(botResponse);
          }
          messages.add(Message(text: botResponse, isUser: false));
        });
      } catch (e) {
        setState(() {
          if (kDebugMode) {
            print(e.toString());
          }

          messages.add(Message(text: 'Error: $e', isUser: false));
        });
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: "ChatBot",
        onPressed: () {
          Navigator.pop(context);
        },
        isLeading: false,
        actions: [
          Image.asset(
            "assets/images/chatBot.png",
            height: 40,
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  return ListTile(
                      title: Align(
                    alignment: messages[index].isUser
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: messages[index].isUser
                              ? ColorManagerHelper.kMainColor
                              : const Color(0xffEEEEEE),
                          borderRadius: messages[index].isUser
                              ? const BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  bottomRight: Radius.circular(20),
                                  bottomLeft: Radius.circular(20))
                              : const BorderRadius.only(
                                  topRight: Radius.circular(20),
                                  topLeft: Radius.circular(20),
                                  bottomRight: Radius.circular(20))),
                      child: DefaultTextStyle(
                        style: const TextStyle(
                            fontSize: 22.0,
                            fontFamily: 'Agne',
                            color: Colors.black),
                        child: AnimatedTextKit(
                          totalRepeatCount: 1,
                          pause: const Duration(milliseconds: 3000),
                          animatedTexts: [
                            TypewriterAnimatedText(
                                textAlign: TextAlign.left,
                                messages[index].text,
                                textStyle: messages[index].isUser
                                    ? Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(color: Colors.white)
                                    : Theme.of(context).textTheme.bodySmall),
                          ],
                          onTap: () {
                            print("Tap Event");
                          },
                        ),
                      ),
                    ),
                  ));
                }),
          ),

          // user input
          Padding(
            padding: const EdgeInsets.only(
                bottom: 20, top: 16.0, left: 16.0, right: 16),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(32),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 3,
                        blurRadius: 5,
                        offset: const Offset(0, 3))
                  ]),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: userInputController,
                      style: Theme.of(context).textTheme.titleSmall,
                      decoration: InputDecoration(
                          hintText: 'Write your message',
                          hintStyle: Theme.of(context)
                              .textTheme
                              .titleSmall!
                              .copyWith(color: Colors.grey, fontSize: 12),
                          border: InputBorder.none,
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 20)),
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  isLoading
                      ? const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: AppLoadingHelper.spinkit,
                        )
                      : Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: GestureDetector(
                            onTap: () {
                              botApi();
                            },
                            child: const Icon(IconlyBroken.send),
                          ),
                        )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Message {
  final String text;
  final bool isUser;
  Message({required this.text, required this.isUser});
}
