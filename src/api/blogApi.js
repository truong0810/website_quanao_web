import { post } from "./restApi";
import { base_api } from "./config";

export const getListBlog = (payload) => {
  return post(`${base_api}Blog/get-list`, { ...payload });
};
export const getBlogById = (payload) => {
  return post(`${base_api}Blog/get-by-id`, { ...payload });
};
export const createBlog = (payload) => {
  return post(`${base_api}Blog/create`, { ...payload });
};
export const updateBlog = (payload) => {
  return post(`${base_api}Blog/update`, { ...payload });
};
export const deleteBlog = (payload) => {
  return post(`${base_api}Blog/delete`, { ...payload });
};
export const getAllBlog = (payload) => {
  return post(`${base_api}Blog/get-all`, { ...payload });
};
export const searchBlogTagBlogCategory = (payload) => {
  return post(`${base_api}Blog/search-blogtag-blocategory`, { ...payload });
};