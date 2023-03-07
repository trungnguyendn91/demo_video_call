import 'package:agora_uikit/agora_uikit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class VideoCallScreen extends StatefulWidget{
  const VideoCallScreen({Key? key}) : super(key: key);
  @override
  State<VideoCallScreen> createState() => _VideoCallScreenState();
}

class _VideoCallScreenState extends State<VideoCallScreen>{
  final AgoraClient _client = AgoraClient(
      agoraConnectionData: AgoraConnectionData(
        appId: 'b6c666c3dee8449690188e6efbc372d8',
        channelName: 'Agora',
        tempToken: '007eJxTYLgQf5VfRWma4UrFqUyFZ2aLLVcvmtyv6Sn9pnSO8YHL3voKDElmyWZmZsnGKampFiYmlmaWBoYWFqlmqWlJycbmRikWsXtYUxoCGRnuz5rNwsgAgSA+D0NaTmlJSWpRWGZKaj4DAwCsLiEE',
    ),
  );

  @override
  void initState(){
    super.initState();
    _initAgora();
  }

  Future<void> _initAgora() async{
    await _client.initialize();
  }
  @override
  Widget build(BuildContext context) {
   return WillPopScope(
        onWillPop: () async => false,
       child: Scaffold(
       appBar: AppBar(
         automaticallyImplyLeading: false,
         title: const Text('Agora'),
       ),
       body: SafeArea(
         child: Stack(
           children: [
             AgoraVideoViewer(
               client: _client,
               layoutType: Layout.floating,
               showNumberOfUsers: true,
             ),
             AgoraVideoButtons(
                 client: _client,
               enabledButtons: const [
                 BuiltInButtons.toggleCamera,
                 BuiltInButtons.callEnd,
                 BuiltInButtons.toggleMic
               ],
             ),
           ],
         ),
       ),
   ),
     );
  }}