import { post } from "./restApi";
import { base_api } from "./config";

export const getListBanner = (payload) => {
  return post(`${base_api}Banner/get-list`, { ...payload });
};
export const getBannerById = (payload) => {
  return post(`${base_api}Banner/get-by-id`, { ...payload });
};
export const getAllBanner = (payload) => {
  return post(`${base_api}Banner/get-all`, { ...payload });
};
