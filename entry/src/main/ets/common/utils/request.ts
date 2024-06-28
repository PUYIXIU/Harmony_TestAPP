import axios, { AxiosError, AxiosResponse, InternalAxiosRequestConfig } from '@ohos/axios'
import prompt from '@ohos.prompt'
import { globalConfig } from '../../config/setting'
import { delToken, getToken } from '../store'
import { Log } from './Log'
import router from '@ohos.router'
import { popMsg } from './msg'
import { tansParams } from '.'
import cache from './cache'
import errorCode from './errorCode'

export const isRelogin = { show: false }

// 创建axios实例
const service = axios.create({
  baseURL: globalConfig.baseUrl,
  timeout: 60000,
  headers:{
    'Content-Type':'application/json;charset=utf-8'
  }
})
// request拦截器
service.interceptors.request.use(
  (config: InternalAxiosRequestConfig) => {
    Log.info("调用axios，请求后台服务地址：", config.baseURL + config.url)
    // 是否需要设置 token
    const isToken = (config.headers || {})['isToken'] === false;
    Log.info("调用axios，是否设置token：",!isToken)
    // 是否需要防止数据重复提交
    const isRepeatSubmit = (config.headers || {})['repeatSubmit'] === false;
    Log.info("调用axios，是否需要需要防止数据重复提交：", isRepeatSubmit)
    Log.info("调用axios，获取缓存token")
    let token = getToken()
    Log.info("调用axios，获取缓存token成功：", token)
    if (token && !isToken && config.headers) {
      config.headers['Authorization'] = 'Bearer ' + token; // 让每个请求携带自定义token 请根据实际情况自行修改
    }
    //打印请求参数
    if (config.method === 'get') {
      let params = JSON.stringify(config.params)
      Log.info('请求参数：', params)
    }
    if (config.method === 'post' || config.method === 'put') {
      let data = typeof config.data === 'object' ? JSON.stringify(config.data) : config.data;
      Log.info('请求参数：', data)
    }
    // get请求映射params参数
    if (config.method === 'get' && config.params) {
      let url = config.url + '?' + tansParams(config.params);
      url = url.slice(0, -1);
      config.params = {};
      config.url = url;
    }
    if (!isRepeatSubmit && (config.method === 'post' || config.method === 'put')) {
      const requestObj = {
        url: config.url,
        data: typeof config.data === 'object' ? JSON.stringify(config.data) : config.data,
        time: new Date().getTime(),
      };
      const sessionObj = undefined
      //const sessionObj = await cache.session.getJSON('sessionObj');
      if (sessionObj === undefined || sessionObj === null || sessionObj === '') {
        cache.session.set('sessionObj', requestObj);
      } else {
        const s_url = sessionObj.url; // 请求地址
        const s_data = sessionObj.data; // 请求数据
        const s_time = sessionObj.time; // 请求时间
        const interval = 1000; // 间隔时间(ms)，小于此时间视为重复提交
        if (
          s_data === requestObj.data &&
          requestObj.time - s_time < interval &&
          s_url === requestObj.url
        ) {
          const message = '数据正在处理，请勿重复提交';
          Log.warn(`[${s_url}]: ` + message);
          return Promise.reject(new Error(message));
        } else {
          cache.session.set('sessionObj', requestObj);
        }
      }
    }
    return config;
  },
  (error: AxiosError) => {
    Log.error("拦截request系统错误", error);
    Promise.reject(error);
  }
);

// 响应拦截器
service.interceptors.response.use(
  (res: AxiosResponse) => {
    Log.info("调用axios，返回成功：", res.status)
    // 未设置状态码则默认成功状态
    const code = res.data.code || 200;
    Log.info("调用axios，服务端返回状态码：", code)
    // 二进制数据则直接返回
    if (res.request.responseType === 'blob' || res.request.responseType === 'array_buffer') {
      Log.info("调用axios，返回二进制数据")
      return res.data;
    }
    let data = typeof res.data === 'object' ? JSON.stringify(res.data) : res.data;
    Log.info('请求后台返回数据：', data)
    if (code === 200) {
      //正常返回
      return Promise.resolve(res.data);
    } else {
      // 返回错误获取错误信息
      const msg = errorCode[code] || res.data.msg || errorCode['default'];
      Log.info("调用axios，返回错误信息：", msg)
      if (code === 401) {
        if (!isRelogin.show) {
          isRelogin.show = true;
          prompt.showDialog({
            title: '系统提示',
            message: '登录状态已过期，您可以继续留在该页面，或者重新登录',
            buttons: [
              {
                text: '重新登录',
                color: '#000000',
              },
              {
                text: '取消',
                color: '#000000',
              }
            ],

          }).then((data) => {
            isRelogin.show = false;
            if (data.index == 0) {
              delToken().then(() => {
                Log.info('token无效跳转登录页')
                router.replaceUrl({
                  url: 'pages/LoginPage'
                })
              }).catch(e => {
                Log.error('删除token发生异常', e)
              })
            }
          }).catch((err) => {
            isRelogin.show = false;
            Log.error('打开重新登录对话框发生错误', err);
          });
        }
        return Promise.reject('无效的会话，或者会话已过期，请重新登录。');
      } else if (code === 500) {
        popMsg(msg)
        return Promise.reject(new Error(msg));
      } else {
        popMsg(msg)
        return Promise.reject(new Error(msg));
      }
    }
  },
  (error: AxiosError) => {
    let { message } = error;
    Log.error('拦截response系统错误', message, error.code);
    if (message === AxiosError.ERR_NETWORK) {
      message = '后端接口连接异常';
    } else if (message === AxiosError.ETIMEDOUT) {
      message = '系统接口请求超时';
    }
    popMsg(message)
    return Promise.reject(error);
  }
);

export default service;