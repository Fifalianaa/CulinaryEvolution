import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class WeekCalendar extends StatelessWidget {
  final int selectedDayIndex;
  final List<String> weekDays;
  final List<DateTime> thisWeekDates;
  final void Function(int) onDaySelected;

  const WeekCalendar({
    super.key,
    required this.selectedDayIndex,
    required this.weekDays,
    required this.thisWeekDates,
    required this.onDaySelected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 7,
        itemBuilder: (context, index) {
          final date = thisWeekDates[index];
          final day = DateFormat('dd').format(date);
          final weekday = weekDays[index];
          final isToday = index == selectedDayIndex;

          return GestureDetector(
            onTap: () => onDaySelected(index),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 8),
              width: 60,
              decoration: BoxDecoration(
                color: isToday ? Colors.orangeAccent : Colors.transparent,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(day,
                      style: TextStyle(
                          color: isToday ? Colors.white : Colors.black,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text(weekday,
                      style: TextStyle(color: isToday ? Colors.white : Colors.black)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
