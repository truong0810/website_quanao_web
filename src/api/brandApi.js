import { base_api } from './config'
import {post} from './restApi'
export const getAllBrand = (payload) => {
    return post(`${base_api}Brand/get-all`,{...payload});
}