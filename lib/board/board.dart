import 'package:dear_board/board/board_controller.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:piano/piano.dart';

final boardControllerProvider =
    Provider<BoardController>((ref) => BoardController());

final controllerReadyProvider = FutureProvider((ref) {
  final boardCtrl = ref.watch(boardControllerProvider);
  return boardCtrl.load(BoardController.yamahaGrandLite);
});

class Board2 extends ConsumerWidget {
  const Board2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    return Column(
      children: [
        Container(
            height: 20,
            color: ref.watch(controllerReadyProvider).isLoading
                ? Colors.red
                : Colors.green),
        Expanded(
          child: InteractivePiano(
            highlightedNotes: [NotePosition(note: Note.C, octave: 3)],
            naturalColor: Colors.white,
            accidentalColor: Colors.black,
            keyWidth: 60,
            noteRange: NoteRange(
              NotePosition(note: Note.C, octave: 3),
              NotePosition(note: Note.B, octave: 4),
            ),
            // noteRange: NoteRange.forClefs([
            //   Clef.Treble,
            // ]),
            onNotePositionTapped: (position) {
              // Use an audio library like flutter_midi to play the sound
              int pitch = position.pitch;
              ref.read(boardControllerProvider).playNote(pitch);
              // ref.read(midiProvider).noteOn(NoteModel(key: pitch));
            },
          ),
        ),
      ],
    );
  }
}

// import 'package:dear_board/board/midi_notifier.dart';
// import 'package:flutter/material.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:piano/piano.dart';

// final midiProvider =
//     Provider<MidiNotifier>((ref) => MidiNotifier()..readyMidiController());

// final midiState = StateNotifierProvider<MidiNotifier, MidiState>((ref) {
//   return ref.watch(midiProvider);
// });

// class Board extends ConsumerWidget {
//   const Board({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return Column(
//       children: [
//         Container(
//           height: 20,
//           color: (ref.watch(midiState) == MidiState.notReady
//               ? Colors.red
//               : Colors.green),
//         ),
//         Expanded(
//           child: InteractivePiano(
//             highlightedNotes: [NotePosition(note: Note.C, octave: 3)],
//             naturalColor: Colors.white,
//             accidentalColor: Colors.black,
//             keyWidth: 60,
//             noteRange: NoteRange.forClefs([
//               Clef.Alto,
//             ]),
//             onNotePositionTapped: (position) {
//               // Use an audio library like flutter_midi to play the sound
//               int pitch = position.pitch;
//               ref.read(midiProvider).noteOn(NoteModel(key: pitch));
//             },
//           ),
//         ),
//       ],
//     );
//   }
// }
