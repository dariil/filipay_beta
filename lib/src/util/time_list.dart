import 'package:flutter/material.dart';
// import 'package:time_range/src/time_button.dart';
import 'time_button.dart';
import 'package:time_range/src/util/time_of_day_extension.dart';

typedef TimeSelectedCallback = void Function(TimeOfDay hour);

class TimeList extends StatefulWidget {
  TimeList({
    Key? key,
    this.padding = 0,
    required this.timeStep,
    required this.firstTime,
    required this.lastTime,
    required this.onHourSelected,
    this.initialTime,
    this.borderColor,
    this.activeBorderColor,
    this.backgroundColor,
    this.activeBackgroundColor,
    this.textStyle,
    this.activeTextStyle,
    this.alwaysUse24HourFormat = false,
  })  : assert(
          lastTime.afterOrEqual(firstTime),
          'lastTime not can be before firstTime',
        ),
        super(key: key);

  final TimeOfDay firstTime;
  final TimeOfDay lastTime;
  final TimeOfDay? initialTime;
  final int timeStep;
  final double padding;
  final TimeSelectedCallback onHourSelected;
  final Color? borderColor;
  final Color? activeBorderColor;
  final Color? backgroundColor;
  final Color? activeBackgroundColor;
  final TextStyle? textStyle;
  final TextStyle? activeTextStyle;
  final bool alwaysUse24HourFormat;

  @override
  State<TimeList> createState() => _TimeListState();
}

class _TimeListState extends State<TimeList> {
  final ScrollController _scrollController = ScrollController();
  final double itemExtent = 90;
  TimeOfDay? _selectedHour;
  List<TimeOfDay?> hours = [];

  @override
  void initState() {
    super.initState();
    _initialData();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _animateScroll(hours.indexOf(widget.initialTime));
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(TimeList oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.firstTime != widget.firstTime ||
        oldWidget.timeStep != widget.timeStep ||
        oldWidget.initialTime != widget.initialTime) {
      _initialData();
      _animateScroll(hours.indexOf(widget.initialTime));
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _initialData() {
    _selectedHour = widget.initialTime;
    _loadHours();
  }

  void _loadHours() {
    hours.clear();
    var hour =
        TimeOfDay(hour: widget.firstTime.hour, minute: widget.firstTime.minute);
    while (hour.beforeOrEqual(widget.lastTime)) {
      hours.add(
        hour.hour == TimeOfDay.hoursPerDay ? hour.replacing(hour: 0) : hour,
      );
      hour = hour.add(minutes: widget.timeStep);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: ListView.builder(
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.only(left: widget.padding),
        itemCount: hours.length,
        itemExtent: itemExtent,
        itemBuilder: (BuildContext context, int index) {
          final hour = hours[index]!;

          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: TimeButton(
              borderColor: widget.borderColor,
              activeBorderColor: widget.activeBorderColor,
              backgroundColor: widget.backgroundColor,
              activeBackgroundColor: widget.activeBackgroundColor,
              textStyle: widget.textStyle,
              activeTextStyle: widget.activeTextStyle,
              time: MaterialLocalizations.of(context).formatTimeOfDay(
                hour,
                alwaysUse24HourFormat: widget.alwaysUse24HourFormat,
              ),
              value: _selectedHour == hour,
              onSelect: (_) => _selectHour(index, hour),
            ),
          );
        },
      ),
    );
  }

  void _selectHour(int index, TimeOfDay hour) {
    _selectedHour = hour;
    _animateScroll(index);
    widget.onHourSelected(hour);
    setState(() {});
  }

  void _animateScroll(int index) {
    var offset = index < 0 ? 0.0 : index * itemExtent;
    if (offset > _scrollController.position.maxScrollExtent) {
      offset = _scrollController.position.maxScrollExtent;
    }
    _scrollController.animateTo(
      offset,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeIn,
    );
  }
}
