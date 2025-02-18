"use client";

import { parseFullDatetime } from "@/components/helper/date-helper";
import { CalendarOutlined, MessageOutlined } from "@ant-design/icons";
import Link from "next/link";
export default function SearchBlogTagCategory({ blogs }) {
  return (
    <div>
      {/* Danh sách bài viết */}
      {blogs?.map((data) => (
        <div className="mb-[40px]" key={data.id}>
          <div
            className="w-full min-h-[200px] p-[20px] md:p-[40px] "
            style={{ background: "#FAF9FF" }}
          >
            <div className="block mb-[10px] text-xs">
              <CalendarOutlined className="text-lime-600" />
              <span className="text-slate-600 ml-2 font-bold uppercase">
                {parseFullDatetime(data.createdDate)}
              </span>
              {/* <UserOutlined className="ml-5 text-lime-600 cursor-pointer" /> */}
              <button className="ml-4 md:ml-5">
                <MessageOutlined className="text-lime-600 mr-2" />
                <span className="text-slate-600 font-bold uppercase hover:text-lime-600">
                  Không có bình luận
                </span>
              </button>
            </div>
            <Link href={`/blog/${data.id}`}>
              <div className="font-bold text-2xl mb-3 capitalize hover:text-lime-600 cursor-pointer">
                {data.title}
              </div>
            </Link>
            <div className="mb-7">{data.text}</div>
            <Link
              href={`/blog/${data.id}`}
              className="hover:bg-zinc-700 bg-teal-600 py-3 px-7 uppercase text-white font-bold rounded-3xl"
              style={{ fontSize: "13px" }}
            >
              Chi Tiết
            </Link>
          </div>
        </div>
      ))}
    </div>
  );
}
