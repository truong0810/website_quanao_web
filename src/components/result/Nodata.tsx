"use client";

type NoDataComponentProps = {
  message?: string;
};

export default function NoDataComponent({ message = "Không có dữ liệu để hiển thị" }: NoDataComponentProps) {
  return (
    <div className="flex flex-col items-center justify-center h-[300px] bg-gray-100 border border-gray-300 rounded-lg shadow-md">
      <svg
        xmlns="http://www.w3.org/2000/svg"
        className="h-16 w-16 text-gray-500 mb-4"
        fill="none"
        viewBox="0 0 24 24"
        stroke="currentColor"
      >
        <path
          strokeLinecap="round"
          strokeLinejoin="round"
          strokeWidth={2}
          d="M12 4v16m8-8H4"
        />
      </svg>
      <p className="text-lg font-semibold text-gray-700">{message}</p>
    </div>
  );
}
