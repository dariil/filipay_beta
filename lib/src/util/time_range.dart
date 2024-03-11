import 'package:flutter/material.dart';
import 'package:time_range/src/util/time_of_day_extension.dart';

import 'time_list.dart';

typedef TimeRangeSelectedCallback = void Function(TimeRangeResult? range);

class TimeRange extends StatefulWidget {
  TimeRange({
    Key? key,
    required this.timeBlock,
    required this.onRangeCompleted,
    required this.firstTime,
    required this.lastTime,
    this.onFirstTimeSelected,
    this.minimalTimeRange,
    this.timeStep = 60,
    this.fromTitle,
    this.toTitle,
    this.titlePadding = 0,
    this.initialRange,
    this.borderColor,
    this.activeBorderColor,
    this.backgroundColor,
    this.activeBackgroundColor,
    this.textStyle,
    this.activeTextStyle,
    this.alwaysUse24HourFormat = false,
  })  : assert(
          lastTime.after(firstTime),
          'lastTime can not be before firstTime',
        ),
        super(key: key);

  final int timeStep;
  final int timeBlock;
  final int? minimalTimeRange;
  final TimeOfDay firstTime;
  final TimeOfDay lastTime;
  final Widget? fromTitle;
  final Widget? toTitle;
  final double titlePadding;
  final TimeRangeSelectedCallback onRangeCompleted;
  final TimeSelectedCallback? onFirstTimeSelected;
  final TimeRangeResult? initialRange;
  final Color? borderColor;
  final Color? activeBorderColor;
  final Color? backgroundColor;
  final Color? activeBackgroundColor;
  final TextStyle? textStyle;
  final TextStyle? activeTextStyle;
  final bool alwaysUse24HourFormat;

  @override
  State<TimeRange> createState() => _TimeRangeState();
}

class _TimeRangeState extends State<TimeRange> {
  TimeOfDay? _startHour;
  TimeOfDay? _endHour;

  @override
  void initState() {
    super.initState();
    setRange();
  }

  @override
  void didUpdateWidget(TimeRange oldWidget) {
    super.didUpdateWidget(oldWidget);
    setRange();
  }

  void setRange() {
    if (widget.initialRange != null) {
      _startHour = widget.initialRange!.start;
      _endHour = widget.initialRange!.end;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TimeList(
          firstTime: widget.firstTime,
          lastTime: widget.lastTime
              .subtract(minutes: widget.minimalTimeRange ?? widget.timeBlock),
          initialTime: _startHour,
          timeStep: widget.timeStep,
          padding: widget.titlePadding,
          onHourSelected: _startHourChanged,
          borderColor: widget.borderColor,
          activeBorderColor: widget.activeBorderColor,
          backgroundColor: widget.backgroundColor,
          activeBackgroundColor: widget.activeBackgroundColor,
          textStyle: widget.textStyle,
          activeTextStyle: widget.activeTextStyle,
          alwaysUse24HourFormat: widget.alwaysUse24HourFormat,
        ),
      ],
    );
  }

  TimeOfDay _getFirstTimeEndHour() {
    final timeMinutes = widget.minimalTimeRange ?? widget.timeBlock;

    return _startHour == null
        ? widget.firstTime.add(minutes: timeMinutes)
        : _startHour!.add(minutes: timeMinutes);
  }

  void _startHourChanged(TimeOfDay hour) {
    // setState(() => _startHour = hour);
    setState(() {
      _startHour = hour;
      // print(_startHour);
    });

    widget.onFirstTimeSelected?.call(hour);

    if (_endHour != null) {
      if (_endHour!.inMinutes() <= _startHour!.inMinutes() ||
          (_endHour!.inMinutes() - _startHour!.inMinutes())
                  .remainder(widget.timeBlock) !=
              0) {
        _endHour = null;
        widget.onRangeCompleted(null);
      } else {
        widget.onRangeCompleted(TimeRangeResult(_startHour!, _endHour!));
      }
    }
  }

  void _endHourChanged(TimeOfDay hour) {
    setState(() => _endHour = hour);
    if (_startHour != null) {
      widget.onRangeCompleted(TimeRangeResult(_startHour!, _endHour!));
    }
  }
}

class TimeRangeResult {
  TimeRangeResult(this.start, this.end);

  final TimeOfDay start;
  final TimeOfDay end;
}
