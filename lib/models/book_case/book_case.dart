import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'book.dart';

class BookCase extends Equatable {
  final String? kind;
  final int? totalItems;
  final List<Book>? items;

  const BookCase({this.kind, this.totalItems, this.items});

  factory BookCase.fromMap(Map<String, dynamic> data) => BookCase(
        kind: data['kind'] as String?,
        totalItems: data['totalItems'] as int?,
        items: (data['items'] as List<dynamic>?)
            ?.map((e) => Book.fromMap(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toMap() => {
        'kind': kind,
        'totalItems': totalItems,
        'items': items?.map((e) => e.toMap()).toList(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [BookCase].
  factory BookCase.fromJson(String data) {
    return BookCase.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [BookCase] to a JSON string.
  String toJson() => json.encode(toMap());

  BookCase copyWith({
    String? kind,
    int? totalItems,
    List<Book>? items,
  }) {
    return BookCase(
      kind: kind ?? this.kind,
      totalItems: totalItems ?? this.totalItems,
      items: items ?? this.items,
    );
  }

  @override
  List<Object?> get props => [kind, totalItems, items];
}
