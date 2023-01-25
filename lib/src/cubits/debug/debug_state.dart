part of 'debug_cubit.dart';

@immutable
abstract class DebugState {
  final bool canShowDebug;
  final bool canShowGraph;
  final bool isDebugEnabled;
  final bool isGraphShown;
  final List<LogModel> log;
  final Map<String, dynamic> debugValues;

  const DebugState({
    required this.isDebugEnabled,
    required this.log,
    required this.canShowDebug,
    required this.debugValues,
    required this.canShowGraph,
    required this.isGraphShown,
  });

  /// returns the 5 latest messages in debugger
  Iterable<String> get latestMessages =>
      log.reversed.take(5).map((e) => e.times == 1 ? e.message : '${e.times}x ${e.message}');

  DebugState addLog(String message) =>
      AddLog(
        message,
        isDebugEnabled: isDebugEnabled,
        log: log,
        canShowDebug: canShowDebug,
        canShowGraph: canShowGraph,
        debugValues: debugValues,
        isGraphShown: isGraphShown,
      );
  DebugState addDebugValue(String key, dynamic value) => UpdateDebugValue(key, value,
        isDebugEnabled: isDebugEnabled,
        log: log,
        canShowDebug: canShowDebug,
        canShowGraph: canShowGraph,
        debugValues: debugValues,
        isGraphShown: isGraphShown,
      );
  DebugState changeVisibility() =>
      ChangeDebuggerVisibility(
        isDebugEnabled: !isDebugEnabled,
        log: log,
        canShowDebug: canShowDebug,
        canShowGraph: canShowGraph,
        debugValues: debugValues,
        isGraphShown: isGraphShown,
      );
  DebugState changeGraphVisibility() => ChangeDebuggerVisibility(
        isDebugEnabled: isDebugEnabled,
        log: log,
        canShowDebug: canShowDebug,
        canShowGraph: canShowGraph,
        debugValues: debugValues,
        isGraphShown: !isGraphShown,
      );
}

class DebugInitial extends DebugState {
  DebugInitial({required super.canShowDebug, required super.canShowGraph})
      : super(isDebugEnabled: canShowDebug, log: [], debugValues: {}, isGraphShown: false);
}

class AddLog extends DebugState {
  AddLog(String message,
      {required super.isDebugEnabled,
      required super.log,
      required super.canShowDebug,
      required super.debugValues,
      required super.canShowGraph,
      required super.isGraphShown}) {
    if (log.isNotEmpty && log.last.message == message) {
      log.last.times += 1;
      return;
    }

    log.add(LogModel(message, 1));
  }
}

class UpdateDebugValue extends DebugState {
  UpdateDebugValue(String key, dynamic value,
      {required super.isDebugEnabled,
      required super.log,
      required super.canShowDebug,
      required super.debugValues,
      required super.canShowGraph,
      required super.isGraphShown}) {
    debugValues[key] = value;
  }
}

class ChangeDebuggerVisibility extends DebugState {
  const ChangeDebuggerVisibility(
      {required super.isDebugEnabled,
      required super.log,
      required super.canShowDebug,
      required super.debugValues,
      required super.canShowGraph,
      required super.isGraphShown});
}
