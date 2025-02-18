import { base_api } from './config'
import {post} from './restApi'
export const loginCustomer = (payload) => {
    return post(`${base_api}Customer/login-customer`,{...payload})
}
export const changePasswordCustomer = (payload) => {
    return post(`${base_api}Customer/change-password-customer`,{...payload})
}
export const registerCustomer = (payload) => {
    return post(`${base_api}Customer/register-customer`,{...payload})
}