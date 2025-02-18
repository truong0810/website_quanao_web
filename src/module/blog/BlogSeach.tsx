"use client";
import React, { useState, useEffect, useCallback } from "react";
import { parseFullDatetime } from "@/components/helper/date-helper";
import { CalendarOutlined, MessageOutlined } from "@ant-design/icons";
import Link from "next/link";
import * as _unitOfWork from "../../api";
import PaginationCus from "@/components/PaginationSection";
import Image from "next/image";
import imageNodata from "../../image/nodata.jpg";
type Blog = {
  id: string;
  title: string;
  text: string;
  createdDate: string;
};

type Pagination = {
  page: number;
  total: number;
  limit: number;
};

async function fetchData({
  searchTerm,
  page,
}: {
  searchTerm?: string;
  page: number;
}): Promise<{ blogs: Blog[]; pagination: Pagination }> {
  try {
    const response = await _unitOfWork.getListBlog({
      pagination: { page, limit: 2 },
      title: searchTerm,
    });
    if (response && response.code == 1) {
      return {
        blogs: response?.blogs || [],
        pagination: response?.pagination || { page: 1, total: 0, limit: 10 },
      };
    }
  } catch (error) {
    console.log("Error fetching blog data:", error);
    return { blogs: [], pagination: { page: 1, total: 0, limit: 10 } };
  }
}

export default function BlogSearch({ query }) {
  const [blogs, setBlogs] = useState<Blog[]>([]);
  const [pagination, setPagination] = useState<Pagination>({
    page: 1,
    total: 0,
    limit: 10,
  });

  const fetchAndSetData = useCallback(
    async (page: number) => {
      const { blogs, pagination } = await fetchData({
        searchTerm: query,
        page,
      });
      setBlogs(blogs);
      setPagination(pagination);
    },
    [query]
  );

  useEffect(() => {
    fetchAndSetData(1);
  }, [query, fetchAndSetData]);

  const handlePageChange = (page: number) => {
    if (page > 0 && page <= Math.ceil(pagination.total / pagination.limit)) {
      fetchAndSetData(page);
    }
  };

  return (
    <div>
      {blogs.length === 0 && (
        <div className="text-center">
          <Image
            src={imageNodata}
            alt="No data available"
            width={700}
            height={700}
            className="size-full "
          />
        </div>
      )}
      {blogs.map((blog) => (
        <div className="mb-[40px]" key={blog.id}>
          <div
            className="w-full min-h-[220px] p-[20px] md:p-[40px]"
            style={{ background: "#FAF9FF" }}
          >
            <div className="block mb-[10px] text-xs">
              <CalendarOutlined className="text-lime-600 text-sm" />
              <span className="text-slate-600 ml-2 font-bold uppercase">
                {parseFullDatetime(blog.createdDate)}
              </span>
              {/* <UserOutlined className="ml-5 text-lime-600 cursor-pointer text-sm" /> */}
              <button className="ml-3 md:ml-5 pt-2 md:pt-0">
                <MessageOutlined className="text-lime-600 mr-2 text-sm" />
                <span className="text-slate-600 font-bold uppercase hover:text-lime-600">
                  Không có bình luận
                </span>
              </button>
            </div>
            <Link href={`/blog/${blog.id}`}>
              <div className="font-bold text-2xl mb-3 capitalize hover:text-lime-600 cursor-pointer">
                {blog.title}
              </div>
            </Link>
            <div className="mb-7">{blog.text}</div>
            <Link
              href={`/blog/${blog.id}`}
              className="hover:bg-zinc-700 bg-teal-600 py-3 px-7 uppercase text-white font-bold rounded-3xl"
              style={{ fontSize: "13px" }}
            >
              Chi Tiết
            </Link>
          </div>
        </div>
      ))}
      {/* Pagination */}
      <PaginationCus pagination={pagination} onPageChange={handlePageChange} />
    </div>
  );
}
