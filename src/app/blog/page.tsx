import Blog from "@/module/blog";
import { PAGINATIONMAX } from "@/utils/constant";
import { Metadata } from "next";
import * as _unitOfWork from "../../api";
export const metadata: Metadata = {
  title: "Blog",
  description: "Tại bởi",
};
async function fetchData() {
  try {
    const pagination = { ...PAGINATIONMAX };
    const blogRes = await _unitOfWork.getListBlog({
      pagination,
    });

    return {
      blogs: blogRes?.blogs || [],
      pagination: pagination,
    };
  } catch (error) {
    console.error("Error fetching blog data:", error);
    return { blogs: [] };
  }
}
export default async function Page() {
  const { blogs } = await fetchData();
  return (
    <div className="">
      <Blog blogs={blogs} />
    </div>
  );
}
