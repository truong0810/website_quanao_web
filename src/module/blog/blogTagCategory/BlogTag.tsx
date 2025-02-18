"use client"
import { Button } from "@/components/ui/button";
// import { useRouter } from "next/navigation";

export default function BlogTag({blogTags}){
    // const router = useRouter();
    // const handleBlogTag = (tagId) => {
    //     if (tagId) {
    //       router.push(`/blog/blogSearch?blogTag=${encodeURIComponent(tagId)}`);
    //     }
    //   };
    return (
        <>
        <span className="font-semibold text-start">Tags</span>
        {blogTags?.map((data) => {
          return (
            <Button
              variant="secondary"
              className=" border hover:text-white hover:bg-black"
              key={data.id}
              // onClick={() => handleBlogTag(data?.id)}
            >
              {data?.tag?.name}
            </Button>
          );
        })}</>
    )
}