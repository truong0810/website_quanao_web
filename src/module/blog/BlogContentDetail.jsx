import Image from "next/image";
import {
  CalendarOutlined,
  MessageOutlined,
  UserOutlined,
} from "@ant-design/icons";
import * as _unitOfWork from "../../api";
import { parseFullDatetime } from "../../components/helper/date-helper";
import BlogTag from "@/module/blog/blogTagCategory/BlogTag";

export default function BlogContentDetail({ blog, blogTags, blogImages }) {
  return (
    <div className="blog-content-container">
      <div className="text-justify text-2xl md:text-4xl font-black text-black mb-[20px] md:mb-[40px]">
        {blog?.title}
      </div>
      {/* Thông tin bài viết */}
      <div className="w-full text-xs md:text-sm text-black">
        <div className="flex flex-wrap items-center mb-2 ">
          <div className="flex items-center  md:mb-0">
            <CalendarOutlined className="text-lime-600 text-sm" />
            <span className=" ml-2 font-bold uppercase">
              {parseFullDatetime(blog?.createdDate)}
            </span>
          </div>
          <div className="items-center ml-7  md:mb-0 hidden md:flex">
            <UserOutlined className="text-lime-600 text-sm" />
            <span className="ml-2 font-bold uppercase  ">CNT04</span>
          </div>
          <button className="ml-3  md:ml-7 flex items-center ">
            <MessageOutlined className="text-lime-600 mr-2 text-sm" />
            <span className=" font-bold uppercase hover:text-lime-600">
              Không có bình luận
            </span>
          </button>
        </div>
      </div>
      <div className="text-justify text-base md:text-2xl text-black font-bold mb-[20px]">{blog?.text}</div>
      {/* Hình ảnh chính của bài viết */}
      {blogImages && blogImages.length > 0 && (
        <div className="w-full h-[30vh] md:h-[60vh] mb-6">
          <Image
            src={_unitOfWork.getLinkImageResource(blogImages[0]?.blogImageId)}
            width={800}
            height={400}
            alt={blogImages[0]?.blogImageId}
            className="size-full object-cover rounded-lg"
          />
        </div>
      )}

      {/* Nội dung bài viết */}
      <div
        className="mb-6 text-sm md:text-base leading-relaxed text-justify"
        dangerouslySetInnerHTML={{ __html: blog?.description }}
      />
      {/* Tags bài viết */}
      {blogTags && blogTags.length > 0 && (
        <div className="flex flex-wrap items-center gap-2 border-y border-slate-300 py-4 mb-6">
          <BlogTag blogTags={blogTags} />
        </div>
      )}

      {/* <hr className="mb-[30px]"></hr> */}
      {/* <div className="font-semibold text-xl mb-[30px] ">
        Để lại một bình luận
      </div>
      <div>
        <Card className="w-full  p-4 mb-[40px] shadow-lg ">
          <CardContent>
            <form>
              <div className="grid w-full items-center gap-4">
                <div className="flex flex-col space-y-1.5">
                  <Label htmlFor="name">Name</Label>
                  <Input id="name" placeholder="Name of your project" />
                </div>
                <div className="flex flex-col space-y-1.5">
                  <Label htmlFor="name">Email</Label>
                  <Input id="name" placeholder="Nhập email" />
                </div>
              </div>
            </form>
          </CardContent>
          <CardFooter className="flex justify-between">
            <Button className="hover:bg-lime-600">Deploy</Button>
          </CardFooter>
        </Card>
      </div> */}
    </div>
  );
}
