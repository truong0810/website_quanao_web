import React from 'react'
import { SearchOutlined } from '@ant-design/icons';
export default function NoResultComponent() {
    return (
        <div className="flex flex-col items-center justify-center bg-gray-50 text-center py-5">
            <div className="mb-6">
                <SearchOutlined className="text-gray-400 text-6xl" />
            </div>
            <h2 className="text-xl font-medium text-gray-600 mb-2">Không tìm thấy kết quả nào</h2>
            <p className="text-gray-500 text-sm">Hãy thử sử dụng các từ khóa chung chung hơn</p>
        </div>
    )
}
