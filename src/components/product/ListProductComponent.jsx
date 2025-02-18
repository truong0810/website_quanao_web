'use client'
import Image from 'next/image'
import React, { useState } from 'react'
import {
    Dialog,
    DialogContent,
    DialogHeader,
    DialogTitle
} from "@/components/ui/dialog";
import * as _unitOfNetwork from '../../api'
import ProductComponent from './ProductComponent';
export default function ListProductComponent({ products }) {
    const [isModalVisible, setIsModalVisible] = useState(false);
    const [product, setProduct] = useState(null);
    const handleCloseModal = () => {
        setIsModalVisible(false);
        setProduct(null);
    };
    return (
        <>
            <div className="grid grid-cols-2 sm:grid-cols-2 md:grid-cols-2 lg:grid-cols-2 xl:grid-cols-3 gap-6">
                {products &&
                    products.map((item) => (
                        <ProductComponent key={'listProduct' + item.id} item={item} />
                    ))}
            </div>

            {isModalVisible && product && (
                <Dialog open={isModalVisible} onOpenChange={handleCloseModal}>
                    <DialogContent>
                        <DialogHeader>
                            <DialogTitle>{product.name}</DialogTitle>
                        </DialogHeader>
                        <div className="flex">
                            <Image
                                src={_unitOfNetwork.getLinkImage(product.filename)}
                                alt={product.name}
                                width={300}
                                height={300}
                                className="w-1/2 h-auto rounded-lg"
                            />
                            <div className="ml-6">
                                <div
                                    dangerouslySetInnerHTML={{ __html: product.description }}
                                    className="text-gray-800"
                                />
                                <p className="mt-4 text-lg font-semibold text-gray-800">
                                    <strong>Price: </strong>{product.pricePrecent}
                                </p>
                            </div>
                        </div>
                    </DialogContent>
                </Dialog>
            )}
        </>
    )
}
