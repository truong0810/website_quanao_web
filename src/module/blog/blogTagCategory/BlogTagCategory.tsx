"use client"
import { useRouter } from "next/navigation";

export default function BlogTagCategory({blogCategorys, tags}) {
  const router = useRouter();

  const handleBlogCategory = (blogCategoryId) => {
    if (blogCategoryId) {
      router.push(`/blog/blogTagCategory?blogCategory=${encodeURIComponent(blogCategoryId)}`);
    }
  };

  const handleBlogTag = (tagId) => {
    if (tagId) {
      router.push(`/blog/blogTagCategory?blogTag=${encodeURIComponent(tagId)}`);
    }
  };
  return (
    <div className="">
      {" "}
      <div className="w-full border-2 border-slate-200 p-5 mb-[40px] group">
        <div className="font-bold text-xl mb-2 ">Danh mục</div>
        <hr className="w-[15%] border-t-[2px] border-black text-black group-hover:w-[20%] transition-all duration-300" />
        {blogCategorys?.map((data) => (
          <div key={data.id} className="pt-3 pb-3 border-b-2 last:border-none">
            <button className="hover:text-lime-600 capitalize"  onClick={() => handleBlogCategory(data.id)}>
              {data.name}
            </button>
          </div>
        ))}
      </div>
      {/* Thẻ  */}
      <div className="w-full border-2 border-slate-200 p-5 mb-[40px] group">
        <div className="font-bold text-xl mb-2">Thẻ</div>
        <hr className="w-[15%] border-t-[2px] border-black text-black mb-[20px] group-hover:w-[20%] transition-all duration-300" />
        {tags?.map((data) => (
          <button
            className="bg-gray-100 mr-2 min-h-[35px] px-4 mb-2 hover:bg-lime-600 hover:text-white capitalize transition-all duration-500 ease-in-out"
            key={data.id}
            onClick={() => handleBlogTag(data.id)}
          >
            {data.name}
          </button>
        ))}
      </div>
    </div>
  );
}
