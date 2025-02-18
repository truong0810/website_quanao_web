import * as _unitOfWork from "@/api"; // Đường dẫn chuẩn Next.js

export const fetchBlogs = async (pagination) => {
  const payload = { pagination };
  const res = await _unitOfWork.getListBlog(payload);
  return res || {};
};
