import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:speech_recognition_app/domain/dependency_injection.dart';
import 'package:speech_recognition_app/presentation/register_speaker/bloc/register_speaker_bloc.dart';
import 'package:speech_recognition_app/presentation/register_speaker/bloc/states/register_speaker_states.dart';
import 'package:speech_recognition_app/utils/routes.dart';
import 'package:speech_recognition_app/utils/toast.dart';
import 'package:speech_recognition_app/widgets/audio_instruction_message.dart';
import 'package:speech_recognition_app/widgets/default_button.dart';
import 'package:speech_recognition_app/widgets/record_audio_card.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

typedef _Fn = void Function();

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final RegisterSpeakerBloc _registerSpeakerBloc;

  FlutterSoundRecorder? _mRecorder = FlutterSoundRecorder();
  bool _mRecorderIsInited = false;
  String? _mPath;
  String? _audio1Dir;
  String? _audio2Dir;
  String speakerId = "";
  bool isLoading = false;
  StreamSubscription? _recorderSubscription;
  Codec codecSelected = Codec.pcm16WAV;

  double _dbLevel = 0.0;
  String? _activeAudio;
  StreamSubscription? _mRecordingDataSubscription;
  StreamController<List<int>> webStreamController = StreamController();
  @override
  void initState() {
    _registerSpeakerBloc = getDependency<RegisterSpeakerBloc>();
    super.initState();
    setCodec(Codec.pcmFloat32);
    _openRecorder();
  }

  @override
  void dispose() {
    stopRecorder();
    _mRecorder!.closeRecorder();
    _mRecorder = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          'Registrar voz'.toUpperCase(),
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: BlocBuilder<RegisterSpeakerBloc, RegisterSpeakerState>(
        bloc: _registerSpeakerBloc,
        buildWhen: (previous, current) {
          if (current is RegisterSpeakerSuccess) {
            AppToast.showSuccess(current.message);
            isLoading = false;
            redirectToHomePage(context);
          }
          if (current is RegisterSpeakerError) {
            isLoading = false;
            AppToast.showError(current.message);
          }
          return true;
        },
        builder: (context, state) {
          return LayoutBuilder(
            builder: (context, constraints) {
              return SizedBox(
                height: constraints.maxHeight,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 20),
                      AudioInstructionMessage(),
                      SizedBox(height: 20),
                      RecordAudioCard(
                        isActive: _activeAudio == "audio_1",
                        mRecorder: _mRecorder,
                        dbLevel: _dbLevel,
                        getRecorderFn: getRecorderFn("audio_1"),
                      ),
                      SizedBox(height: 10),
                      DefaultButton(
                        text: "Logar",
                        isActive: _isActiveRegisterButton(),
                        isLoading: isLoading,
                        onPressed: () => _onPressRegister(),
                        width: constraints.maxWidth * 0.95,
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  bool _isActiveRegisterButton() {
    bool isNotRecording = !_mRecorder!.isRecording;
    return isNotRecording &&
        _audio1Dir != null &&
        _audio2Dir != null &&
        speakerId.isNotEmpty;
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
    if (status != PermissionStatus.granted) {}
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
    assert(_mRecorderIsInited);

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
      _audio1Dir = _mPath;
    }
    if (_activeAudio == "audio_2") {
      _audio2Dir = _mPath;
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
    if (!_mRecorderIsInited) {
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

  void _onPressRegister() {
    isLoading = true;
  }
}
