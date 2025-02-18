'use client'
import React, { useState } from 'react'
import { useCart } from '../cart/CartContext'
import { Dialog, DialogBackdrop, DialogPanel, DialogTitle } from '@headlessui/react'
import { toast } from 'react-hot-toast';
export default function AddToCartComponent({ product }) {
    const { addToCart } = useCart();
    const [quantity, setQuantity] = useState(1);
    const [open, setOpen] = useState(false);
    const handleAddToCart = () => {
        setOpen(true);
    };

    const handleConfirmAddToCart = () => {
        const newItem = {
            id: product.id,
            name: product.name,
            price: product.pricePrecent,
            quantity: quantity,
            image: product.images[0],
        };
        addToCart(newItem);
        toast.success(`${product.name} đã được thêm vào giỏ hàng với số lượng ${quantity}!`, {
            style: {
                background: '#4caf50',
                color: '#fff',
            },
            position: 'top-right',
        });
        setOpen(false); // Đóng modal sau khi thêm vào giỏ
    };

    const handleQuantityChange = (delta) => {
        setQuantity((prev) => Math.max(prev + delta, 1)); // Đảm bảo số lượng không nhỏ hơn 1
    };
    return (
        <div className="flex items-center space-x-4 mb-4">
            {/* <div className="bg-slate-200 w-20 h-10 flex items-center justify-between px-2 rounded-md">
                <button
                    onClick={() => handleQuantityChange(-1)}
                    className="text-xl text-gray-700"
                >
                    -
                </button>
                <span className="text-center w-10">{quantity}</span>
                <button
                    onClick={() => handleQuantityChange(1)}
                    className="text-xl text-gray-700"
                >
                    +
                </button>
            </div> */}
            <button
                onClick={handleAddToCart}
                style={{ fontSize: "12px" }}
                className="bg-lime-600 text-white h-10 w-[200px] uppercase rounded-md font-semibold hover:bg-lime-700 transition duration-300"
            >
                Thêm vào giỏ hàng
            </button>
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
                                        <DialogTitle as="h3" className="text-base font-semibold text-gray-900">
                                            Nhập số lượng
                                        </DialogTitle>
                                        <div className="mt-4 flex justify-center items-center">
                                            <h3 className='mr-2'>{product.name} :</h3>
                                            <button
                                                onClick={() => handleQuantityChange(-1)}
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
                                                onClick={() => handleQuantityChange(1)}
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
        </div>
    );
}
