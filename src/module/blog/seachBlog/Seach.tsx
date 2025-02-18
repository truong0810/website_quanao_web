"use client";
import { Input } from "@/components/ui/input";
import { SearchOutlined } from "@ant-design/icons";
import { useRouter } from "next/navigation";
import { useState } from "react";

export default function Seach() {
  const [searchTerm, setSearchTerm] = useState("");
  const router = useRouter();

  const handleSearch = () => {
    if (searchTerm.trim()) {
      router.push(`/blog/blogSearch?query=${encodeURIComponent(searchTerm)}`);
    }
  };

  const handleKeyDown = (e: React.KeyboardEvent) => {
    // if (searchTerm.trim() === "") {
    //   alert("Vui lòng nhập bài viết cần tìm!");
    //   return; // Dừng lại nếu không có dữ liệu
    // }
    if (e.key === "Enter") {
    
      handleSearch();
    }
  };

  return (
    <div className="w-full border-2 border-slate-200 text-center justify-center p-5 mb-[40px] ">
      <Input
        placeholder="Nhập bài viết cần tìm!"
        className="inline-block w-[88%] rounded-none border-r-0"
        value={searchTerm}
        onChange={(e) => setSearchTerm(e.target.value)}
        onKeyDown={handleKeyDown} // Thêm sự kiện onKeyDown
      />
      <button
        onClick={handleSearch}
        className="w-[12%] h-[36px] border bg-black hover:bg-lime-600"
      >
        <SearchOutlined className="text-xl text-white" />
      </button>
    </div>
  );
}
