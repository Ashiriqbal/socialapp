import 'package:agora_uikit/agora_uikit.dart';
import 'package:flutter/material.dart';
class AgoraCallScreen extends StatefulWidget {
  const AgoraCallScreen({Key? key}) : super(key: key);

  @override
  State<AgoraCallScreen> createState() => _AgoraCallScreenState();
}

class _AgoraCallScreenState extends State<AgoraCallScreen> {
  final AgoraClient client = AgoraClient(
    enabledPermission: [Permission.camera,Permission.microphone],
    agoraConnectionData: AgoraConnectionData(
      appId: "7c53d5a73e4245488dfde3f0c853303f",
      channelName: "test",
      username: "user",
    ),
  );

  @override
  void initState() {
    super.initState();
    initAgora();
  }

  void initAgora() async {
    await client.initialize();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agora VideoUIKit'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            AgoraVideoViewer(
              client: client,
              layoutType: Layout.floating,
              enableHostControls: true, // Add this to enable host controls
            ),
            AgoraVideoButtons(
              client: client,
            ),
          ],
        ),
      ),
    );
  }
}
