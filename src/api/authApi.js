import { post } from './restApi';
import { base_api } from './config';

export const login = (payload) => {
    return post(`${base_api}auth/login`, {...payload});
}
export const changePassword = (payload) => {
    return post(`${base_api}auth/change-password`, {...payload});
}
export const refreshToken = (payload) => {
    return post(`${base_api}auth/refresh-token`, {...payload});
}
export const register = (payload) => {
    return post(`${base_api}auth/register`, {...payload});
}