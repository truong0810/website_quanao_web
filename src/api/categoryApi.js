import { base_api } from './config'
import {post} from './restApi'
export const getAllCategory = (payload) => {
    return post(`${base_api}Category/get-all`,{...payload})
}