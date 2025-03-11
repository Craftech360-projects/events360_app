import 'package:events360/data/models/agenda_item.dart';
import 'package:events360/data/models/event.dart';
import 'package:events360/data/models/speaker.dart';
import 'package:events360/data/models/sponsor.dart';
import 'package:events360/data/models/user.dart' as app_user;
import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  static final SupabaseService _instance = SupabaseService._internal();
  static late final SupabaseClient _client;

  factory SupabaseService() => _instance;

  SupabaseService._internal();

  static Future<void> initialize() async {
    await Supabase.initialize(
      url: "https://tpwmccdmctsnlhofmhbp.supabase.co",
      anonKey:
          "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InRwd21jY2RtY3Rzbmxob2ZtaGJwIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDExNjA4NDAsImV4cCI6MjA1NjczNjg0MH0.2PPSN0S09NG0cYgsUGLmxuQgGu9Ibu5mGh9kdfqx18Y",
    );

    _client = Supabase.instance.client;
  }

  static SupabaseClient get client => _client;

  Future<List<Event>> getEvents() async {
    final response = await _client.from('events').select().order('start_date');
    return response.map((json) => Event.fromJson(json)).toList();
  }

  Future<Event> getEvent(int id) async {
    final response =
        await _client.from('events').select().eq('id', id).single();
    return Event.fromJson(response);
  }

  // Agenda Items
  Future<List<AgendaItem>> getAgendaItems(int eventId) async {
    final response = await _client
        .from('agenda_items')
        .select('*, speakers(*)')
        .eq('event_id', eventId)
        .order('start_time');

    return response.map((json) {
      // Create a modified JSON with the speaker properly nested
      final modifiedJson = Map<String, dynamic>.from(json);
      if (json['speakers'] != null) {
        modifiedJson['speaker'] = json['speakers'];
      }
      return AgendaItem.fromJson(modifiedJson);
    }).toList();
  }

  // Speakers
  Future<List<Speaker>> getEventSpeakers(int eventId) async {
    try {
      // First, get the array of speaker IDs for this event
      final response = await _client
          .from('event_speakers')
          .select('speaker_ids')
          .eq('event_id', eventId)
          .single();

      // Extract the array of speaker IDs
      final List<dynamic> speakerIds = response['speaker_ids'] ?? [];

      if (speakerIds.isEmpty) {
        return [];
      }

      // Now fetch all speakers whose IDs are in the array
      final speakersResponse = await _client
          .from('speakers')
          .select()
          .inFilter('id', speakerIds)
          .order('name');

      return (speakersResponse as List)
          .map((speakerData) => Speaker.fromJson(speakerData))
          .toList();
    } on Exception catch (e) {
      debugPrint('Error fetching event speakers: $e');
      return [];
    }
  }

  Future<bool> updateEventSpeakers(int eventId, List<int> speakerIds) async {
    try {
      // Check if entry exists for this event
      final existingEntry = await _client
          .from('event_speakers')
          .select('id')
          .eq('event_id', eventId)
          .maybeSingle();

      if (existingEntry != null) {
        // Update existing entry
        await _client.from('event_speakers').update({
          'speaker_ids': speakerIds,
          'updated_at': DateTime.now().toIso8601String()
        }).eq('event_id', eventId);
      } else {
        // Create new entry
        await _client.from('event_speakers').insert({
          'event_id': eventId,
          'speaker_ids': speakerIds,
        });
      }
      return true;
    } on Exception catch (e) {
      debugPrint('Error updating event speakers: $e');
      return false;
    }
  }

  Future<List<Speaker>> getAllSpeakers() async {
    final response = await _client.from('speakers').select();
    return response.map((json) => Speaker.fromJson(json)).toList();
  }

  // Attendees
  Future<List<app_user.User>> getEventAttendees(int eventId) async {
    try {
      // First, get the array of user IDs for this event
      final response = await _client
          .from('event_attendees')
          .select('user_ids')
          .eq('event_id', eventId)
          .single();

      // Extract the array of user IDs
      final List<dynamic> userIds = response['user_ids'] ?? [];

      if (userIds.isEmpty) {
        return [];
      }

      // Now fetch all users whose UUIDs are in the array
      final usersResponse = await _client
          .from('users')
          .select()
          .inFilter('uuid', userIds) // Changed from 'id' to 'uuid'
          .order('name');

      return (usersResponse as List)
          .map((userData) => app_user.User.fromJson(userData))
          .toList();
    } on Exception catch (e) {
      debugPrint('Error fetching event attendees: $e');
      return [];
    }
  }

  Future<bool> updateEventAttendees(int eventId, List<int> userIds) async {
    try {
      // Check if entry exists for this event
      final existingEntry = await _client
          .from('event_attendees')
          .select('id')
          .eq('event_id', eventId)
          .maybeSingle();

      if (existingEntry != null) {
        // Update existing entry
        await _client.from('event_attendees').update({
          'user_ids': userIds,
          'updated_at': DateTime.now().toIso8601String()
        }).eq('event_id', eventId);
      } else {
        // Create new entry
        await _client.from('event_attendees').insert({
          'event_id': eventId,
          'user_ids': userIds,
        });
      }
      return true;
    } on Exception catch (e) {
      debugPrint('Error updating event attendees: $e');
      return false;
    }
  }

  // Sponsors
  Future<List<Sponsor>> getEventSponsors(int eventId) async {
    try {
      // First, get the array of sponsor IDs for this event
      final response = await _client
          .from('event_sponsors')
          .select('sponsor_ids')
          .eq('event_id', eventId)
          .single();

      // Extract the array of sponsor IDs
      final List<dynamic> sponsorIds = response['sponsor_ids'] ?? [];

      if (sponsorIds.isEmpty) {
        return [];
      }

      // Now fetch all sponsors whose IDs are in the array
      final sponsorsResponse = await _client
          .from('sponsors')
          .select()
          .inFilter('id', sponsorIds)
          .order('name');

      return (sponsorsResponse as List)
          .map((sponsorData) => Sponsor.fromJson(sponsorData))
          .toList();
    } on Exception catch (e) {
      debugPrint('Error fetching event sponsors: $e');
      return [];
    }
  }

  Future<bool> updateEventSponsors(int eventId, List<int> sponsorIds) async {
    try {
      // Check if entry exists for this event
      final existingEntry = await _client
          .from('event_sponsors')
          .select('id')
          .eq('event_id', eventId)
          .maybeSingle();

      if (existingEntry != null) {
        // Update existing entry
        await _client.from('event_sponsors').update({
          'sponsor_ids': sponsorIds,
          'updated_at': DateTime.now().toIso8601String()
        }).eq('event_id', eventId);
      } else {
        // Create new entry
        await _client.from('event_sponsors').insert({
          'event_id': eventId,
          'sponsor_ids': sponsorIds,
        });
      }
      return true;
    } on Exception catch (e) {
      debugPrint('Error updating event sponsors: $e');
      return false;
    }
  }

  // Format agenda items for display
  String formatAgendaTime(AgendaItem item) {
    final startFormat =
        '${item.startTime.hour}:${item.startTime.minute.toString().padLeft(2, '0')}';
    final endFormat =
        '${item.endTime.hour}:${item.endTime.minute.toString().padLeft(2, '0')}';

    return '$startFormat - $endFormat';
  }

  Future<Map<String, dynamic>> signIn(String email, String password) async {
    try {
      // Ensure email is trimmed and converted to lowercase
      email = email.trim().toLowerCase();
      password = password.trim();

      final response = await _client.auth.signInWithPassword(
        email: email,
        password: password,
      );

      if (response.session != null) {
        return {'success': true, 'error': null};
      } else {
        return {'success': false, 'error': 'Invalid credentials'};
      }
    } on Exception catch (e) {
      debugPrint('Error signing in: $e');
      String errorMessage = 'An unexpected error occurred';

      if (e.toString().contains('Invalid login credentials')) {
        errorMessage = 'Invalid email or password';
      } else if (e.toString().contains('network')) {
        errorMessage = 'Network error. Please check your connection';
      }

      return {'success': false, 'error': errorMessage};
    }
  }

  Future<Map<String, dynamic>> signUp(
      String name, String email, String password) async {
    try {
      email = email.trim().toLowerCase();

      // First create the auth user
      final authResponse = await _client.auth.signUp(
        email: email,
        password: password,
      );

      if (authResponse.user != null) {
        // Get the user ID from the auth response
        final userId = authResponse.user!.id;

        try {
          // Insert the user data with the matching UUID
          // No need to store password as Supabase Auth already handles this
          await _client.from('users').insert({
            'uuid': userId,
            'name': name,
            'email': email,
            // Remove password field
            'created_at': DateTime.now().toIso8601String(),
            'updated_at': DateTime.now().toIso8601String(),
          });

          return {'success': true, 'error': null};
        } on Exception catch (dbError) {
          debugPrint('Error inserting user data: $dbError');
          return {
            'success': false,
            'error': 'Failed to create user profile: ${dbError.toString()}'
          };
        }
      }
      return {'success': false, 'error': 'Failed to create user account'};
    } on Exception catch (e) {
      debugPrint('Error signing up: $e');

      if (e.toString().contains('users_email_key')) {
        return {'success': false, 'error': 'Email already registered'};
      }

      return {
        'success': false,
        'error': 'Failed to create account: ${e.toString()}'
      };
    }
  }

  Future<void> signOut() async {
    await _client.auth.signOut();
  }

  bool isAuthenticated() {
    return _client.auth.currentSession != null;
  }

  Future<Map<String, dynamic>> getCurrentUser() async {
    try {
      final currentUser = _client.auth.currentUser;
      if (currentUser == null) {
        throw Exception('No authenticated user');
      }

      final response = await _client
          .from('users')
          .select()
          .eq('uuid', currentUser.id)
          .single();

      return response;
    } on Exception catch (e) {
      debugPrint('Error fetching current user: $e');
      throw Exception('Failed to fetch user data');
    }
  }
}
