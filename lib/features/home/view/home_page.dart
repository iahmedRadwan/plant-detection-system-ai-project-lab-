import 'dart:convert';

import 'package:ai_project_lab_pannon/shared/style/fonts_manager.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:image_picker/image_picker.dart';

import '../../../shared/style/colors_manager.dart';
import '../../common/core/view/components/custom_appbar.dart';
import '../../common/core/view/components/custom_button.dart';
import '../../common/core/view/components/custom_dot_loading.dart';
import 'widget/floatingActionMenue.dart';
import 'widget/uploadImage.dart';

XFile? selectedImage;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? imageModelResponse;
  String? englishResponse;
  String? hungarianResponse;
  String? englishSuggestionResponse;
  String? hungarianSuggestionResponse;
  String? suggestionResponse;
  bool isEnglish = true;
  bool isSuggestionEnglish = true;

  bool isTranslationLoading = false;
  bool isTranslationSuggestionLoading = false;
  bool isSuggestionLoading = false;
  bool isImageDetectionLoading = false;

  resetData() {
    setState(() {
      imageModelResponse = null;
      englishResponse = null;
      hungarianResponse = null;
      englishSuggestionResponse = null;
      hungarianSuggestionResponse = null;
      suggestionResponse = null;
      isEnglish = true;
      isSuggestionEnglish = true;

      isTranslationLoading = false;
      isTranslationSuggestionLoading = false;
      isSuggestionLoading = false;
      isImageDetectionLoading = false;
      selectedImage = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Welcome to Plant Health AI",
        onPressed: () {},
        actions: [
          InkWell(
            onTap: () {
              setState(() {
                resetData();
              });
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14.0),
                  child: Text(
                    "Clean Data ",
                    style: FontsManagerHelper.caption
                        .copyWith(color: ColorManagerHelper.kBlackColor),
                  ),
                ),
              ],
            ),
          ),
        ],
        isLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 150,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14.0),
                  color: Colors.blueGrey.withOpacity(0.2),
                ),
                child: const Center(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Icon(IconlyBroken.infoCircle),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 14.0),
                            child: Text(
                              " Note",
                              style: FontsManagerHelper.bodyLarge,
                            ),
                          )
                        ],
                      ),
                      Text(
                        'Your smart assistant for diagnosing plant diseases, learning treatments, and ensuring healthy growth. Snap, ask, and discover—anytime, anywhere!',
                        style: FontsManagerHelper.bodyLarge,
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 34.0),
                child: UploadImage(),
              ),
              CustomButton(
                  onPressed: () async {
                    String baseImage64 = await xFileToBase64(selectedImage!);
                    imageModelResponse =
                        await botImageApi(base64String: baseImage64);
                    englishResponse = imageModelResponse;
                    setState(() {});
                  },
                  buttonText: imageModelResponse == null
                      ? "Check it"
                      : "Check another Image"),
              isImageDetectionLoading == false
                  ? imageModelResponse == null
                      ? Container()
                      : Padding(
                          padding: const EdgeInsets.symmetric(vertical: 14.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(14.0),
                                  color: Colors.blueGrey.withOpacity(0.2),
                                ),
                                child: Center(
                                  child: Stack(
                                    alignment: Alignment.bottomRight,
                                    children: [
                                      Column(
                                        children: [
                                          const Row(
                                            children: [
                                              Icon(IconlyBroken.infoCircle),
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 14.0),
                                                child: Text(
                                                  " Response of MML Model",
                                                  style: FontsManagerHelper
                                                      .bodyLarge,
                                                ),
                                              )
                                            ],
                                          ),
                                          Text(
                                            isEnglish
                                                ? englishResponse!
                                                : hungarianResponse!,
                                            style: FontsManagerHelper.bodyLarge,
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: InkWell(
                                          onTap: () async {
                                            setState(() {
                                              isTranslationLoading = true;
                                            });
                                            hungarianResponse == null
                                                ? hungarianResponse =
                                                    await translateBotApi(
                                                        translateInput:
                                                            englishResponse!,
                                                        isSuggestion: false)
                                                : null;
                                            setState(() {
                                              isEnglish = !isEnglish;
                                              isTranslationLoading = false;
                                            });
                                          },
                                          child: isTranslationLoading
                                              ? AppLoadingHelper.spinkit
                                              : Image.asset(
                                                  "assets/images/translate.png",
                                                  height: 25,
                                                  width: 25),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8.0),
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 4,
                                      backgroundColor:
                                          ColorManagerHelper.kMainColor,
                                    ),
                                    Text(
                                      "  We Suggest for you",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.start,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 2.0),
                                      child: CustomButton(
                                          backgroundColor: ColorManagerHelper
                                              .kMainColor
                                              .withOpacity(0.8),
                                          onPressed: () async {
                                            suggestionResponse =
                                                await suggestionBotApi(
                                                    numberOfSuggestion: 1);
                                            setState(() {
                                              englishSuggestionResponse =
                                                  suggestionResponse;
                                            });
                                          },
                                          buttonText: "Treatment"),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 4.0),
                                      child: CustomButton(
                                          onPressed: () async {
                                            suggestionResponse =
                                                await suggestionBotApi(
                                                    numberOfSuggestion: 2);
                                            setState(() {
                                              englishSuggestionResponse =
                                                  suggestionResponse;
                                            });
                                          },
                                          backgroundColor: ColorManagerHelper
                                              .kMainColor
                                              .withOpacity(0.8),
                                          buttonText: "Plant Info"),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 2.0),
                                      child: CustomButton(
                                          onPressed: () async {
                                            suggestionResponse =
                                                await suggestionBotApi(
                                                    numberOfSuggestion: 3);
                                            setState(() {
                                              englishSuggestionResponse =
                                                  suggestionResponse;
                                            });
                                          },
                                          backgroundColor: ColorManagerHelper
                                              .kMainColor
                                              .withOpacity(0.8),
                                          buttonText: "Health Growth"),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              isSuggestionLoading == false
                                  ? suggestionResponse == null
                                      ? const SizedBox(
                                          height: 45,
                                        )
                                      : Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 14.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          14.0),
                                                  color: Colors.blueGrey
                                                      .withOpacity(0.2),
                                                ),
                                                child: Center(
                                                  child: Stack(
                                                    alignment:
                                                        Alignment.bottomRight,
                                                    children: [
                                                      Column(
                                                        children: [
                                                          const Row(
                                                            children: [
                                                              Icon(IconlyBroken
                                                                  .infoCircle),
                                                              Padding(
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                        vertical:
                                                                            14.0),
                                                                child: Text(
                                                                  " Response of MML Model",
                                                                  style: FontsManagerHelper
                                                                      .bodyLarge,
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                          Text(
                                                            isSuggestionEnglish
                                                                ? englishSuggestionResponse!
                                                                : hungarianSuggestionResponse!,
                                                            style:
                                                                FontsManagerHelper
                                                                    .bodyLarge,
                                                          ),
                                                        ],
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: InkWell(
                                                          onTap: () async {
                                                            hungarianSuggestionResponse ==
                                                                    null
                                                                ? hungarianSuggestionResponse = await translateBotApi(
                                                                    translateInput:
                                                                        englishSuggestionResponse!,
                                                                    isSuggestion:
                                                                        true)
                                                                : null;
                                                            setState(() {
                                                              isSuggestionEnglish =
                                                                  !isSuggestionEnglish;
                                                            });
                                                          },
                                                          child: isTranslationSuggestionLoading
                                                              ? AppLoadingHelper
                                                                  .spinkit
                                                              : Image.asset(
                                                                  "assets/images/translate.png",
                                                                  height: 25,
                                                                  width: 25),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 70,
                                              ),
                                            ],
                                          ),
                                        )
                                  : const Center(
                                      child: Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: AppLoadingHelper.spinkit)),
                            ],
                          ),
                        )
                  : const Center(
                      child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: AppLoadingHelper.spinkit)),
            ],
          ),
        ),
      ),
      floatingActionButton: FABMenu(),
      // InkWell(
      //   onTap: () {
      //     Navigator.push(context,
      //         MaterialPageRoute(builder: (context) => const ChatBotPage()));
      //   },
      //   child: CircleAvatar(
      //     backgroundColor: Colors.transparent,
      //     radius: 40,
      //     child: Center(
      //       child: Image.asset(
      //         "assets/images/chatBot.png",
      //         height: 80,
      //         fit: BoxFit.cover,
      //       ),
      //     ),
      //   ),
      // ),
    );
  }

  Future<String> xFileToBase64(XFile xfile) async {
    try {
      // Read the XFile as bytes
      final bytes = await xfile.readAsBytes();

      // Encode the bytes as Base64
      final base64String = base64Encode(bytes);

      return base64String;
    } catch (e) {
      print('Error converting XFile to Base64: $e');
      rethrow;
    }
  }

  Future<String> botImageApi({required String base64String}) async {
    setState(() {
      isImageDetectionLoading = true;
    });
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
          "model": "gpt-4o",
          "messages": [
            {
              "role": "user",
              "content": [
                {
                  "type": "text",
                  "text":
                      "Analyze plant or leaf images to identify health issues, including diseases, pests, deficiencies, or decay. and get a pref description not increase than 150 token"
                },
                {
                  "type": "image_url",
                  "image_url": {"url": "data:image/jpeg;base64,$base64String"}
                }
              ]
            }
          ],
          "max_tokens": 150
        },
      );

      final botResponse = response.data['choices'][0]['message']['content'];
      return botResponse.toString().replaceAll('\\"', '"');
    } catch (e) {
      isImageDetectionLoading = false;
      setState(() {});
      return e.toString();

      ///
    } finally {
      isImageDetectionLoading = false;
      setState(() {});
    }
  }

  Future<String> translateBotApi(
      {required String translateInput, required bool isSuggestion}) async {
    setState(() {
      isSuggestion
          ? isTranslationSuggestionLoading = true
          : isTranslationLoading = true;
    });
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
          'model': 'gpt-4o',
          'messages': [
            {
              'role': 'user',
              'content': "translate $translateInput into Hungarian in formal way"
            },
          ],
        },
      );
      final botResponse = response.data['choices'][0]['message']['content'];
      return botResponse;
    } catch (e) {
      setState(() {
        isSuggestion
            ? isTranslationSuggestionLoading = false
            : isTranslationLoading = false;
      });
      return e.toString();
    } finally {
      setState(() {
        isSuggestion
            ? isTranslationSuggestionLoading = false
            : isTranslationLoading = false;
      });
    }
  }

  Future<String> suggestionBotApi({required int numberOfSuggestion}) async {
    setState(() {
      isSuggestionLoading = true;
    });
    String querySuggestion = "Suggest a treatment for your plant";
    switch (numberOfSuggestion) {
      case 1:
        querySuggestion = "Suggest a treatment for your plant";
        break;
      case 2:
        querySuggestion = "Suggest more information about plant";
        break;
      case 3:
        querySuggestion = "Suggest health growth tips for your plant";
        break;
    }
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
            {'role': 'user', 'content': " ${querySuggestion} "},
          ],
        },
      );

      final botResponse = response.data['choices'][0]['message']['content'];
      isSuggestionLoading = false;
      setState(() {});
      return botResponse;
    } catch (e) {
      isSuggestionLoading = false;
      setState(() {});
      return e.toString();
    } finally {
      isSuggestionLoading = false;
      setState(() {});
    }
  }
}
