import {
  CalendarOutlined,
  MessageOutlined,
  RetweetOutlined,
  UserOutlined,
} from "@ant-design/icons";
import { Metadata } from "next";
import { Button } from "@/components/ui/button";
import { Card, CardContent, CardFooter } from "@/components/ui/card";
import { Label } from "@/components/ui/label";
import { Input } from "@/components/ui/input";
import { Avatar, AvatarImage } from "@/components/ui/avatar";
import { Textarea } from "@/components/ui/textarea";
export const metadata: Metadata = {
  title: "Trang Blog",
  description: "",
};

export default async function BlogComment() {
  return (
    <div className="">
      {/* <div className="w-full h-[200px] bg-slate-100 mb-[40px] flex flex-col items-center justify-center">
        <div className="text-3xl font-semibold">Trang BlogComment</div>
        <div>Đường dẫn (Theo các bài viết) </div>
      </div> */}
      <div className="">
        <div className="flex mb-[10px]">
          <CalendarOutlined className="text-lime-600 " />
          <span className="text-slate-400 text-sm ml-2">
            Tháng Một 18, 2021
          </span>
          <UserOutlined className="ml-5 text-lime-600 cursor-pointer" />
          <button className="ml-5 hover:text-lime-600 ">
            <MessageOutlined className="text-lime-600 mr-2" />
            <span className="text-slate-400 text-sm">Tổng số bình luận</span>
          </button>
        </div>
        <div className="mb-[20px]">Nội dung bình luận</div>

        <div className="text-2xl font-bold mb-5">1 Comment</div>
        <div className="grid grid-cols-10 gap-4">
          <div className="col-span-1 text-center justify-center">
            <Avatar className="ml-5">
              <AvatarImage src="https://github.com/shadcn.png" />
            </Avatar>
          </div>
          <div className="col-span-9 mb-[40px]">
            <div className="flex items-center">
              <span className="font-bold text-xl">A WordPress Commenter</span>
              <button className="hover:text-red-500 text-sm ml-auto">
                {" "}
                <RetweetOutlined /> Reply
              </button>
            </div>
            <span className="text-slate-400 text-sm">Tháng Một 18, 2021</span>
            <div className="mb-[20px]">
              To get started with moderating, editing, and deleting comments,
              please visit the Comments screen in the dashboard. Commenter
              avatars come from Gravatar.
            </div>
          </div>
        </div>

        <div className="font-semibold text-xl mb-[30px] ">
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
                  <div className="flex flex-col space-y-1.5">
                    <Label htmlFor="name">Comment</Label>
                    <Textarea className="h-[150px]" />
                  </div>
                </div>
              </form>
            </CardContent>
            <CardFooter className="flex justify-between">
              <Button className="hover:bg-lime-600">Deploy</Button>
            </CardFooter>
          </Card>
        </div>
      </div>
    </div>
  );
}
