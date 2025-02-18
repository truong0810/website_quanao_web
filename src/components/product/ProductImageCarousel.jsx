'use client'
import React, { useState } from 'react'
import "lightgallery/css/lightgallery.css";
import LightGallery from "lightgallery/react";
import Image from "next/image";
import { Carousel, CarouselContent, CarouselItem } from '../ui/carousel';
import * as _unitOfNetwork from '../../api'
export default function ProductImageCarousel({ images }) {
    const [selectedImage, setSelectedImage] = useState(images[0]);
    return (
        <div className='w-full'>
            <div className="cursor-pointer w-full">
                <LightGallery>
                    {images.map((image, index) => (
                        <div
                            key={index}
                            data-src={_unitOfNetwork.getLinkImage(image.fileName)}
                            className={`relative w-full bg-gray-50 ${image.fileName !== selectedImage.fileName ? 'hidden' : ''}`}
                        >
                            <Image
                                src={_unitOfNetwork.getLinkImage(image.fileName)}
                                alt={`Ảnh : ${image.fileName}`}
                                width={450}
                                height={450}
                                className="aspect-square object-cover w-full"
                            />
                        </div>))}
                </LightGallery>
            </div>

            {/* Các thumbnail bên dưới */}
            <div className="mt-1">
                {images.length > 4 ? (
                    <Carousel>
                        <CarouselContent className="">
                            {images.map((image, index) => (
                                <CarouselItem key={index} className="basis-1/4 sm:basis-1/5">
                                    <div

                                        className={`w-[82px] h-[82px] cursor-pointer border ${image.fileName === selectedImage.fileName ? 'border-blue-500' : 'border-transparent'
                                            }`}
                                        onClick={() => setSelectedImage(image)}
                                    >
                                        <Image
                                            src={_unitOfNetwork.getLinkImage(image.fileName)}
                                            alt={`Thumbnail ${index + 1}`}
                                            width={82}
                                            height={82}
                                            className="aspect-square object-cover w-full hover:bg-slate-300"
                                        />
                                    </div>
                                </CarouselItem>
                            ))}
                        </CarouselContent>
                    </Carousel>
                ) : (
                    <div className="flex">
                        {images.map((image, index) => (
                            <div
                                key={index}
                                className={`w-[82px] h-[82px] mr-2 cursor-pointer border ${image.fileName === selectedImage.fileName ? 'border-blue-500' : 'border-transparent'
                                    }`}
                                onClick={() => setSelectedImage(image)}
                            >
                                <Image
                                    src={_unitOfNetwork.getLinkImage(image.fileName)}
                                    alt={`Thumbnail ${index + 1}`}
                                    width={82}
                                    height={82}
                                    className="aspect-square object-cover w-full hover:bg-slate-300"
                                />
                            </div>
                        ))}
                    </div>
                )}
            </div>
        </div>
    )
}
