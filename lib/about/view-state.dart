import 'package:equatable/equatable.dart';

class AboutViewModel extends Equatable {
  final String appVersion;

  const AboutViewModel({
    required this.appVersion,
  });

  @override
  List<Object> get props => [
        appVersion,
      ];
}
