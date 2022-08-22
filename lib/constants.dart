import 'package:flutter/material.dart';

final kGreen = Color(0xff0B8542);
final kRed = Color(0xffC1272D);
final kDisabled = Color(0xff90A4AE);
final kDisabledSecondary = Color(0xffE5E5E5);
final kGreyText = Color(0xff52575D);
final kOrange = Color(0xffE68C36);

enum Device {Tablet, Phone}

enum AvailabilityStatus{ Available, Booked, NotAvailable }

enum Role { Nurse, Manager }

Device getDeviceType() {
  final data = MediaQueryData.fromWindow(WidgetsBinding.instance.window);
  return data.size.shortestSide < 600 ? Device.Phone :Device.Tablet;
}
final specialities = [
  'Anaesthetic',
  'Cell Salvage',
  'Scrub/Scout',
  'Recovery',
  'Pre-admission',
  'Ward',
  'CSSD',
  'Porter',
  'None',
];