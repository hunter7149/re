// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';

class MenuModel {
  String? tittle;
  String? image;
  Color? color;
  MenuModel({
    this.tittle,
    this.image,
    this.color,
  });

  MenuModel copyWith({
    String? tittle,
    String? image,
    Color? color,
  }) {
    return MenuModel(
      tittle: tittle ?? this.tittle,
      image: image ?? this.image,
      color: color ?? this.color,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'tittle': tittle,
      'image': image,
      'color': color?.value,
    };
  }

  factory MenuModel.fromMap(Map<String, dynamic> map) {
    return MenuModel(
      tittle: map['tittle'] != null ? map['tittle'] as String : null,
      image: map['image'] != null ? map['image'] as String : null,
      color: map['color'] != null ? Color(map['color'] as int) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory MenuModel.fromJson(String source) =>
      MenuModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'MenuModel(tittle: $tittle, image: $image, color: $color)';

  @override
  bool operator ==(covariant MenuModel other) {
    if (identical(this, other)) return true;

    return other.tittle == tittle &&
        other.image == image &&
        other.color == color;
  }

  @override
  int get hashCode => tittle.hashCode ^ image.hashCode ^ color.hashCode;
}
