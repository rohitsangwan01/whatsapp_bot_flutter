/// Whatsapp Events, https://wppconnect.io/wa-js/modules/ev.html
/// Add more events if needed from the above link
///
/// use WhatsappClient.on(eventName,(data){}) to listen to events and client.off(eventName) to stop listening
///
///
class WhatsappEvent {
  // BlocklistEventTypes
  static String blocklist_sync = 'blocklist.sync';

  // CallEventTypes
  static String incoming_call = 'call.incoming_call';

  // ChatEventTypes
  static String chat_active_chat = 'chat.active_chat';
  static String chat_live_location_end = 'chat.live_location_end';
  static String chat_live_location_start = 'chat.live_location_start';
  static String chat_live_location_update = 'chat.live_location_update';
  static String chat_msg_ack_change = 'chat.msg_ack_change';
  static String chat_msg_revoke = 'chat.msg_revoke';
  static String chat_new_message = 'chat.new_message';
  static String chat_new_reaction = 'chat.new_reaction';
  static String chat_poll_response = 'chat.poll_response';
  static String chat_presence_change = 'chat.presence_change';
  static String chat_update_label = 'chat.update_label';

  // ConfigEventTypes
  static String config_update = 'config.update';

  // ConnEventTypes
  static String conn_auth_code_change = 'conn.auth_code_change';
  static String conn_authenticated = 'conn.authenticated';
  static String conn_logout = 'conn.logout';
  static String conn_main_init = 'conn.main_init';
  static String conn_main_loaded = 'conn.main_loaded';
  static String conn_main_ready = 'conn.main_ready';
  static String conn_needs_update = 'conn.needs_update';
  static String conn_online = 'conn.online';
  static String conn_qrcode_idle = 'conn.qrcode_idle';
  static String conn_require_auth = 'conn.require_auth';

  // GroupEventTypes
  static String group_participant_changed = 'group.participant_changed';

  // StatusEventTypes
  static String status_sync = 'status.sync';

  // WebpackEvents
  static String webpack_injected = 'webpack.injected';
  static String webpack_ready = 'webpack.ready';
}
