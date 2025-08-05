import 'dart:io';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';

class ChannelFileLogOutput extends LogOutput {
  
  final Map<Level, String> levelToFileName = {
    Level.info: 'info.log',
    Level.warning: 'warning.log',
    Level.error: 'error.log',
  };

  Future<File> _getLogFile(Level level) async {
    final directory = await getApplicationDocumentsDirectory();
    final logDir = Directory('${directory.path}/logs');

    if (!await logDir.exists()) {
      await logDir.create(recursive: true);
    }

    final fileName = levelToFileName[level] ?? 'flutter.log';
    final file = File('${logDir.path}/$fileName');

    if (!await file.exists()) {
      await file.create();
    }
    
    return file;
  }

  @override
  void output(OutputEvent event) async {
    for (var line in event.lines) {
      final file = await _getLogFile(event.level);
      await file.writeAsString('$line\n', mode: FileMode.append);
    }
  }
}

final log = Logger(
  printer: PrettyPrinter(
    methodCount: 1,
    errorMethodCount: 5,
    lineLength: 100,
    colors: false,
    printEmojis: false,
    printTime: true,
  ),
  output: MultiOutput([
    ConsoleOutput(),
    ChannelFileLogOutput(),
  ]),
);
