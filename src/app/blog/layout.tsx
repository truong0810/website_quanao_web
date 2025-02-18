import BlogFunction from "@/module/blog/BlogFunction";

export default function layout({ children }) {
  return (
    <div className="mt-[20px]">
      {/* Header section */}
      {/* <div className="w-full h-[200px] bg-slate-100 mb-[40px] flex flex-col items-center justify-center">
        <div className="text-3xl font-semibold">Trang Blog</div>
        <div>Đường dẫn</div>
      </div> */}

      {/* Main content area */}
      <div className="grid grid-cols-1 md:grid-cols-3 gap-4 margin-main">
        {/* Content area */}
        <div className="md:col-span-2">{children}</div>

        {/* Sidebar */}
        <div className="pl-0 md:pl-5">
          <BlogFunction params={{}} />
        </div>
      </div>
    </div>
  );
}
