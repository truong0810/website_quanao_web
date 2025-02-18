"use client";
import Image from "next/image";
import Link from "next/link";
import logo from "../../../image/home/logo.png";
import CartHeaderComponent from "../../../components/cart/CartHeaderComponent";
import SearchComponent from "../../../components/header/SearchComponent";
import { useState } from "react";
import {
  HomeOutlined,
  InsertRowBelowOutlined,
  MenuOutlined,
  PhoneOutlined,
  ReconciliationOutlined,
  ShopOutlined,
} from "@ant-design/icons";

export default function Navbar() {
  const [isMenuOpen, setIsMenuOpen] = useState(false);

  const toggleMenu = () => {
    setIsMenuOpen(!isMenuOpen);
  };

  const closeMenu = () => {
    setIsMenuOpen(false);
  };

  return (
    <nav
      style={{ fontFamily: "'Muli',sans-serif", fontWeight: "700" }}
      className="bg-white text-gray-800 shadow-md relative px-4 md:px-0"
    >
      <div className=" flex justify-between items-center margin-main py-[2vh]">
        {/* Logo */}
        <Link href="/" className="w-[130px] hidden md:inline">
          <Image
            src={logo}
            alt="CNT04.alt"
            width={500}
            height={500}
            className="object-contain"
          />
        </Link>
        <div className="md:hidden flex-1 flex justify-between items-center">
          <button
            onClick={toggleMenu}
            className="text-gray-800 focus:outline-none"
          >
            <MenuOutlined />
          </button>
        </div>

        {/* Menu */}
        <div className="hidden space-x-6 text-base uppercase md:block">
          <ul className="flex flex-col md:flex-row space-y-4 md:space-y-0 md:space-x-6">
            <li>
              <Link href="/" className="hover:text-lime-600">
                Trang chủ
              </Link>
            </li>
            <li>
              <Link href="/shop" className="hover:text-lime-600">
                Sản phẩm
              </Link>
            </li>
            <li>
              <Link href="/blog" className="hover:text-lime-600">
                Bài viết
              </Link>
            </li>
            <li>
              <Link href="/about" className="hover:text-lime-600">
                Giới thiệu
              </Link>
            </li>
            <li>
              <Link href="/contact" className="hover:text-lime-600">
                Liên hệ
              </Link>
            </li>
          </ul>
        </div>
        <div className="absolute left-1/2 transform -translate-x-1/2 sm:hidden">
          <Link href="/" className="w-[90px]">
            <Image
              src={logo}
              alt="CNT04.alt"
              width={90}
              height={90}
              className="object-contain"
            />
          </Link>
        </div>
        {/* Search and Cart Icon */}
        <div className="flex items-center space-x-4">
          {/* Search Bar */}
          <SearchComponent />
          {/* Cart Icon */}
          <CartHeaderComponent />
        </div>
      </div>
      {/* Mobile Menu */}
      {isMenuOpen && (
        <div
          className="fixed inset-0 bg-black bg-opacity-50 z-40"
          onClick={closeMenu} // Đóng menu khi nhấp ra ngoài
        >
          <div
            className="absolute left-0 right-0 top-[56px]  bg-white shadow-md rounded-lg p-4 z-50"
            onClick={(e) => e.stopPropagation()} // Ngăn sự kiện lan ra container cha
          >
            <ul className="flex flex-col space-y-4 w-full font-bold">
              <Link href="/" className="hover:text-lime-600" onClick={closeMenu}>
                <li className="w-full">
                  <HomeOutlined className="mr-1" /> Trang chủ
                </li>
              </Link>

              <Link href="/shop" className="hover:text-lime-600" onClick={closeMenu}>
                <li>
                  {" "}
                  <ShopOutlined className="mr-1" /> Sản phẩm
                </li>
              </Link>

              <Link href="/blog" className="hover:text-lime-600" onClick={closeMenu}>
                <li>
                  {" "}
                  <ReconciliationOutlined className="mr-1" /> Bài viết
                </li>
              </Link>
              <Link href="/about" className="hover:text-lime-600" onClick={closeMenu}>
                <li>
                  <InsertRowBelowOutlined className="mr-1" /> Giới thiệu
                </li>
              </Link>

              <Link href="/contact" className="hover:text-lime-600" onClick={closeMenu}>
                <li>
                  {" "}
                  <PhoneOutlined className="mr-1" /> Liên hệ
                </li>
              </Link>
            </ul>
          </div>
        </div>
      )}
    </nav>
  );
}
