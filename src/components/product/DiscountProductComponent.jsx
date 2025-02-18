import React from "react";
import Image from "next/image";
import * as _unitOfWork from "../../api";
export default function DiscountProductComponent({ product }) {
  return (
    <div
      className="bg-white overflow-hidden group discount-product-container box-shadow-pnp"
    >
      <div className="relative w-full h-[15vh] md:h-[34vh]">
        <div className="product-name">{product.name}</div>
        <Image
          src={_unitOfWork.getLinkImage(product.images[0])}
          alt="CNT04.png"
          layout="responsive"
          width={300}
          height={100}
          className="product-image  aspect-square transition-transform duration-500 group-hover:scale-110"
        />

        {/* <div className="absolute inset-0 bg-gradient-to-b from-transparent flex flex-col justify-start p-6">
          <h3 className="text-base lg:text-lg font-black text-gray-800">
            {product.name}
          </h3>
          <p className="text-sm text-gray-500 w-[200px]">{product.title}</p>
          <div className="p-4 pl-0">
            <div className="flex items-center">
              {product?.promotions?.[0]?.discountAmount && (
                <span className="text-sm md:text-xl font-bold text-gray-700">
                  {formatPrice(product.promotions[0].discountAmount)}
                </span>
              )}
              {product?.promotions?.[0]?.discountPercentage && (
                <span className="text-[10px] md:text-sm text-gray-500 line-through ml-3">
                  {formatPrice(product.promotions[0].discountPercentage)}
                </span>
              )}
            </div>

            <div className="mt-4 text-sm font-black hover:text-lime-600">
              <Link href={`/product/${product.id}`}>
                Mua hàng <RightOutlined />
              </Link>
            </div>
          </div>
        </div> */}
      </div>
    </div>
  );
}
