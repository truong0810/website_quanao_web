"use client";
import React, { useState, useEffect } from "react";
import {
  Popover,
  PopoverContent,
  PopoverTrigger,
} from "@/components/ui/popover";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import Link from "next/link";
import * as _unitOfWork from "../../api";
import { toast } from 'react-hot-toast';

export default function SearchComponent() {
  const [username, setUserName] = useState("");
  const [password, setPassword] = useState("");
  const [user, setUser] = useState(null);

  useEffect(() => {
    const storedUser = JSON.parse(localStorage.getItem("user"));
    if (storedUser) {
      setUser(storedUser);
    }
  }, []);

  const handleSearch = async () => {
    const res = await _unitOfWork.login({
        username,
        password,
    });
    if (res && res.code == 1) {
      localStorage.setItem("user", JSON.stringify(res.user));
      localStorage.setItem("token", res.token);
      localStorage.setItem("refreshToken", res.refreshToken);
      setUser(res.user);
      toast.success(
        `Đã đăng nhập thành công !`,
        {
          style: {
            background: "#4caf50",
            color: "#fff",
          },
          position: "top-right",
        }
      );
    } else {
      toast.error(
        `Đăng nhập thất bại !`,
        {
          style: {
           background: "#ff0000",
          color: "#fff",
          },
          position: "top-right",
        }
      );
    }
  };

  const handleLogout = () => {
    localStorage.removeItem("user");
    localStorage.removeItem("token");
    localStorage.removeItem("refreshToken");
    setUser(null);
    toast.success(
      `Đã đăng xuất thành công !`,
      {
        style: {
          background: "#4caf50",
          color: "#fff",
        },
        position: "top-right",
      }
    );
  };

  return (
    <>
      {/* <div className="relative hidden md:block">
                <input
                    id="searchInput"
                    type="text"
                    className="pl-2 md:pl-10 md:pr-4 py-2 bg-gray-100 text-gray-800 rounded-full focus:outline-none focus:ring-2 focus:ring-blue-500"
                    placeholder="Tìm kiếm..."
                />
            </div> */}

      <Popover className="top-[20px]">
        <PopoverTrigger asChild>
          {user ? (
            <Button
              className=" bg-green-500  hover:bg-green-600"
            >
              {user.username}
            </Button>
          ) : (
            <Button
              className=" bg-green-500  hover:bg-green-600"
            >
              Đăng nhập 
            </Button>
          )}
        </PopoverTrigger>
        {user ? (
          <PopoverContent className="w-[10rem]">
            <div className="grid gap-4">
              <button
                className="text-center w-[100%] uppercase bg-[#ffffff]"
                onClick={handleLogout}
              >
                Đăng xuất
              </button>
            </div>
          </PopoverContent>
        ) : (
          <PopoverContent className="w-[28rem]">
            <div className="grid gap-4">
              <div className="text-center">
                <p className="font-black  text-xl upercase">
                  Đăng nhập tài khoản
                </p>
                <p className="text-base ">Nhập tên tài khoản và mật khẩu</p>
              </div>
              <div className="grid gap-2">
                <div className=" items-center gap-4">
                  <Input
                    id="width"
                    className="h-8"
                    placeholder="Nhập tài khoản"
                    value={username}
                    onChange={(e) => setUserName(e.target.value)}
                  />
                </div>
                <div className=" items-center">
                  <Input
                    id="maxWidth"
                    className="col-span-2 h-8"
                    type="password"
                    placeholder="Nhập mật khẩu"
                    value={password}
                    onChange={(e) => setPassword(e.target.value)}
                  />
                </div>
                <div className="w-[100%]">
                  <Button
                    className="text-center w-[100%] uppercase"
                    onClick={handleSearch}
                  >
                    Đăng nhập
                  </Button>
                </div>
                <div>
                  <p>
                    Khách hàng mới?{" "}
                    <Link href="/auth" className="font-black ">
                      {" "}
                      Tạo tài khoản mới
                    </Link>{" "}
                  </p>
                  <p>
                    Quên mật khẩu?{" "}
                    <Link href="#" className="font-black">
                      {" "}
                      Khôi phục mật khẩu
                    </Link>{" "}
                  </p>
                </div>
              </div>
            </div>
          </PopoverContent>
        )}
      </Popover>
    </>
  );
}
