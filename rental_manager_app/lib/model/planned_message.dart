import 'package:flutter/material.dart';
import 'package:rental_manager_app/model/reservation.dart';

import 'message_scheme.dart';

class PlannedMessage {
  int id;
  String sendingTime;
  String target = "EMAIL";
  MessageScheme messageScheme;
  Reservation reservation;

  bool isBefore;
  int days;
  TimeOfDay time;

  PlannedMessage(
      {this.id,
      this.sendingTime,
      this.target = "EMAIL",
      this.messageScheme,
      this.reservation,
      this.isBefore,
      this.days,
      this.time});

  PlannedMessage.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sendingTime = json['sendingTime'];
    target = json['target'];
    messageScheme = json['messageScheme'] != null
        ? new MessageScheme.fromJson(json['messageScheme'])
        : null;
    reservation = json['reservation'] != null
        ? new Reservation.fromJson(json['reservation'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['sendingTime'] = this.sendingTime;
    data['target'] = this.target;
    if (this.messageScheme != null) {
      data['messageSchemeId'] = this.messageScheme.id;
    }
    if (this.reservation != null) {
      data['reservationId'] = this.reservation.id;
    }
    return data;
  }
}
