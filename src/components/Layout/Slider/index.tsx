import {
  LeftOutlined,
  RightOutlined,
} from "@ant-design/icons";
import Image from "next/image";
import React, { useState, useEffect } from "react";
import * as _unitOfWork from "../../../api";
import "./index.scss";

const CarouselItem = ({ item, isActive }) => (
  <div
    className={`relative flex-shrink-0 w-full p-0 h-[22vh] md:h-[85vh] transition-opacity duration-300 ${
      isActive ? "opacity-100" : "opacity-0 absolute top-0 left-0"
    }`}
  >
    {/* <div className="product-name">{item.name}</div> */}
    <Image
      src={_unitOfWork.getLinkImageResource(item?.imageId)}
      alt={item.name}
      width={1920}
      height={1080}
      className="size-full product-image"
    />
  </div>
);

const Slider = ({ banners }) => {
  const [activeIndex, setActiveIndex] = useState(0);
  const [touchStart, setTouchStart] = useState(0);
  const [touchEnd, setTouchEnd] = useState(0);

  const nextSlide = () => {
    setActiveIndex((prevIndex) => (prevIndex + 1) % banners.length);
  };

  const prevSlide = () => {
    setActiveIndex(
      (prevIndex) => (prevIndex - 1 + banners.length) % banners.length
    );
  };

  const handleTouchStart = (e) => {
    setTouchStart(e.targetTouches[0].clientX);
  };

  const handleTouchMove = (e) => {
    setTouchEnd(e.targetTouches[0].clientX);
  };

  const handleTouchEnd = () => {
    if (touchStart - touchEnd > 50) {
      nextSlide();
    }
    if (touchStart - touchEnd < -50) {
      prevSlide();
    }
  };

  useEffect(() => {
    const interval = setInterval(() => {
      nextSlide();
    }, 7000);
    return () => clearInterval(interval);
  }, []);

  return (
    <div className="relative w-full overflow-hidden slider-container">
      <div
        className="flex transition-transform duration-300 ease-in-out"
        style={{ transform: `translateX(-${activeIndex * 100}%)` }}
        onTouchStart={handleTouchStart}
        onTouchMove={handleTouchMove}
        onTouchEnd={handleTouchEnd}
      >
        {banners.map((item, index) => (
          <CarouselItem
            key={'slider_'+index}
            item={item}
            isActive={index === activeIndex}
          />
        ))}
      </div>
      <button
        className="absolute top-1/2 left-4 transform -translate-y-1/2 bg-white bg-opacity-50 hover:bg-opacity-75 rounded-full p-2 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500 hidden md:block"
        onClick={prevSlide}
        aria-label="Previous slide"
      >
        <LeftOutlined className="text-black text-base md:text-xl " />
      </button>
      <button
        className="absolute top-1/2 right-4 transform -translate-y-1/2 bg-white bg-opacity-50 hover:bg-opacity-75 rounded-full p-2 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500 hidden md:block"
        onClick={nextSlide}
        aria-label="Next slide"
      >
        <RightOutlined className="text-black text-base md:text-xl" />
      </button>
      <div className="absolute bottom-4 left-1/2 transform -translate-x-1/2 flex space-x-2">
        {banners.map((_, index) => (
          <button
            key={index}
            className={`w-3 h-3 rounded-full focus:outline-none ${
              index === activeIndex ? "bg-lime-600 " : "bg-white "
            }`}
            onClick={() => setActiveIndex(index)}
            aria-label={`Go to slide ${index + 1}`}
          />
        ))}
      </div>
    </div>
  );
};

export default Slider;
