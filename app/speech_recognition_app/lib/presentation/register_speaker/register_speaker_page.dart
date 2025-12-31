import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;
import 'package:speech_recognition_app/widgets/default_button.dart';
import 'package:speech_recognition_app/widgets/record_audio_card.dart';

typedef _Fn = void Function();

class RecordToStreamExample extends StatefulWidget {
  const RecordToStreamExample({super.key});

  @override
  State<RecordToStreamExample> createState() => _RecordToStreamExampleState();
}

class _RecordToStreamExampleState extends State<RecordToStreamExample> {
  FlutterSoundPlayer? _mPlayer = FlutterSoundPlayer();
  FlutterSoundRecorder? _mRecorder = FlutterSoundRecorder();
  bool _mRecorderIsInited = false;
  String? _mPath;
  String? _audio_1_dir;
  String? _audio_2_dir;
  String? speaker_id;
  StreamSubscription? _recorderSubscription;
  Codec codecSelected = Codec.pcm16WAV;

  double _dbLevel = 0.0;
  String? _activeAudio;
  StreamSubscription? _mRecordingDataSubscription;
  StreamController<List<int>> webStreamController = StreamController();
  TextEditingController? controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    setCodec(Codec.pcmFloat32);
    _openRecorder();
  }

  @override
  void dispose() {
    _mPlayer!.closePlayer();
    _mPlayer = null;

    stopRecorder();
    _mRecorder!.closeRecorder();
    _mRecorder = null;
    super.dispose();
  }

  Future<void> cancelRecorderSubscriptions() async {
    if (_recorderSubscription != null) {
      await _recorderSubscription!.cancel();
      _recorderSubscription = null;
    }

    if (_mRecordingDataSubscription != null) {
      await _mRecordingDataSubscription!.cancel();
      _mRecordingDataSubscription = null;
    }
  }

  Future<void> _openRecorder() async {
    var status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      // throw RecordingPermissionException('Microphone permission not granted');
    }
    if (status.isPermanentlyDenied) {
      await openAppSettings();
    }
    await _mRecorder!.openRecorder();

    _recorderSubscription = _mRecorder!.onProgress!.listen((e) {
      setState(() {
        _dbLevel = e.decibels as double;
      });
    });
    await _mRecorder!.setSubscriptionDuration(
      const Duration(milliseconds: 100),
    );

    setState(() {
      _mRecorderIsInited = true;
    });

    setState(() {
      _mRecorderIsInited = true;
    });
  }

  Future<void> record(String fileName) async {
    assert(_mRecorderIsInited && _mPlayer!.isStopped);

    final dir = await getTemporaryDirectory();

    _mPath = '${dir.path}/$fileName.wav';

    await _mRecorder!.startRecorder(
      toFile: _mPath,
      codec: Codec.pcm16WAV,
      numChannels: 1,
      sampleRate: 16000,
      audioSource: AudioSource.defaultSource,
    );

    setState(() {
      _activeAudio = fileName;
      _dbLevel = 0.0;
    });

    if (_activeAudio == "audio_1") {
      _audio_1_dir = _mPath;
    }
    if (_activeAudio == "audio_2") {
      _audio_2_dir = _mPath;
    }
  }

  Future<void> stopRecorder() async {
    await _mRecorder!.stopRecorder();

    if (_mRecordingDataSubscription != null) {
      await _mRecordingDataSubscription!.cancel();
      _mRecordingDataSubscription = null;
    }

    setState(() {
      _activeAudio = null;
    });
  }

  _Fn? getRecorderFn(String fileName) {
    if (!_mRecorderIsInited || !_mPlayer!.isStopped) {
      return null;
    }

    if (_activeAudio != null && _activeAudio != fileName) {
      return null;
    }

    return _mRecorder!.isStopped
        ? () async {
            await record(fileName);
          }
        : () async {
            await stopRecorder();
            await Future.delayed(const Duration(milliseconds: 1000));
          };
  }

  void setCodec(Codec? codec) {
    setState(() {
      codecSelected = codec!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'Registrar voz'.toString().toUpperCase(),
          style: TextStyle(
            color: Colors.white,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Column(
            children: [
              SizedBox(height: 20),
              Form(
                key: _formKey,
                child: SizedBox(
                  width: constraints.maxWidth * 0.95,
                  height: 50,
                  child: TextFormField(
                    onChanged: (value) {
                      setState(() {
                        speaker_id = value;
                      });
                    },
                    controller: controller,
                    decoration: InputDecoration(
                      labelText: 'Nome',
                      hintText: 'Digite o nome do usuário',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: Colors.black,
                          width: 1.5,
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Campo obrigatório';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              SizedBox(height: 10),
              RecordAudioCard(
                isActive: _activeAudio == "audio_1",
                mRecorder: _mRecorder,
                dbLevel: _dbLevel,
                getRecorderFn: getRecorderFn("audio_1"),
              ),
              RecordAudioCard(
                isLive: _audio_1_dir != null,
                isActive: _activeAudio == "audio_2",
                mRecorder: _mRecorder,
                dbLevel: _dbLevel,
                getRecorderFn: getRecorderFn("audio_2"),
              ),
              SizedBox(height: 10),
              DefaultButton(
                onPressed: _onPressSendAudios(),
                width: constraints.maxWidth * 0.95,
              ),
            ],
          );
        },
      ),
    );
  }

  dynamic _onPressSendAudios() {
    print("acionado");
    if (_audio_1_dir == null || _audio_2_dir == null || speaker_id == null) {
      return null;
    }
    return () {
      print("acionado");
      Fluttertoast.showToast(
        msg: "Usuário cadastrado com sucesso",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.lightGreen,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    };
  }

  Future<void> sendAudios() async {
    if (_mPath == null) return;

    final uri = Uri.parse('http://192.168.1.180:5001/register-speaker');

    final request = http.MultipartRequest('POST', uri);

    request.files.add(
      await http.MultipartFile.fromPath(
        'audio_1',
        _audio_1_dir!,
        filename: 'audio.wav',
      ),
    );
    request.files.add(
      await http.MultipartFile.fromPath(
        'audio_2',
        _audio_2_dir!,
        filename: 'audio2.wav',
      ),
    );
    request.fields['speaker_id'] = 'aleatorio';

    final response = await request.send();

    if (response.statusCode == 200) {
      final body = await response.stream.bytesToString();
      print('Upload OK: $body');
    } else {
      print('Erro no upload: ${response.statusCode}');
    }
  }
}
