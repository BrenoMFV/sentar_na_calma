import 'package:flutter/foundation.dart';

class MeditationSession with ChangeNotifier {
  Duration? timer;
  DateTime? start;
  DateTime? end;
  Duration? totalDuration;

  MeditationSession({
    this.timer,
    this.start,
    this.end,
    this.totalDuration,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['timer'] = timer?.inSeconds;
    data['start'] = start?.toIso8601String();
    data['end'] = end?.toIso8601String();
    data['total_duration'] = totalDuration?.inSeconds ?? timer?.inSeconds;
    return data;
  }
}
