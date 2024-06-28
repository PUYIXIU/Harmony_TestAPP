/**
 *
 */
import { globalConfig } from '../../config/setting'

export const Log = {

  info(message: string, ...args: any[]): void {
    console.info(`[${globalConfig.logTag}] ${message}`, args)
  },

  error(message: string, ...args: any[]): void {
    console.error(`[${globalConfig.logTag}] ${message}}`, args)
  },

  warn(message: string, ...args: any[]): void {
    console.warn(`[${globalConfig.logTag}] ${message}`, args)
  }
}