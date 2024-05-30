// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class Questions {
  String question;
  List<String> answer;
  num numberofcorrect;
  Questions({
    required this.question,
    required this.answer,
    required this.numberofcorrect,
  });

  Questions copyWith({
    String? question,
    List<String>? answer,
    int? numberofcorrect,
  }) {
    return Questions(
      question: question ?? this.question,
      answer: answer ?? this.answer,
      numberofcorrect: numberofcorrect ?? this.numberofcorrect,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'question': question,
      'answer': answer,
      'numberofcorrect': numberofcorrect,
    };
  }

  factory Questions.fromMap(Map<String, dynamic> map) {
    return Questions(
      question: map['question'] as String,
      answer: List<String>.generate(
          map['answer'].length, (index) => map['answer'][index]),
      numberofcorrect: map['numberofcorrect'] as num,
    );
  }

  String toJson() => json.encode(toMap());

  factory Questions.fromJson(String source) =>
      Questions.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'Questions(question: $question, answer: $answer, numberofcorrect: $numberofcorrect)';

  @override
  bool operator ==(covariant Questions other) {
    if (identical(this, other)) return true;

    return other.question == question &&
        listEquals(other.answer, answer) &&
        other.numberofcorrect == numberofcorrect;
  }

  @override
  int get hashCode =>
      question.hashCode ^ answer.hashCode ^ numberofcorrect.hashCode;
}
