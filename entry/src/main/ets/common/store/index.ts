import CookieStore from './CookieStore';
import SessionStore from './SessionStore';
import { UserState } from './UserState';

// 获取用户数据
export function getUserState(): UserState {
  return SessionStore.get('user')
}

export function setUserState(userState: UserState) {
  SessionStore.set('user', userState);
}

export function delUserState() {
  SessionStore.remove('user')
}

export function setToken(token: string) {
  CookieStore.setToken(token)
}

export function getToken() {
  return CookieStore.getToken();
}

export async function delToken() {
  CookieStore.deleteToken();
}