import 'dart:convert';

import 'package:equatable/equatable.dart';

class Pdf extends Equatable {
  final bool? isAvailable;

  const Pdf({this.isAvailable});

  factory Pdf.fromMap(Map<String, dynamic> data) => Pdf(
        isAvailable: data['isAvailable'] as bool?,
      );

  Map<String, dynamic> toMap() => {
        'isAvailable': isAvailable,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Pdf].
  factory Pdf.fromJson(String data) {
    return Pdf.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Pdf] to a JSON string.
  String toJson() => json.encode(toMap());

  Pdf copyWith({
    bool? isAvailable,
  }) {
    return Pdf(
      isAvailable: isAvailable ?? this.isAvailable,
    );
  }

  @override
  List<Object?> get props => [isAvailable];
}
