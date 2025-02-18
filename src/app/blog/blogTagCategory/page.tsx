import * as _unitOfWork from "../../../api";
import SearchBlogTagCategory from "@/module/blog/blogTagCategory/SearchBlogTagCategory";


async function fetchData({
  blogTag,
  blogCategory,
}: {
  blogTag?: string;
  blogCategory?: string;
}) {
  try {
    let blogRes;

    if (blogTag) {
      blogRes = await _unitOfWork.searchBlogTagBlogCategory({
        blogTagId: blogTag,
      });
    } else if (blogCategory) {
      blogRes = await _unitOfWork.searchBlogTagBlogCategory({
        blogCategoryId: blogCategory,
      });
    } 
    return {
      blogs: blogRes?.blogs || [],
    };
  } catch (error) {
    console.error("Error fetching blog data:", error);
    return { blogs: [] };
  }
}

export default async function page({ searchParams }) {
  const { blogTag, blogCategory } = searchParams;
  const { blogs } = await fetchData({
    blogTag: blogTag,
    blogCategory: blogCategory,
  });

  return <SearchBlogTagCategory blogs={blogs} />;
}
