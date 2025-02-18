'use client'
import BlogContent from "@/module/blog/BlogContent";
import { Metadata } from "next";
export const metadata: Metadata = {
  title: "Trang Blog",
  description: "",
};

export default function Blog({blogs}) {
  return (
    <div className="">
        <div className="col-span-2 ">
          <BlogContent blogs={blogs}/>
        </div>
    </div>
  );
}
