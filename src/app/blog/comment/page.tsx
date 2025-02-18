import BlogComment from "@/module/blog/BlogComments";
import {Metadata} from "next";

export const metadata: Metadata = {
  title: "Blog",
  description:
    "Tại bởi",
};

export default function Page() {
  return (
    <div>
        <BlogComment/>
    </div>
  )
}