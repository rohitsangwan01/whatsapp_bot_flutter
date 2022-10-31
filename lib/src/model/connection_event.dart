enum ConnectionEvent {
  initializing,
  downloadingChrome,
  connectingChrome,
  waitingForLogin,
  waitingForQrScan,

  authenticated,
  logout,
  authCodeChange,
  connecting,
  connected,
  requireAuth
}
