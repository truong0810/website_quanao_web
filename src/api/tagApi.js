import { post } from "./restApi";
import { base_api } from "./config";

export const getListTag = (payload) => {
  return post(`${base_api}tag/get-list`, { ...payload });
};
export const getTagById = (payload) => {
  return post(`${base_api}tag/get-by-id`, { ...payload });
};
export const getAllTag = (payload) => {
  return post(`${base_api}tag/get-all`, { ...payload });
};
