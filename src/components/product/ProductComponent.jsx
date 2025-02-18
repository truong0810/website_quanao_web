"use client";
import React, { useState } from "react";
import Image from "next/image";
import { ShoppingCartOutlined, EyeOutlined } from "@ant-design/icons";
import Link from "next/link";
import { useCart } from "../cart/CartContext";
import {
  Dialog,
  DialogBackdrop,
  DialogPanel,
  DialogTitle,
} from "@headlessui/react";
import { toast } from "react-hot-toast";
import * as _unitOfNetwork from "../../api";
export default function ProductComponent({ item }) {
  const [open, setOpen] = useState(false);
  const [quantity, setQuantity] = useState(1);
  const { addToCart } = useCart();
  const handleAddToCart = () => {
    setOpen(true);
  };
  const handleConfirmAddToCart = () => {
    const newItem = {
      id: item.id,
      name: item.name,
      image: item.images[0],
      price: item.pricePrecent,
      quantity: quantity,
    };
    addToCart(newItem);
    toast.success(
      `${item.name} đã được thêm vào giỏ hàng với số lượng ${quantity}!`,
      {
        style: {
          background: "#4caf50",
          color: "#fff",
        },
        position: "top-right",
      }
    );
    setOpen(false);
  };
  const updateQuantity = (value) => {
    setQuantity((prevQuantity) => {
      const newQuantity = prevQuantity + value;
      return newQuantity >= 1 ? newQuantity : 1;
    });
  };
  return (
    <>
      <div className="bg-white overflow-hidden transform transition-all group box-shadow-pnp">
        <div className="relative  ">
          <Image
            src={_unitOfNetwork.getLinkImage(
              item.images ? item.images[0] : null
            )}
            alt={item.name}
            layout="responsive"
            width={300}
            height={300}
            className=" w-full aspect-square object-cover transition-transform duration-300"
          />
          <div className="absolute inset-x-0 bottom-3 md:bottom-6 flex items-center justify-center md:opacity-0 group-hover:opacity-100 transition-opacity duration-300">
            <button
              onClick={handleAddToCart}
              className="bg-white text-gray-700 w-8 h-8 md:w-12 md:h-12 rounded-full flex items-center justify-center shadow-md hover:bg-black hover:text-white transition-all"
            >
              <ShoppingCartOutlined style={{ fontSize: "18px" }} />
            </button>
            <Link href={`/product/${item.id}`}>
              <button className="ml-4 bg-white text-gray-700 w-8 h-8 md:w-12 md:h-12 rounded-full flex items-center justify-center shadow-md hover:bg-black hover:text-white transition-all">
                <EyeOutlined style={{ fontSize: "18px" }} />
              </button>
            </Link>
          </div>
        </div>
        <div className="p-4 ">
          <Link href={`/product/${item.id}`}>
            <p className="text-sm md:text-base text-gray-800 truncate">
              {item.name}
            </p>
          </Link>
          <p className="md:text-base text-sm font-semibold text-gray-900 md:mt-2">
            {new Intl.NumberFormat("vi-VN", {
              style: "currency",
              currency: "VND",
            }).format(item.pricePrecent || 0)}
          </p>
        </div>
      </div>
      <Dialog open={open} onClose={setOpen} className="relative z-10">
        <DialogBackdrop
          transition
          className="fixed inset-0 bg-gray-500/75 transition-opacity data-[closed]:opacity-0 data-[enter]:duration-300 data-[leave]:duration-200 data-[enter]:ease-out data-[leave]:ease-in"
        />

        <div className="fixed inset-0 z-10 w-screen overflow-y-auto">
          <div className="flex min-h-full items-end justify-center p-4 text-center items-center p-0">
            <DialogPanel
              transition
              className="relative transform overflow-hidden rounded-lg bg-white text-left shadow-xl transition-all data-[closed]:translate-y-4 data-[closed]:opacity-0 data-[enter]:duration-300 data-[leave]:duration-200 data-[enter]:ease-out data-[leave]:ease-in sm:my-8 sm:w-full sm:max-w-lg data-[closed]:sm:translate-y-0 data-[closed]:sm:scale-95"
            >
              <div className="bg-white px-4 pb-4 pt-5 sm:p-6 sm:pb-4">
                <div className="sm:flex sm:items-start">
                  <div className="mt-3 text-center sm:ml-4 sm:mt-0 sm:text-left">
                    <DialogTitle
                      as="h3"
                      className="text-base font-semibold text-gray-900"
                    >
                      Nhập số lượng
                    </DialogTitle>
                    <div className="mt-4 flex justify-center items-center">
                      <h3 className="mr-2">{item.name} :</h3>
                      <button
                        onClick={() => updateQuantity(-1)}
                        className="px-3 py-1 bg-gray-200 hover:bg-gray-300 rounded"
                      >
                        -
                      </button>
                      <input
                        type="number"
                        value={quantity}
                        onChange={(e) => setQuantity(Number(e.target.value))}
                        className="w-16 text-center p-1 border border-gray-300 rounded-md mx-2"
                        min="1"
                        max="100"
                      />
                      <button
                        onClick={() => updateQuantity(1)}
                        className="px-3 py-1 bg-gray-200 hover:bg-gray-300 rounded"
                      >
                        +
                      </button>
                    </div>
                  </div>
                </div>
              </div>
              <div className="bg-gray-50 px-4 py-3 sm:flex sm:flex-row-reverse sm:px-6">
                <button
                  type="button"
                  onClick={handleConfirmAddToCart}
                  className="inline-flex w-full justify-center rounded-md bg-green-600 px-3 py-2 text-sm font-semibold text-white shadow-sm hover:bg-green-500 sm:ml-3 sm:w-auto"
                >
                  Xác nhận
                </button>
                <button
                  type="button"
                  data-autofocus
                  onClick={() => setOpen(false)}
                  className="mt-3 inline-flex w-full justify-center rounded-md bg-white px-3 py-2 text-sm font-semibold text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 hover:bg-gray-50 sm:mt-0 sm:w-auto"
                >
                  Thoát
                </button>
              </div>
            </DialogPanel>
          </div>
        </div>
      </Dialog>
    </>
  );
}
