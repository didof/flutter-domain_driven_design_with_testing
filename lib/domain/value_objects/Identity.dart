import 'package:equatable/equatable.dart';

class Identity extends Equatable {
  final String id;

  Identity._(this.id);

  factory Identity.fromString(String id) {
    return Identity._(id);
  }

  @override
  List<Object> get props => [id];
}
