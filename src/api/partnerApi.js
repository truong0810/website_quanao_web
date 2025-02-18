import { post } from "./restApi";
import { base_api } from "./config";

export const getListPartner = (payload) => {
  return post(`${base_api}Partner/get-list`, { ...payload });
};
export const getPartnerById = (payload) => {
  return post(`${base_api}Partner/get-by-id`, { ...payload });
};
export const createPartner = (payload) => {
  return post(`${base_api}Partner/create`, { ...payload });
};
export const updatePartner = (payload) => {
  return post(`${base_api}Partner/update`, { ...payload });
};
export const deletePartner = (payload) => {
  return post(`${base_api}Partner/delete`, { ...payload });
};
export const getAllPartner = (payload) => {
  return post(`${base_api}Partner/get-all`, { ...payload });
};
