import { base_api } from './config'
import {post}  from './restApi'
export const payment = (payload) => {
    return post(`${base_api}Payment/payment`,{...payload});
}