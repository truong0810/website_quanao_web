import { Metadata } from 'next'
import React from 'react'
export const metadata : Metadata = {
  title:"FAQ",
  description: "FAQ"
}
export default function layout({children}) {
  return (
    <div>
        {children}
    </div>
  )
}
