part of 'debug_cubit.dart';

@immutable
abstract class DebugState {
  final bool isDebugEnabled;
  final List<String> log;

  const DebugState({required this.isDebugEnabled, required this.log});

  /// returns the 5 latest messages in debugger
  Iterable<String> get latestMessages => log.reversed.take(5);

  DebugState addLog(String message) => AddLog(message, isDebugEnabled: isDebugEnabled, log: log);
  DebugState changeVisibility() => ChangeDebuggerVisibility(isDebugEnabled: !isDebugEnabled, log: log);
}

class DebugInitial extends DebugState {
  DebugInitial() : super(isDebugEnabled: kDebugMode, log: []);
}

class AddLog extends DebugState {
  AddLog(String message, {required super.isDebugEnabled, required super.log}) {
    log.add(message);
  }
}

class ChangeDebuggerVisibility extends DebugState {
  const ChangeDebuggerVisibility({required super.isDebugEnabled, required super.log});
}
