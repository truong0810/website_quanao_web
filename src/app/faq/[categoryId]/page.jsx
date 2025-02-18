import React from 'react'
export default function page(context) {
    const { categoryId } = context.params;
    const allCategories = [
        {
            id: 1,
            name: "Sử dụng ứng dụng",
            faqs: [
                { question: "Làm thế nào để sử dụng ứng dụng này?", answer: "abc" },
            ],
        },
        {
            id: 2,
            name: "Tài khoản và bảo mật",
            faqs: [
                { question: "Tôi có thể thay đổi mật khẩu ở đâu?", answer: "..." },
            ],
        },
    ];

    const category = allCategories.find((cat) => cat.id == categoryId);
    return (
        <div className="min-h-screen bg-gray-50">
            <div className="mx-auto px-4 py-8 ">
                <h1 className="text-3xl font-bold text-gray-800 text-center mb-6">
                    {category.name}
                </h1>
                <ul className="space-y-6">
                    {category.faqs.map((faq, index) => (
                        <li key={index} className="p-4 ">
                            <div className="text-xl font-semibold text-blue-600">
                                {index + 1}. {faq.question}
                            </div>
                            <p className="mt-2 text-lg text-gray-700">{faq.answer}</p>
                        </li>
                    ))}
                </ul>
            </div>
        </div>
    )
}
