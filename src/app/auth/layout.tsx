import React from 'react'
import { Metadata } from 'next';
export const metadata: Metadata = {
  title : "Đăng ký",
  description : "Đăng ký"   
}
export default function layout({ children }) {
    return (
        <div>
            {children}
        </div>
    )
}
