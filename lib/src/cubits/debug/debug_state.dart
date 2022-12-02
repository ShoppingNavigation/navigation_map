part of 'debug_cubit.dart';

@immutable
abstract class DebugState {
  final bool canShowDebug;
  final bool isDebugEnabled;
  final List<String> log;

  const DebugState({required this.isDebugEnabled, required this.log, required this.canShowDebug});

  /// returns the 5 latest messages in debugger
  Iterable<String> get latestMessages => log.reversed.take(5);

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
    log.add(message);
  }
}

class ChangeDebuggerVisibility extends DebugState {
  const ChangeDebuggerVisibility({required super.isDebugEnabled, required super.log, required super.canShowDebug});
}
