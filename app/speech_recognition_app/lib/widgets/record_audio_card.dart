import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';

class RecordAudioCard extends StatelessWidget {
  final FlutterSoundRecorder? mRecorder;
  final double dbLevel;
  final Function()? getRecorderFn;
  final bool isActive;
  final bool isLive; // 👈 novo parâetro

  const RecordAudioCard({
    super.key,
    required this.mRecorder,
    required this.dbLevel,
    required this.getRecorderFn,
    required this.isActive,
    this.isLive = true, // 👈 default true
  });

  @override
  Widget build(BuildContext context) {
    final isRecording = mRecorder!.isRecording && isActive && isLive;

    return Opacity(
      opacity: isLive ? 1.0 : 0.45,  
      child: IgnorePointer(
        ignoring: !isLive, 
        child: Container(
          margin: const EdgeInsets.all(12),
          padding: const EdgeInsets.all(16),
          height: 120,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.black12),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 6,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  ElevatedButton.icon(
                    onPressed: isLive ? getRecorderFn : null,  
                    icon: Icon(
                      isRecording ? Icons.stop : Icons.mic,
                      size: 18,
                    ),
                    label: Text(isRecording ? 'Parar' : 'Gravar'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          isRecording ? Colors.black : Colors.white,
                      foregroundColor:
                          isRecording ? Colors.white : Colors.black,
                      side: const BorderSide(color: Colors.black),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      !isLive
                          ? 'Gravação desativada'
                          : isRecording
                              ? 'Gravação em andamento'
                              : 'Pronto para gravar',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              AnimatedOpacity(
                duration: const Duration(milliseconds: 300),
                opacity: isRecording ? 1.0 : 0.0,
                child: LinearProgressIndicator(
                  value: (dbLevel.clamp(0, 100)) / 100,
                  backgroundColor: Colors.black12,
                  valueColor:
                      const AlwaysStoppedAnimation<Color>(Colors.black),
                  minHeight: 6,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
