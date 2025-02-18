'use client';
import React from 'react';
import { PhoneOutlined, MailOutlined } from '@ant-design/icons';

export default function Contact() {

    return (
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-10">
            <div className="grid grid-cols-1 md:grid-cols-2 gap-y-6 md:gap-x-6">
                {/* Left Column: Contact Info */}
                <div className="md:pr-8">
                    <h2 className="text-xl font-semibold mb-6 text-gray-800">
                        Có bất kỳ câu hỏi hay vấn đề khẩn cấp nào hãy liên hệ với chúng tôi
                    </h2>
                    <div id="connect" className="flex flex-col space-y-6">
                        {/* Phone contact */}
                        <div className="flex items-center space-x-4 hover:bg-gray-50 p-3 rounded-lg transition-all ease-in-out duration-300 transform hover:scale-105">
                            <PhoneOutlined className="text-2xl text-green-500" />
                            <p className="text-lg text-gray-800">+84 121 121 22</p>
                        </div>
                        {/* Email contact */}
                        <div className="flex items-center space-x-4 hover:bg-gray-50 p-3 rounded-lg transition-all ease-in-out duration-300 transform hover:scale-105">
                            <MailOutlined className="text-2xl text-blue-500" />
                            <p className="text-lg text-gray-800">CNT04@gmail.com</p>
                        </div>
                    </div>
                </div>

                {/* Right Column: Contact Form */}

            </div>
        </div>
    );
}
