import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';
import 'package:video_player/video_player.dart';

class RecordAudioProvider with ChangeNotifier {
  final record = Record();
  VideoPlayerController? audioPlayer;

  Directory? tempDir;
  String tempPath = "";
  String file64 = "";
  bool isRecording = false;
  bool isPlaying = false;
  File? audioFile;

  void startRecordingAudio() async {
    tempDir = await getExternalStorageDirectory();
    tempPath = tempDir!.path;
    await record.hasPermission();
    isRecording = true;
    notifyListeners();
    // Start recording
    await record.start(
      path: '$tempPath/recording.m4a', // required
      encoder: AudioEncoder.aacLc, // by default
      bitRate: 128000, // by default
      samplingRate: 44100, // by default
    );

    // var amplitud = await record.getAmplitude();
  }

  void stopRecordingAudio() async {
    // Stop recording
    await record.stop();
    var _recordedSoundBytes = File("$tempPath/recording.m4a").readAsBytesSync();
    // Codificar el archivo como String base 64
    audioFile = File("$tempPath/recording.m4a");
    file64 = base64Encode(_recordedSoundBytes);
    // TODO: Dato para guardar en firebase
    isRecording = false;
    notifyListeners();
  }

  void playAudio() async {
    isPlaying = true;
    notifyListeners();
    audioPlayer = VideoPlayerController.file(audioFile!)
      ..addListener(() => notifyListeners())
      ..setLooping(false);
    await audioPlayer!.initialize();
    notifyListeners();
    await audioPlayer!.play();
    isPlaying = false;
    notifyListeners();
  }

  void pauseAudio() async {
    await audioPlayer!.pause();
    isPlaying = false;
    notifyListeners();
  }
}
