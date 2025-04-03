import 'dart:convert';

import 'package:edu_track/model/schedule_model.dart';
import 'package:edu_track/services/api_service.dart';

class ScheduleController {
  final ApiService _apiService = ApiService();

  Future<bool> createSchedule(Map<String, dynamic> data) async {
    final response = await _apiService.post('schedules', data);

    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  Future<Schedule> getOneSchedule(String scheduleId) async {
    final response = await _apiService.get('schedules/$scheduleId');

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      return Schedule.fromMap(data);
    } else {
      throw Exception(
          'Failed to load schedule. Status code: ${response.statusCode}');
    }
  }

  Future<List<Schedule>> getAllSchedules(String userId) async {
    final response = await _apiService.get('$userId/schedules');

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      if (data.isEmpty) {
        return [];
      }
      return data.map((e) => Schedule.fromMap(e)).toList();
    } else {
      throw Exception(
          'Failed to load schedule. Status code: ${response.statusCode}');
    }
  }

  Future<bool> updateSchedule(Map<String, dynamic> data, String scheduleId) async {
    final response =
        await _apiService.patch('schedules/$scheduleId', data);

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> deleteSchedule(String scheduleId) async {
    final response = await _apiService.delete('schedules/$scheduleId');

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}