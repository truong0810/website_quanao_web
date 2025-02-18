import { post } from "./restApi";
import { base_api } from "./config";

export const getAllBlogCategory = (payload) => {
  return post(`${base_api}BlogCategory/get-all`, { ...payload });
};
