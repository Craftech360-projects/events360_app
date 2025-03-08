import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  static final SupabaseService _instance = SupabaseService._internal();
  static late final SupabaseClient _client;

  factory SupabaseService() => _instance;

  SupabaseService._internal();

  static Future<void> initialize() async {
    // await dotenv.load();

    await Supabase.initialize(
      url: "https://tpwmccdmctsnlhofmhbp.supabase.co",
      anonKey:
          "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InRwd21jY2RtY3Rzbmxob2ZtaGJwIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDExNjA4NDAsImV4cCI6MjA1NjczNjg0MH0.2PPSN0S09NG0cYgsUGLmxuQgGu9Ibu5mGh9kdfqx18Y",
    );

    _client = Supabase.instance.client;
  }

  static SupabaseClient get client => _client;

  // Events
  Future<List<Map<String, dynamic>>> getEvents() async {
    final response = await _client.from('events').select().order('start_date');
    return response;
  }

  Future<Map<String, dynamic>> getEvent(int id) async {
    final response =
        await _client.from('events').select().eq('id', id).single();
    return response;
  }

  // Agenda Items
  Future<List<Map<String, dynamic>>> getAgendaItems(int eventId) async {
    final response = await _client
        .from('agenda_items')
        .select('*, speakers(*)')
        .eq('event_id', eventId)
        .order('start_time');
    return response;
  }

  // Speakers
  Future<List<Map<String, dynamic>>> getSpeakers(int eventId) async {
    final response = await _client
        .from('event_speakers')
        .select('speakers(*)')
        .eq('event_id', eventId);

    // Extract the speakers from the join table response
    return response
        .map((item) => item['speakers'] as Map<String, dynamic>)
        .toList();
  }

  Future<List<Map<String, dynamic>>> getAllSpeakers() async {
    final response = await _client.from('speakers').select();
    return response;
  }

  // Attendees
  Future<List<Map<String, dynamic>>> getAttendees(int eventId) async {
    final response = await _client
        .from('event_attendees')
        .select('users(*)')
        .eq('event_id', eventId);

    // Extract the users from the join table response
    return response
        .map((item) => item['users'] as Map<String, dynamic>)
        .toList();
  }

  // Sponsors
  Future<List<Map<String, dynamic>>> getSponsors(int eventId) async {
    final response = await _client
        .from('event_sponsors')
        .select('sponsors(*)')
        .eq('event_id', eventId);

    // Extract the sponsors from the join table response
    return response
        .map((item) => item['sponsors'] as Map<String, dynamic>)
        .toList();
  }

  // User Profile
  Future<Map<String, dynamic>?> getUserProfile(String userId) async {
    final response =
        await _client.from('users').select().eq('id', userId).single();
    return response;
  }

  // Tickets
  Future<List<Map<String, dynamic>>> getUserTickets(String userId) async {
    final response = await _client
        .from('tickets')
        .select('*, events(*)')
        .eq('user_id', userId);
    return response;
  }
}
