import SessionStore from '../store/SessionStore'

const sessionCache = {
  set(key: string, value: any) {
    if (!SessionStore) {
      return;
    }
    if (key != null && value != null) {
      SessionStore.set(key, value);
    }
  },
  get(key: string) {
    if (!SessionStore) {
      return null;
    }
    if (key == null) {
      return null;
    }
    return SessionStore.get(key);
  },
  remove(key: string) {
    SessionStore.remove(key);
  },
};

export default {
  /**
   * 会话级缓存
   */
  session: sessionCache,
};