import 'dart:developer';


import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:video_call/pages/video_call.dart';

class IndexPage extends StatefulWidget{
  const IndexPage ({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => IndexState();
}

class IndexState extends State<IndexPage> {
  final _channelController = TextEditingController();
  bool _validateError = false;
  ClientRoleType _roleType = ClientRoleType.clientRoleBroadcaster;

  @override
  void dispose() {
    _channelController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text('Agora'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox( height: 40,),
              Image.network('https://tinyurl.com/2p889y4k'),
              const SizedBox(height: 20,),
              TextField(
                controller: _channelController,
                decoration:  InputDecoration(
                  errorText:
                    _validateError? 'Chanel name is mandatory': null,
                  border: const UnderlineInputBorder(
                    borderSide: BorderSide(width: 1)
                  ),
                  hintText: 'Channel name',
                ),
              ),
              RadioListTile(
                title: const Text('Broadcaster'),
                onChanged: (ClientRoleType? value){
                  setState(() {
                    _roleType = value!;
                  });
                },
                value: ClientRoleType.clientRoleBroadcaster, groupValue: _roleType,
              ),
              RadioListTile(
                title: const Text('Audience'),
                onChanged: (ClientRoleType? value){
                  setState(() {
                    _roleType = value!;
                  });
                },
                value: ClientRoleType.clientRoleAudience,
                groupValue: _roleType,
              ),
              ElevatedButton(
                  onPressed: onJoint,
                  child: const Text('Join'),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 40)
                  ) ,
              )
            ],
          ),
        ),
      ),
    );
  }
  Future<void> onJoint() async{
    setState(() {
      _channelController.text.isEmpty
          ? _validateError = true
          : _validateError = false;
    });
    if (_channelController.text.isNotEmpty){
      await _handleCameraAndMic(Permission.camera);
      await _handleCameraAndMic(Permission.microphone);
      await Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => VideoCallScreen()
          )
      );
    }
  }
  Future<void> _handleCameraAndMic(Permission permission) async {
    final status = await permission.request();
    log(status.toString());
  }
}

