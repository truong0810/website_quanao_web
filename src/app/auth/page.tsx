"use client";
import React, { useState } from "react";
import { Input } from "@/components/ui/input";
import { Button } from "@/components/ui/button";
import { toast } from "react-hot-toast";
import * as _unitOfWork from "../../api";

export default function RegisterPage() {
  const [formData, setFormData] = useState({
    username: "",
    email: "",
    password: "",
    confirmPassword: "",
  });

  const handleInputChange = (e) => {
    const { name, value } = e.target;
    setFormData((prev) => ({ ...prev, [name]: value }));
  };

  const handleRegister = async () => {
    const { username, email, password, confirmPassword } = formData;

    if (password !== confirmPassword) {
      toast.error("Mật khẩu không khớp!", {
        style: {
          background: "#ff0000",
          color: "#fff",
        },
        position: "top-right",
      });
      return;
    }

    const res = await _unitOfWork.register({user:{ username, email, password }});
    if (res && res.code === 1) {
      toast.success("Đăng ký thành công!", {
        style: {
          background: "#4caf50",
          color: "#fff",
        },
        position: "top-right",
      });
      window.location.href = "/home";
    } else {
      toast.error(`Đăng ký thất bại: ${res.message}`, {
        style: {
          background: "#ff0000",
          color: "#fff",
        },
        position: "top-right",
      });
    }
  };

  return (
    <div className="min-h-screen flex items-center justify-center bg-gray-50">
      <div className="bg-white p-6 rounded-lg shadow-lg w-full max-w-md">
        <h2 className="text-2xl font-bold mb-6 text-center">Đăng ký</h2>
        <form className="space-y-4">
          <Input
            type="text"
            name="username"
            value={formData.username}
            onChange={handleInputChange}
            placeholder="Tên tài khoản"
            className="w-full p-3 border rounded-lg focus:outline-none focus:ring focus:ring-blue-200"
            required
          />
          <Input
            type="email"
            name="email"
            value={formData.email}
            onChange={handleInputChange}
            placeholder="Email"
            className="w-full p-3 border rounded-lg focus:outline-none focus:ring focus:ring-blue-200"
            required
          />
          <Input
            type="password"
            name="password"
            value={formData.password}
            onChange={handleInputChange}
            placeholder="Mật khẩu"
            className="w-full p-3 border rounded-lg focus:outline-none focus:ring focus:ring-blue-200"
            required
          />
          <Input
            type="password"
            name="confirmPassword"
            value={formData.confirmPassword}
            onChange={handleInputChange}
            placeholder="Xác nhận mật khẩu"
            className="w-full p-3 border rounded-lg focus:outline-none focus:ring focus:ring-blue-200"
            required
          />
          <Button
            type="button"
            onClick={handleRegister}
            className="w-full bg-green-600 text-white py-3 rounded-lg hover:bg-green-700"
          >
            Đăng ký
          </Button>
        </form>
      </div>
    </div>
  );
}
