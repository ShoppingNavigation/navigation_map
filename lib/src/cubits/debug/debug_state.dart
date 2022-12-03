part of 'debug_cubit.dart';

@immutable
abstract class DebugState {
  final bool canShowDebug;
  final bool isDebugEnabled;
  final List<LogModel> log;

  const DebugState({required this.isDebugEnabled, required this.log, required this.canShowDebug});

  /// returns the 5 latest messages in debugger
  Iterable<String> get latestMessages =>
      log.reversed.take(5).map((e) => e.times == 1 ? e.message : '${e.times}x ${e.message}');

  DebugState addLog(String message) =>
      AddLog(message, isDebugEnabled: isDebugEnabled, log: log, canShowDebug: canShowDebug);
  DebugState changeVisibility() =>
      ChangeDebuggerVisibility(isDebugEnabled: !isDebugEnabled, log: log, canShowDebug: canShowDebug);
}

class DebugInitial extends DebugState {
  DebugInitial({required super.canShowDebug}) : super(isDebugEnabled: canShowDebug, log: []);
}

class AddLog extends DebugState {
  AddLog(String message, {required super.isDebugEnabled, required super.log, required super.canShowDebug}) {
    if (log.isNotEmpty && log.last.message == message) {
      log.last.times += 1;
      return;
    }

    log.add(LogModel(message, 1));
  }
}

class ChangeDebuggerVisibility extends DebugState {
  const ChangeDebuggerVisibility({required super.isDebugEnabled, required super.log, required super.canShowDebug});
}
