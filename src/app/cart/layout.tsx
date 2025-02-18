import React from 'react'
import { Metadata } from 'next';
export const metadata: Metadata = {
  title : "Giỏ hàng",
  description : "Giỏ hàng"
}
export default function layout({ children }) {
    return (
        <div>
            {children}
        </div>
    )
}
