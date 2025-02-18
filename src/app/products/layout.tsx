import { Metadata } from 'next';
import React from 'react'
export const metadata :Metadata = {
    title: 'Sản phẩm',
    description: 'Sản phẩm',
  };
export default function layout({children}) {
  return (
    <div>
        {children}
    </div>
  )
}
