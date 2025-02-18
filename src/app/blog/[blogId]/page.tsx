import BlogContentDetail from "@/module/blog/BlogContentDetail";
import * as _unitOfWork from "../../../api";
import type { Metadata } from "next";
import * as _unitOfNetwork from "../../../api";

async function fetchData(blogId: string) {
  if (!blogId) {
    console.error("fetchData: blogId is missing");
    return { blog: null, blogTags: [], blogImages: [] };
  }

  try {
    console.log("Fetching blog with ID:", blogId); 
    const [blogRes] = await Promise.all([_unitOfWork.getBlogById({ id: blogId })]);
    if (blogRes) {
      return {
        blog: blogRes.blog,
        blogTags: blogRes.blogTags,
        blogImages: blogRes.blogImages,
      };
    }
  } catch (error) {
    console.error("Error fetching blog:", error);
    return { blog: null, blogTags: [], blogImages: [] };
  }
}
export async function generateMetadata(
  { params }
): Promise<Metadata> {
  const id = (await params).blogId
  const res = await _unitOfWork.getBlogById({ id: id })
  return {
      title: res.blog?.title,
      openGraph: {
          title: res.blog?.title,
          description: res.blog?.text,
          images : [_unitOfNetwork.getLinkImageResource(res.blogImages[0]?.blogImageId)]
      },
      description : res.blog?.text
  }
}

export default async function page({ params }) {
  console.log("Page params:", params); // Debug để kiểm tra giá trị params
  const { blog, blogTags, blogImages } = await fetchData(params.blogId);

  return <BlogContentDetail blog={blog} blogTags={blogTags} blogImages={blogImages}/>;
}