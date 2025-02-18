"use client";
import {
  Carousel,
  CarouselContent,
  CarouselItem,
  // CarouselNext,
  // CarouselPrevious,
} from "@/components/ui/carousel";
import * as _unitOfNetwork from "../../../api";
import Autoplay from "embla-carousel-autoplay";
import { useRef } from "react";

export default function HomeElementer({ partners }) {
  const autoplayPlugin = useRef(
    Autoplay({ delay: 3000, stopOnInteraction: false }) // Dừng tương tác không cần thiết
  );

  return (
    <div className="mb-[6vh] md:mb-[8vh] margin-main">
      <div className="text-xl md:text-2xl font-bold text-center capitalize mb-[2vh]">
        Đối tác công ty
      </div>
      <Carousel
        opts={{
          align: "start",
          loop: true, // Kích hoạt chế độ chạy liên tục
        }}
        plugins={[autoplayPlugin.current]}
        className="w-full"
      >
        <CarouselContent>
          {partners.map((data) => (
            <div
              key={data.id}
              className="flex-shrink-0 text-center pb-3 w-1/4 lg:w-1/6 pl-4"
            >
              <CarouselItem
                className="h-[80px] w-[80px] md:h-[20vh] md:w-[10vw] mx-auto bg-cover bg-center hover:opacity-75 transition-opacity duration-300"
                style={{
                  backgroundImage: `url(${_unitOfNetwork.getLinkImageResource(
                    data.imageId
                  )})`,
                }}
              ></CarouselItem>
            </div>
          ))}
        </CarouselContent>
        {/* <CarouselPrevious className="hidden md:flex" />
        <CarouselNext className="hidden md:flex" /> */}
      </Carousel>
    </div>
  );
}
