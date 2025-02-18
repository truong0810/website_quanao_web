"use client";

import {
  CalendarOutlined,
  MessageOutlined,
  UserOutlined,
} from "@ant-design/icons";
import Image from "next/image";
import * as _unitOfWork from "../../api";
import Link from "next/link";
import { parseFullDatetime } from "@/components/helper/date-helper";
import Seach from "@/module/blog/seachBlog/Seach";

export default function BlogContent({ blogs }) {
  return (
    //phần chính của bài viết
    <div className="">
      <div className="md:hidden">
        <Seach />
      </div>
      {blogs?.slice(0, 5).map((data) => (
        <div className="mb-[50px]" key={data?.id}>
          {/* Hình ảnh bài viết */}
          {data.blogImages && data.blogImages.length > 0 && (
            <Link
              href={`/blog/${data.id}`}
              className="block w-full h-[30vh] md:h-[50vh]"
            >
              <Image
                src={_unitOfWork.getLinkImageResource(
                  data?.blogImages[0]?.blogImageId
                )}
                alt={data?.blogImages[0]?.blogImageId}
                width={300}
                height={300}
                className="size-full "
              />
            </Link>
          )}

          {/* Nội dung bài viết */}
          <div
            className="w-full min-h-[23vh] md:min-h-[220px] p-5 md:p-[50px] rounded-lg"
            style={{ background: "#FAF9FF" }}
          >
            {/* Thông tin ngày và tác giả */}
            <div className="flex flex-wrap items-center text-xs mb-4">
              <div className="flex items-center mb-2 md:mb-0">
                <CalendarOutlined className="text-lime-600" />
                <span className="text-slate-600 ml-2 font-bold uppercase">
                  <span className="hidden md:inline-block">Ngày </span>
                  {" " + parseFullDatetime(data.createdDate)}
                </span>
              </div>
              <div className="items-center md:ml-5 mb-2 md:mb-0 hidden md:flex">
                <UserOutlined className="text-lime-600" />
              </div>
              <button className="ml-3 mb-2 md:mb-0 md:ml-5 items-center flex">
                <MessageOutlined className="text-lime-600 mr-2" />
                <span className="text-slate-600 font-bold uppercase hover:text-lime-600">
                  Không có bình luận
                </span>
              </button>
            </div>

            {/* Tiêu đề bài viết */}
            <Link href={`/blog/${data?.id}`}>
              <div className="font-bold text-xl md:text-2xl mb-3 capitalize hover:text-lime-600 cursor-pointer">
                {data.title}
              </div>
            </Link>

            {/* Mô tả ngắn */}
            <div className="mb-7 text-sm md:text-base">{data?.text}</div>

            {/* Nút chi tiết */}
            <Link
              href={`/blog/${data?.id}`}
              className="block w-max hover:bg-zinc-700 bg-teal-600 py-3 px-6 md:py-3 md:px-7 uppercase text-white font-bold rounded-3xl text-xs md:text-sm"
            >
              Chi tiết
            </Link>
          </div>
        </div>
      ))}
    </div>
  );
}
