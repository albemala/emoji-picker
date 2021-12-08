import 'dart:convert';
import 'dart:io';

/*
* Unicode character list created by Rodrigo Siqueira
* Source: https://gist.github.com/ivandrofly/0fe20773bd712b303f78
*/

void main() {
  final data = File('symbols.txt')
      .readAsStringSync()
      //
      .replaceAll(' = ', ', ');

  var group = '';
  final List<Map<String, String>> symbols = [];

  for (var line in const LineSplitter().convert(data)) {
    if (line.trim().isEmpty) {
      continue;
    }
    final split = line.split('\t');
    if (split.length == 1) {
      group = line;
      print(group);
    } else {
      final code = split.first.trim();
      final name = split.last.trim();
      print('$code: $name');
      if (code.isNotEmpty) {
        symbols.add(
          {
            'char': code,
            'name': name,
            'group': group,
          },
        );
      }
    }
  }
  final encoded = json.encode(symbols);
  // print(encoded);
  File('../assets/symbols.json').writeAsStringSync(encoded);
}
