'use client'
import React from 'react'
import { ShoppingCartOutlined } from "@ant-design/icons";
import { useCart } from "@/components/cart/CartContext";
import Link from "next/link";
export default function CartHeaderComponent() {
    const { cart } = useCart();
    return (
        <Link
            href="/cart"
            className="flex items-center relative group"
        >
            <ShoppingCartOutlined className="text-2xl mr-2 transition-all group-hover:text-primary-600" />

            {/* Hiển thị badge số lượng */}
            {cart && (
                <span className="absolute top-[-3px] right-[10px]  md:top-[-5px] md:right-[-5px] flex justify-center items-center w-[15px] h-[15px] md:w-5 md:h-5 bg-red-600 text-white text-xs font-semibold rounded-full">
                    {cart.length}
                </span>
            )}
        </Link>
    )
}
