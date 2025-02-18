import React from 'react'
import { Metadata } from 'next';
export const metadata: Metadata = {
  title : "Thông tin công ty",
  description : "Thông tin công ty"
}
export default function Layout({children}) {
  return (
    <div>
      {children}
    </div>
  )
}
