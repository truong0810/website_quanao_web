'"use client"';
import Image from "next/image";
import { PAGINATIONMAX } from "../../utils/constant";
import * as _unitOfWork from "../../api";
import { parseFullDatetime } from "../../components/helper/date-helper";
import Link from "next/link";
import Seach from "@/module/blog/seachBlog/Seach";
import BlogTagCategory from "@/module/blog/blogTagCategory/BlogTagCategory";

async function fetchData(slug: string) {
  const pagination = { ...PAGINATIONMAX };
  try {
    const [blogRes, tagRes, blogCategoryRes] = await Promise.all([
      _unitOfWork.getListBlog({ slug, pagination }),
      _unitOfWork.getAllTag(),
      _unitOfWork.getAllBlogCategory(),
    ]);
    if (blogRes) {
      return {
        blogs: blogRes.blogs,
        tags: tagRes.tags,
        blogCategorys: blogCategoryRes.blogCategories,
      };
    }
  } catch (error) {
    console.error("Error fetching blog:", error);
    return { blogs: null };
  }
}

export default async function BlogFunction({ params }) {
  const { blogs, tags, blogCategorys } = await fetchData(params);

  return (
    <div className="px-4 lg:px-0">
      {/* tìm kiếm của blog */}
      <div className="hidden md:flex"><Seach /></div>
      {/* <div className="w-full border-2 border-slate-200 mb-[40px] group lg:p-5">
        <div className="font-bold text-lg mb-2">Bài viết mới</div>
        <hr className="w-[15%] border-t-[2px] border-black text-black group-hover:w-[20%] transition-all duration-300" />
        {blogs?.slice(0, 5).map((data) => (
          <div key={data?.id} className="border-b-2 last:border-none group">
            <Link href={`/blog/${data.id}`}>
              <button className="hover:text-lime-600 pt-2 pb-2 capitalize">
                {data?.title}
              </button>
            </Link>
          </div>
        ))}
      </div> */}
      {/* bình luận */}
      {/* <div className="w-full border-2 border-slate-200 p-5 mb-[40px] group">
       
        <div className="font-bold text-lg mb-2">
          Bình luận gần đây(chưa làm database)
        </div>
        <hr className="w-[15%] border-t-[2px] border-black text-black group-hover:w-[20%] transition-all duration-300" />
        <button className="hover:text-lime-600 mb-2 pt-2 pb-2 ">
          A WordPress!
        </button>
        <hr className="mb-2"></hr>
        <button className="hover:text-lime-600 ">Hello World!</button>
      </div> */}
      {/* vbaif viết Post */}
      <div className="w-full border-2 border-slate-200 p-5 mb-[40px]">
        <div className="font-bold text-xl mb-2">Bài viết mới</div>
        {/* <hr className="w-[20%] border-t-[2px] border-black text-black " />
        <button className="font-bold block hover:text-lime-600">
          Tên bài viết
        </button>
        <span className="mb-10 text-xs">Ngày tháng năm</span> */}

        {/* vbaif viết pops */}

        {blogs?.slice(0, 5).map((data) => (
          <div
            className="grid grid-cols-3 gap-4 mb-4 "
            key={data?.id}
          >
            {data?.blogImages && data?.blogImages.length > 0 && (
              <Link href={`/blog/${data.id}`}>
                <div className="w-full h-[90px] mr-1 ">
                  <Image
                    src={_unitOfWork.getLinkImageResource(
                      data?.blogImages?.map((text) => text.blogImageId)
                    )}
                    alt={data?.id}
                    width={300}
                    height={300}
                    className="size-full"
                  />
                </div>
              </Link>
            )}
            <div className="col-span-2 mb-2 ">
              <Link href={`/blog/${data?.id}`}>
                <div className="font-bold pt-2 hover:text-lime-600 cursor-pointer text-base">
                  {data.title}
                </div>
              </Link>
              <span className="text-xs">
                {parseFullDatetime(data?.createdDate)}
              </span>
            </div>
          </div>
        ))}
      </div>
      {/* Danhmucj */}
      <BlogTagCategory tags={tags} blogCategorys={blogCategorys} />
    </div>
  );
}
