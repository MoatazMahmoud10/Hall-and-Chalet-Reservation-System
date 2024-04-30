import 'package:chalet_sharks/models/reservation_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class BookingScreen extends StatelessWidget {
  const BookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final data = ModalRoute.of(context)!.settings.arguments as Map<String, String?>;
    final chaletId = data['chalet_id'];
    final cityId = data['city_id'];
    DateTime? firstSelectedDay;
    final ValueNotifier<DateTime> closestBefore = ValueNotifier<DateTime>(DateTime.now().add(Duration(days: 1)));
    DateTime? closestAfter;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Booking",
          style: TextStyle(color: Colors.white, fontSize: 30),
        ),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('reservations').where("cityId", isEqualTo: cityId).where("chaletId", isEqualTo: chaletId).snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<DateTime> disabledDatesList = snapshot.data!.size > 0 ? snapshot.data?.docs.map((e) => ReservationModel.fromJson(e.data()).getDaysInBetween().map((e) => e).toList()).toList().reduce((value, element) => value + element) ?? [] : [];

              return ValueListenableBuilder(
                  valueListenable: closestBefore,
                  builder: (context, val, child) {
                    return SfDateRangePicker(
                      selectionMode: DateRangePickerSelectionMode.extendableRange,
                      monthViewSettings: DateRangePickerMonthViewSettings(showTrailingAndLeadingDates: true),
                      todayHighlightColor: Colors.blue,
                      showTodayButton: true,
                      showActionButtons: true,
                      minDate: val,
                      maxDate: closestAfter,
                      selectableDayPredicate: (date) {
                        final bool isDisabled = disabledDatesList.every((element) => !element.isSameDay(date));
                        return isDisabled;
                      },
                      onSelectionChanged: (dateRangePickerSelectionChangedArgs) {
                        if (dateRangePickerSelectionChangedArgs.value is PickerDateRange) {
                          if (firstSelectedDay != dateRangePickerSelectionChangedArgs.value.startDate) {
                            firstSelectedDay = dateRangePickerSelectionChangedArgs.value.startDate;
                            for (var element in disabledDatesList) {
                              if (element.isBefore(firstSelectedDay!)) {
                                if (element.isAfter(val)) {
                                  closestBefore.value = element;
                                }
                              } else if (element.isAfter(firstSelectedDay!)) {
                                if (closestAfter == null || element.isBefore(closestAfter!)) {
                                  closestAfter = element;
                                }
                              }
                            }
                          }
                        }
                      },
                      onCancel: () {
                        firstSelectedDay = null;
                        closestAfter = null;
                        closestBefore.value = DateTime.now().add(Duration(days: 1));
                      },
                      onSubmit: (val) {
                        if (val is PickerDateRange) {
                          if (val.startDate != null && val.endDate != null) {
                            makeReservation(context, chaletId!, cityId!, val.startDate!, val.endDate!);
                          }
                        }
                      },
                    );
                  });
            }
            return Center(child: CircularProgressIndicator());
          }),
    );
  }
}

extension DateOnlyCompare on DateTime? {
  bool isSameDay(DateTime other) {
    final bool result = this!.year == other.year && this!.month == other.month && this!.day == other.day;
    return result;
  }
}

Future<void> makeReservation(BuildContext context, String chaletId, String cityId, DateTime reservationStart, DateTime reservationEnd) async {
  try {
    final data = ReservationModel(
      createdAt: Timestamp.now(),
      chaletId: chaletId,
      cityId: cityId,
      userId: FirebaseAuth.instance.currentUser!.uid,
      reservationStart: Timestamp.fromDate(reservationStart),
      reservationEnd: Timestamp.fromDate(reservationEnd),
    );
    await FirebaseFirestore.instance.collection('reservations').add(data.toJson());

    if (context.mounted) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Chalet reserved'),
        duration: Duration(milliseconds: 700),
      ));
    }
  } catch (e) {
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error occurred while making reservation: $e'),
        duration: Duration(milliseconds: 700),
      ));
    }
  }
}
