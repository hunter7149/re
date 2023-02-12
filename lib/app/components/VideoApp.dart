// import 'package:video_player/video_player.dart';
// import 'package:flutter/material.dart';
//
// void main() {
//   runApp(VideoApp());
// }
// class VideoApp extends StatefulWidget {
//   @override
//   _VideoAppState createState() => _VideoAppState();
// }
// class _VideoAppState extends State<VideoApp> {
//   late VideoPlayerController _controller;
//   @override
//   void initState() {
//     super.initState();
//     _controller = VideoPlayerController.network("https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4");//Specify the url/filePath/asset Path .
//     //No Need to initalize or Dispose VideoController.
//
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//
//   }
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: fluttervideoplayer(controller:_controller,enableLooping:true,enableScaling:true,flutterVolume:0.5,allowonlylandscape:false,),
//     );
//   }
// }