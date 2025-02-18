"use client";
import React, { useState, useEffect } from "react";
import Image from "next/image";
import { useCart } from "../../components/cart/CartContext";
import * as _unitOfNetwork from "../../api";
import { toast } from "react-hot-toast";
import NoResultComponent from "@/components/common/NoResultComponent";
export default function Page() {
  const { cart, addToCart, removeFromCart } = useCart();
  const [subtotal, setSubtotal] = useState(0);
  const [customerInfo, setCustomerInfo] = useState({
    name: "",
    email: "",
    phone: "",
    address: "",
  });

  useEffect(() => {
    const total = cart.reduce(
      (sum, product) => sum + product.price * product.quantity,
      0
    );
    setSubtotal(total);
  }, [cart]);

  const updateQuantity = (id, delta) => {
    const product = cart.find((p) => p.id === id);
    if (product) {
      const newQuantity = product.quantity + delta;
      if (newQuantity >= 1) {
        addToCart({ id, quantity: delta });
      }
    }
  };

  const handleInputChange = (e) => {
    const { name, value } = e.target;
    setCustomerInfo((prev) => ({ ...prev, [name]: value }));
  };

  const handlePayment = async () => {
    if (cart.length == 0) {
      toast.error(`Giỏ hàng trống!`, {
        style: {
          background: "#ff0000",
          color: "#fff",
        },
        position: "top-right",
      });
      return;
    }

    const { name, email, phone, address } = customerInfo;
    if (!name || !phone || !address) {
      toast.error(`Vui lòng điền đầy đủ thông tin khách hàng!`, {
        style: {
          background: "#ff0000",
          color: "#fff",
        },
        position: "top-right",
      });
      return;
    }

    const user = JSON.parse(localStorage.getItem("user"));
    if (!user) {
      toast.error(`Vui lòng đăng nhập để đặt hàng!`, {
        style: {
          background: "#ff0000",
          color: "#fff",
        },
        position: "top-right",
      });
      return;
    }

    const res = await _unitOfNetwork.payment({
      carts: cart,
      name,
      phone,
      email,
      address,
    });
    if (res && res.code === 1) {
      toast.success(`Đặt hàng thành công!`, {
        style: {
          background: "#4caf50",
          color: "#fff",
        },
        position: "top-right",
      });
      localStorage.removeItem("cart");
      window.location.href = "/";
    } else {
      toast.error(`Đặt hàng thất bại : ${res.message}`, {
        style: {
          background: "#ff0000",
          color: "#fff",
        },
        position: "top-right",
      });
    }
  };

  return (
    <div className="min-h-screen bg-gray-50 md:p-2 sm:p-4">
      <div className="mx-auto bg-white p-2 md:p-4 sm:p-6 shadow-lg rounded-lg md:w-[80%]">
        <h1 className="text-2xl sm:text-3xl font-semibold mb-4 sm:mb-6">
          Giỏ hàng
        </h1>

        {/* Danh sách sản phẩm */}
        {cart.length == 0 ? (
          <NoResultComponent />
        ) : (
          <div className="space-y-4">
            {cart.map((product) => (
              <div
                key={product.id}
                className="grid grid-cols-1 md:grid-cols-6 items-center gap-4 border-b"
              >
                <div className="flex items-center justify-between w-full md:w-auto md:col-span-4">
                  <Image
                    src={_unitOfNetwork.getLinkImage(product.image)}
                    alt={product.name}
                    width={80}
                    height={80}
                    className="object-cover rounded-md"
                  />
                  <div className="w-full ml-1 md:w-auto flex flex-col">
                    <h2 className="">{product.name}</h2>
                    <p className="text-gray-500">
                      {new Intl.NumberFormat("vi-VN", {
                        style: "currency",
                        currency: "VND",
                      }).format(product.price)}
                    </p>
                  </div>
                  <div className="flex items-center justify-center">
                    <button
                      onClick={() => updateQuantity(product.id, -1)}
                      className="px-3 py-1 bg-gray-200 hover:bg-gray-300 rounded"
                    >
                      -
                    </button>
                    <input
                      type="number"
                      value={product.quantity}
                      onChange={(e) =>
                        updateQuantity(
                          product.id,
                          parseInt(e.target.value) - product.quantity
                        )
                      }
                      className="md:w-16 text-center p-1 border border-gray-300 rounded-md md:mx-2"
                      min="1"
                      max="100"
                    />
                    <button
                      onClick={() => updateQuantity(product.id, 1)}
                      className="px-3 py-1 bg-gray-200 hover:bg-gray-300 rounded"
                    >
                      +
                    </button>
                  </div>
                </div>
                <div className="text-right hidden md:block md:col-span-1">
                  <p className="text-gray-500">
                    {new Intl.NumberFormat("vi-VN", {
                      style: "currency",
                      currency: "VND",
                    }).format(product.price * product.quantity)}
                  </p>
                </div>
                <div className="text-center md:text-right md:col-span-1">
                  <button
                    onClick={() => removeFromCart(product.id)}
                    className="text-red-500 hover:text-red-700"
                  >
                    Xóa
                  </button>
                </div>
              </div>
            ))}
          </div>
        )}

        {/* Thông tin khách hàng */}
        <div className="mt-6 p-4 bg-gray-50 border rounded-lg">
          <h2 className="text-2xl font-semibold mb-4">Thông tin khách hàng</h2>
          <form className="space-y-4">
            <input
              type="text"
              name="name"
              value={customerInfo.name}
              onChange={handleInputChange}
              placeholder="Họ và tên"
              className="w-full p-3 border rounded-lg focus:outline-none focus:ring focus:ring-blue-200"
              required
            />
            <input
              type="email"
              name="email"
              value={customerInfo.email}
              onChange={handleInputChange}
              placeholder="Email"
              className="w-full p-3 border rounded-lg focus:outline-none focus:ring focus:ring-blue-200"
              required
            />
            <input
              type="text"
              name="phone"
              value={customerInfo.phone}
              onChange={handleInputChange}
              placeholder="Số điện thoại"
              className="w-full p-3 border rounded-lg focus:outline-none focus:ring focus:ring-blue-200"
              required
            />
            <textarea
              name="address"
              value={customerInfo.address}
              onChange={handleInputChange}
              placeholder="Địa chỉ"
              className="w-full p-3 border rounded-lg focus:outline-none focus:ring focus:ring-blue-200"
              rows="3"
              required
            />
          </form>
        </div>

        {/* Voucher */}
        <div className="mt-6 flex flex-col sm:flex-row items-center justify-between p-4 border-t">
          <input
            type="text"
            placeholder="Mã voucher"
            className="border border-gray-300 p-2 rounded-lg focus:outline-none focus:ring focus:ring-blue-200"
          />
          <button className="mt-4 sm:mt-0 bg-blue-600 text-white px-4 py-2 rounded-lg hover:bg-blue-700">
            Áp dụng
          </button>
        </div>

        {/* Thanh toán */}
        <div className="mt-6 p-4 border-t">
          <div className="flex justify-between text-lg font-bold">
            <span>Thành tiền</span>
            <span>
              {new Intl.NumberFormat("vi-VN", {
                style: "currency",
                currency: "VND",
              }).format(subtotal)}
            </span>
          </div>
          <button
            onClick={handlePayment}
            className="w-full mt-4 bg-green-600 text-white py-3 rounded-lg hover:bg-green-700"
          >
            Đặt hàng
          </button>
        </div>
      </div>
    </div>
  );
}
