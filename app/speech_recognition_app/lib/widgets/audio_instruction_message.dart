import 'package:flutter/material.dart';

class AudioInstructionMessage extends StatelessWidget {
  const AudioInstructionMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.95,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.black, width: 1),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Icon(
            Icons.info_outline,
            color: Colors.black,
          ),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              'Para garantir a qualidade do reconhecimento de voz, '
              'grave dois áudios diferentes do mesmo locutor.',
              style: TextStyle(
                color: Colors.black,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
