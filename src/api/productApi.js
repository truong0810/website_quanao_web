import { base_api } from './config'
import {post} from './restApi'
export const getListProduct  = (payload) => {
    return post(`${base_api}Product/get-list`,{...payload});
}
export const getListFilteredProduct = (payload) => {
    return post(`${base_api}Product/get-list-filter`,{...payload});
}
export const getLinkImage = (fileName) => {
    return `${base_api}Product/get-link-image/`+fileName;
}
export const getProductById = (payload) => {
    return post(`${base_api}Product/get-by-id`,{...payload});
}
export const getRelatedProduct = (payload) => {
    return post(`${base_api}Product/get-related-products`,{...payload});
}
export const getTrendingProducts = (payload) => {
    return post(`${base_api}Product/get-trending-products`,{...payload});
}
export const getNewProducts = (payload) => {
    return post(`${base_api}Product/get-new-products`,{...payload});
}
export const getSearchProducts = (payload) => {
    return post(`${base_api}Product/get-search-products`,{...payload});
}
export const getProductHot = (payload) => {
    return post(`${base_api}Product/get-product-hot`, { ...payload });
}