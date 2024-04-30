import 'package:cloud_firestore/cloud_firestore.dart';

class ReservationModel {
  final String? id;
  final Timestamp createdAt;
  final String chaletId;
  final String cityId;
  final String userId;
  final Timestamp reservationStart;
  final Timestamp reservationEnd;

  const ReservationModel({
    this.id,
    required this.createdAt,
    required this.chaletId,
    required this.cityId,
    required this.userId,
    required this.reservationStart,
    required this.reservationEnd,
  });

  Map<String, dynamic> toJson() {
    return {
      'createdAt': createdAt,
      'chaletId': chaletId,
      'cityId': cityId,
      'userId': userId,
      'reservationStart': reservationStart,
      'reservationEnd': reservationEnd,
    };
  }

  factory ReservationModel.fromJson(Map<String, dynamic> json) {
    return ReservationModel(
      id: json['id'],
      createdAt: json['createdAt'],
      chaletId: json['chaletId'],
      cityId: json['cityId'],
      userId: json['userId'],
      reservationStart: json['reservationStart'],
      reservationEnd: json['reservationEnd'],
    );
  }

  ReservationModel copyWith({
    String? id,
    Timestamp? createdAt,
    String? chaletId,
    String? cityId,
    String? userId,
    Timestamp? reservationStart,
    Timestamp? reservationEnd,
  }) {
    return ReservationModel(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      chaletId: chaletId ?? this.chaletId,
      cityId: cityId ?? this.cityId,
      userId: userId ?? this.userId,
      reservationStart: reservationStart ?? this.reservationStart,
      reservationEnd: reservationEnd ?? this.reservationEnd,
    );
  }

  List<DateTime> getDaysInBetween() {
    List<DateTime> days = [];
    for (int i = 0; i <= reservationEnd.toDate().difference(reservationStart.toDate()).inDays; i++) {
      days.add(reservationStart.toDate().add(Duration(days: i)));
    }
    return days;
  }
}
