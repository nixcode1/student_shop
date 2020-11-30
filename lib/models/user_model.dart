import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class AppUser{
  
  String id;
  String name;
  String email;
  String phoneNo;
  String address;

  AppUser([this.id, this.name, this.address, this.email, this.phoneNo]);

  factory AppUser.fromJson(Map<String, dynamic> json) => _$AppUserFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$AppUserToJson(this);
}