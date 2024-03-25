import 'dart:io';
import 'package:dart_eval/dart_eval.dart';

void main() {
  final compiler = Compiler();

  final program = compiler.compile({
    'my_package': {
      'main.dart': '''
      int main() {
        var count = 0;
        for (var i = 0; i < 1000; i++) {
          count += i;
        }
        return count;
      }
    '''
    }
  });

  final bytecode = program.write();

  final file = File('program.evc');
  file.writeAsBytesSync(bytecode);
}
