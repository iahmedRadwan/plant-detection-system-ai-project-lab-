import 'package:ai_project_lab_pannon/features/home/view/widget/chatBotPage.dart';
import 'package:ai_project_lab_pannon/features/home/view/widget/voice.dart';
import 'package:ai_project_lab_pannon/shared/style/fonts_manager.dart';
import 'package:flutter/material.dart';

class FABMenu extends StatefulWidget {
  @override
  _FABMenuState createState() => _FABMenuState();
}

class _FABMenuState extends State<FABMenu> {
  bool _isMenuOpen = false;

  void _toggleMenu() {
    setState(() {
      _isMenuOpen = !_isMenuOpen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        // Camera option above Gallery
        if (_isMenuOpen)
          Padding(
            padding: const EdgeInsets.only(bottom: 130), // Position Camera
            child: FloatingActionButton.extended(
              onPressed: () {
                setState(() => _isMenuOpen = false);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const VoiceRecorderPage()));
              },
              label: Text(
                'Voice Bot',
                style:
                    FontsManagerHelper.bodySmall.copyWith(color: Colors.black),
              ),
              icon: Image.asset(
                "assets/images/voiceBot.png",
                height: 40,
                width: 45,
                fit: BoxFit.cover,
              ),
              backgroundColor: Colors.grey[200], // Neutral button color
              elevation: 0, // Remove shadow
              heroTag: 'Camera', // Ensure unique hero tag
            ),
          ),
        // Gallery option above FAB
        if (_isMenuOpen)
          Padding(
            padding: const EdgeInsets.only(bottom: 70), // Position Gallery
            child: FloatingActionButton.extended(
              onPressed: () {
                setState(() => _isMenuOpen = false);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ChatBotPage()));
              },
              label: Text(
                'ChatBot',
                style:
                    FontsManagerHelper.bodySmall.copyWith(color: Colors.black),
              ),
              icon: Image.asset(
                "assets/images/textBot.png",
                height: 40,
                width: 45,
                fit: BoxFit.cover,
              ),
              backgroundColor: Colors.grey[200], // Neutral button color
              elevation: 0, // Remove shadow
              heroTag: 'Camera', // Ensure unique hero tag
            ),
          ),
        // Main FAB
        InkWell(
          onTap: _toggleMenu,
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: 40,
            child: Center(
              child: Image.asset(
                "assets/images/chatBot.png",
                height: 60,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
