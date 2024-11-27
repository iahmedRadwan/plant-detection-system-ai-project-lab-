import 'package:ai_project_lab_pannon/features/common/core/view/components/custom_dot_loading.dart';
import 'package:ai_project_lab_pannon/shared/style/colors_manager.dart';
import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:just_audio/just_audio.dart';
import 'package:path_provider/path_provider.dart';

import '../../../../shared/style/fonts_manager.dart';
import '../../../common/core/view/components/custom_appbar.dart';

class VoiceRecorderPage extends StatefulWidget {
  const VoiceRecorderPage({super.key});

  @override
  _VoiceRecorderPageState createState() => _VoiceRecorderPageState();
}

class _VoiceRecorderPageState extends State<VoiceRecorderPage> {
  final RecorderController recorderController = RecorderController();
  final AudioPlayer audioPlayer = AudioPlayer();
  bool isRecording = false;
  bool isLoadingResponse = false;
  String? responseText;
  String? recordedFilePath;

  @override
  void dispose() {
    recorderController.dispose();
    audioPlayer.dispose();
    super.dispose();
  }

  Future<String> _getFilePath() async {
    final directory = await getApplicationDocumentsDirectory();
    return '${directory.path}/audio.m4a';
  }

  Future<void> _startRecording() async {
    final permissionGranted = await recorderController.checkPermission();
    if (permissionGranted) {
      try {
        final path = await _getFilePath();
        await recorderController.record(path: path);
        setState(() {
          isRecording = true;
          recordedFilePath = null;
        });
      } catch (e) {
        print("Error while starting recording: $e");
      }
    } else {
      print("Microphone permission is required");
    }
  }

  Future<void> _stopRecording() async {
    try {
      final path = await recorderController.stop();
      setState(() {
        isRecording = false;
        recordedFilePath = path;
      });
      print("Recording saved to: $path");
    } catch (e) {
      print("Error while stopping recording: $e");
    }
  }

  Future<void> _playRecording() async {
    if (recordedFilePath != null) {
      try {
        await audioPlayer.setFilePath(recordedFilePath!);
        await audioPlayer.play();
      } catch (e) {
        print("Error while playing audio: $e");
      }
    }
  }

  Future<void> _uploadRecording() async {
    if (recordedFilePath == null) return;

    try {
      setState(() {
        isLoadingResponse = true;
      });
      final dio = Dio();
      final formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(
          recordedFilePath!,
          filename: 'audio.m4a',
        ),
        'model': 'whisper-1',
      });

      final response = await dio.post(
        'https://api.openai.com/v1/audio/transcriptions',
        data: formData,
        options: Options(
          headers: {
            'Authorization': 'Bearer ${dotenv.env['OPENAIKEY']}',
            'Content-Type': 'multipart/form-data',
          },
        ),
      );
      final responses = await Dio().post(
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
            {'role': 'user', 'content': "${response.data["text"]} in profisional english response"},
          ],
        },
      );
      responseText = responses.data["choices"][0]["message"]["content"];
    } catch (e) {
      print("Error while uploading file: $e");
    } finally {
      setState(() {
        isLoadingResponse = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "VoiceBot",
        onPressed: () {
          Navigator.pop(context);
        },
        isLeading: false,
        actions: [
          Image.asset(
            "assets/images/voiceBot.png",
            height: 40,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
        child: recordedFilePath == null
            ? Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: recordedFilePath == null
                        ? MainAxisAlignment.center
                        : MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      if (isRecording)
                        _buildRecordingUI()
                      else if (recordedFilePath != null)
                        _buildRecordedCard()
                      else
                        _buildInitialUI(),
                      const SizedBox(height: 32),
                    ],
                  ),
                ),
              )
            : SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: recordedFilePath == null
                      ? MainAxisAlignment.center
                      : MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (isRecording)
                      _buildRecordingUI()
                    else if (recordedFilePath != null)
                      _buildRecordedCard()
                    else
                      _buildInitialUI(),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
      ),
      floatingActionButton: GestureDetector(
        onLongPress: _startRecording,
        onLongPressUp: _stopRecording,
        child: CircleAvatar(
          radius: 30,
          backgroundColor: ColorManagerHelper.kMainColor,
          child: Icon(
            isRecording ? Icons.stop : Icons.mic,
            size: 40,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildInitialUI() {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.mic_none,
          size: 100,
          color: Colors.blue,
        ),
        SizedBox(height: 16),
        Text(
          "Hold the mic to start recording",
          style: TextStyle(fontSize: 18, color: Colors.blueGrey),
        ),
      ],
    );
  }

  Widget _buildRecordingUI() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Animated scaling for the waveform container
          AnimatedScale(
            scale: isRecording ? 1.1 : 1.0,
            duration: const Duration(milliseconds: 5000),
            curve: Curves.easeInOut,
            child: Container(
              height: 70,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.blueAccent.withOpacity(0.2),
                    Colors.blueAccent.withOpacity(0.4),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: AudioWaveforms(
                recorderController: recorderController,
                size: const Size(double.infinity, 70),
                waveStyle: WaveStyle(
                  waveColor: Colors.blueAccent
                      .withOpacity(0.8), // Add slight transparency for softness
                  extendWaveform:
                      true, // Ensures the wave fills the available space
                  showMiddleLine: true, // Retain the middle line
                  middleLineColor: Colors
                      .blue.shade700, // Slightly darker shade for contrast
                  middleLineThickness: 1.5, // Subtle thickness for elegance
                  waveThickness: 3.0, // Define waveform thickness
                  waveCap: StrokeCap.round, // Smooth edges for the wave
                  backgroundColor:
                      Colors.white, // Optional: Define a clean background
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
          // Animated rotating mic icon
          AnimatedBuilder(
            animation: recorderController,
            builder: (_, __) => Transform.rotate(
              angle: isRecording
                  ? 0.1
                  : 0.0, // Small rotation for a "shaking" effect
              child: const Icon(
                Icons.mic,
                size: 60,
                color: ColorManagerHelper.kMainColor,
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Gradient text with animation
          ShaderMask(
            shaderCallback: (Rect bounds) {
              return const LinearGradient(
                colors: [ColorManagerHelper.kMainColor, Colors.blueGrey],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ).createShader(bounds);
            },
            child: const Text(
              "Recording... Please speak.",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color:
                    Colors.white, // This gets overridden by the gradient shader
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecordedCard() {
    return Column(
      children: [
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          color: Colors.blue.shade50,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/file.png",
                  height: 120,
                ),
                const Text(
                  "Your Record Ready to Ask ",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: _playRecording,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorManagerHelper.kMainColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text("Play Record"),
                    ),
                    ElevatedButton(
                      onPressed: _uploadRecording,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorManagerHelper.kMainColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text("Ask VoiceBot "),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        isLoadingResponse
            ? AppLoadingHelper.spinkit
            : const SizedBox(
                height: 10,
              ),
        responseText != null
            ? Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
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
                                    padding:
                                        EdgeInsets.symmetric(vertical: 14.0),
                                    child: Text(
                                      " Response of MML Model",
                                      style: FontsManagerHelper.bodyLarge,
                                    ),
                                  )
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.all(14.0),
                                child: Text(
                                  responseText!,
                                  style: FontsManagerHelper.bodyLarge,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            : Container(),
      ],
    );
  }
}
