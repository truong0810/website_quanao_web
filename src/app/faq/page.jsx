import React from 'react'
import Link from "next/link";
export default function page() {
    const categories = [
        {
            id: 1,
            name: "Sử dụng ứng dụng",
            faqs: [
                { question: "Làm thế nào để sử dụng ứng dụng này?", answer: "Bạn chỉ cần đăng ký tài khoản và làm theo hướng dẫn trên màn hình." },
                { question: "Tôi có thể tải ứng dụng ở đâu?", answer: "Bạn có thể tải ứng dụng trên App Store hoặc Google Play." },
            ],
        },
        {
            id: 2,
            name: "Tài khoản và bảo mật",
            faqs: [
                { question: "Tôi có thể thay đổi mật khẩu ở đâu?", answer: "Bạn có thể thay đổi mật khẩu trong mục 'Cài đặt tài khoản'." },
                { question: "Làm thế nào để khôi phục tài khoản bị khóa?", answer: "Vui lòng liên hệ bộ phận hỗ trợ để được hỗ trợ khôi phục tài khoản." },
            ],
        },
        {
            id: 3,
            name: "Giá cả và nâng cấp",
            faqs: [
                { question: "Ứng dụng này có miễn phí không?", answer: "Ứng dụng miễn phí với các tính năng cơ bản, nhưng bạn có thể nâng cấp lên phiên bản Pro để sử dụng thêm các tính năng nâng cao." },
                { question: "Làm thế nào để nâng cấp tài khoản?", answer: "Bạn có thể nâng cấp tài khoản thông qua mục 'Nâng cấp' trong ứng dụng." },
            ],
        },
    ];
    return (
        <div className="min-h-screen bg-gray-50">
            <div className="mx-auto px-4 py-8">
                <h1 className="text-3xl font-bold text-gray-800 text-center mb-6">
                    Câu hỏi thường gặp
                </h1>
                <div className="grid grid-cols-[repeat(auto-fit,minmax(200px,1fr))] gap-8">
                    {categories.map((category) => (
                        <Link
                            key={category.id}
                            href={`/faq/${category.id}`}
                            className="p-8 border rounded-lg shadow-lg bg-white text-gray-800 hover:bg-blue-500 hover:text-white flex items-center justify-center text-center"
                        >
                            <div className="font-medium text-lg">{category.name}</div>
                        </Link>
                    ))}
                </div>
            </div>
        </div>
    )
}
