import React from 'react'
import { Metadata } from 'next'
export const metadata : Metadata = {
    title:"Cửa hàng",
    description:"Cửa hàng"
}
export default function Layout({children}) {
    return (
        <div>
            {children}
        </div>
    )
}
