"use server";
import React from "react";
import {
  FacebookOutlined,
  TwitterOutlined,
  LinkedinOutlined,
  InstagramOutlined,
  RightOutlined,
} from "@ant-design/icons";
import Link from "next/link";
import Image from "next/image";
import Logo from "../../../image/home/logo.png";
import FooterBank from "../../../image/footerbank.png";
import "./index.scss";
import * as _unitOfWork from "../../../api";

async function fetchData() {
  const res = await _unitOfWork.getAllCategory();
  if (res && res.code == 1) {
    return { categories: res.categories };
  }
}

export default async function Footer() {
  const { categories } = await fetchData();
  return (
    <footer className="">
      <div className=" bg-slate-50  md:shadow-inner pt-6 px-2 md:px-0 ">
        {/* Responsive Grid Layout */}
        <div className="grid grid-cols-1  md:grid-cols-2 lg:grid-cols-4 gap-8 margin-main">
          {/* Thông tin liên hệ */}
          <div className="">
            <Link href="/" className="block w-[130px] mb-3 md:mb-7">
              <Image
                src={Logo}
                alt="CNT04.alt"
                width={500}
                height={500}
                className="size-full object-contain"
              />
            </Link>
            <p className="mb-2">
              <b>Điện thoại: </b> +84 121 121 22
            </p>
            <p className="mb-2">
              <b>Email: </b> CNT04@gmail.com
            </p>
            <p className="mb-2">
              <b>Địa chỉ: </b>  92 A P. Lê Thanh Nghị, Bách Khoa, Hai Bà Trưng, Hà Nội
            </p>
          </div>

          {/* Danh mục */}
          <div className="hidden md:block">
            <h3 className="text-lg font-semibold text-gray-900 mb-7">
              Danh mục
            </h3>
            <ul className="space-y-2 text-[15px]">
              {categories?.map((data) => (
                <li key={data.id} className="custom-link">
                  <Link
                    href={{
                      pathname: "/products",
                      query: { categoryId: data.id },
                    }}
                  >
                    <RightOutlined className="icon" /> {data?.name}
                  </Link>
                </li>
              ))}
            </ul>
          </div>

          {/* Thông tin */}
          <div className="hidden md:block text-[15px]">
            <h3 className="text-lg font-semibold text-gray-900 mb-7">
              Thông tin
            </h3>
            <ul className="space-y-2">
              <li>
                <Link href="/home" className="custom-link">
                  <RightOutlined className="icon" /> Tài khoản
                </Link>
              </li>           
              <li>
                <Link href="/home" className="custom-link">
                  <RightOutlined className="icon" /> Hướng dẫn chọn sản phẩm
                </Link>
              </li>
              <li>
                <Link href="/faq" className="custom-link">
                  <RightOutlined className="icon" /> Câu hỏi thường gặp
                </Link>
              </li>
            </ul>
          </div>

          {/* Liên kết mạng xã hội */}
          <div className="hidden lg:block">
            <h3 className="text-lg font-semibold text-gray-900 mb-4">
              Liên kết mạng xã hội
            </h3>
            <ul className="flex space-x-4 text-[15px]">
              <li>
                <a
                  href="https://facebook.com/company"
                  className="text-gray-800 hover:text-blue-600"
                >
                  <FacebookOutlined className="text-xl" />
                </a>
              </li>
              <li>
                <a
                  href="https://twitter.com/company"
                  className="text-gray-800 hover:text-blue-400"
                >
                  <TwitterOutlined className="text-xl" />
                </a>
              </li>
              <li>
                <a
                  href="https://linkedin.com/company"
                  className="text-gray-800 hover:text-blue-500"
                >
                  <LinkedinOutlined className="text-xl" />
                </a>
              </li>
              <li>
                <a
                  href="https://instagram.com/company"
                  className="text-gray-800 hover:text-pink-500"
                >
                  <InstagramOutlined className="text-xl" />
                </a>
              </li>
            </ul>
          </div>
        </div>

        {/* Bản quyền */}
        <div className="mt-8 border-t border-gray-300  flex flex-col lg:flex-row justify-between items-center py-2 md:px-4 md:py-4 ">
          <p className="text-sm text-gray-600 text-center lg:text-left mb-2">
            © 2025 Công ty CNT04. All rights reserved.
          </p>
          <Image
            src={FooterBank}
            alt="FooterBank.alt"
            width={200}
            height={50}
            className="mb-2"
          />
        </div>
      </div>
    </footer>
  );
}
