import 'package:bibliobook/providers/choose_picture_provider.dart';
import 'package:bibliobook/providers/record_audio_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

class NotesForm extends StatelessWidget {
  const NotesForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Agrega tus notas"),
      ),
      body: ListView(
        children: [
          Consumer<ChoosePictureProvider>(builder: (context, provider, child) {
            return _selectImage(provider);
          }),
          Consumer<RecordAudioProvider>(builder: (context, provider, child) {
            return _voiceRecording(provider);
          }),
          TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: "Url",
            ),
          ),
          TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: "Titulo",
            ),
          ),
          TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: "Detalles",
            ),
            maxLines: 6,
            maxLength: 200,
          ),
          ElevatedButton(
            child: Text("Guardar"),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _voiceRecording(RecordAudioProvider prov) {
    bool _recordingInProgress = prov.isRecording;
    bool _recordedAudioExists = !prov.isRecording && prov.tempPath != "";
    bool _isPlayingAudio = prov.isPlaying;

    if (_recordingInProgress) {
      return ListTile(
        leading: Icon(Icons.stop),
        title: Text("Grabando voz"),
        onTap: () {
          prov.stopRecordingAudio();
        },
      );
    } else if (!_recordingInProgress && !_recordedAudioExists) {
      return ListTile(
        leading: Icon(Icons.mic),
        title: Text("Grabar voz"),
        onTap: () {
          prov.startRecordingAudio();
        },
      );
    } else if (_recordedAudioExists && !_recordingInProgress) {
      return ListTile(
        leading: Icon(Icons.play_arrow),
        title: Text("Escuchar nota"),
        onTap: () {
          prov.playAudio();
        },
      );
    } else if (_recordedAudioExists && _isPlayingAudio) {
      return ListTile(
        leading: Icon(Icons.pause),
        title: Text("Escuchando nota"),
        onTap: () {
          prov.pauseAudio();
        },
      );
    }
    return ListTile(
      leading: Icon(Icons.mic),
      title: Text("Nota de voz"),
    );
  }

  Widget _selectImage(ChoosePictureProvider prov) {
    return GestureDetector(
      onTap: () {
        prov.choosePictureFromCamera();
      },
      child: prov.getPicture == null
          ? Container(height: 80, width: 80, color: Colors.green)
          : Image.file(prov.getPicture!),
    );
  }
}
