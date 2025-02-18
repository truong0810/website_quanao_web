import Image from "next/image";
import Link from "next/link";
import * as _unitOfWork from "../../../api";
import { parseFullDatetime } from "@/components/helper/date-helper";

export function HomeBlog({ blogs }) {
  return (
    <div className=" mb-[6vh] md:mb-[8vh] margin-main">
      <div className="text-xl md:text-2xl mt-[6vh] md:mt-[8vh] font-bold capitalize mb-[20px] text-center">
        Bài viết mới nhất
      </div>
      <div className="grid grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-4 ">
        {blogs?.slice(0, 4).map((data, index) => (
          <div key={data?.id} className={`bg-white shadow-md rounded-lg overflow-hidden border-gray-300 ${ index >= 2 ? "hidden sm:block" : "" } ${index >= 4 ? "hidden md:block" : ""}`}>
            <Link href={`/blog/${data.id}`}>
              <div className="w-full h-[20vh]  md:h-[32vh] relative">
                <Image
                  src={_unitOfWork.getLinkImageResource(
                    data?.blogImages?.map((data) => data.blogImageId)
                  )}
                  alt="_solution.alt"
                  layout="fill"
                  objectFit="cover"
                  className="hover:opacity-75 transition-opacity duration-300 "
                />
              </div>
            </Link>
            <div className="p-3 min-h-[10vh]">
              <Link href={`/blog/${data.id}`}>
                <div className="font-bold text-sm md:text-base mb-[2px] hover:text-lime-600 cursor-pointer ">
                  {data?.title}
                </div>
              </Link>
              <p className="text-gray-500 text-xs md:text-sm">
                {parseFullDatetime(data?.createdDate)}
              </p>
            </div>
          </div>
        ))}
      </div>
    </div>
  );
}
