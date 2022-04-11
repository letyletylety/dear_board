import 'package:flutter/services.dart';
import 'package:flutter_midi/flutter_midi.dart';

class BoardController {
  static const yamahaGrandLite = 'assets/Yamaha-Grand-Lite-v2.0.sf2';

  final _midi = FlutterMidi();

  Future load(String asset) async {
    await _midi.unmute();
    ByteData _byte = await rootBundle.load(asset);
    await _midi.prepare(
      sf2: _byte,
    );
  }

  playNote(int key) {
    _midi.playMidiNote(midi: key);
  }

  stopNote(int key) {
    _midi.stopMidiNote(midi: key);
  }
}

enum MidiState {
  notReady,
  ready,
}

class NoteModel {
  final int chan;

  /// pitch
  final int key;
  final int velocity;

  NoteModel({this.chan = 0, required this.key, this.velocity = 120});
}
