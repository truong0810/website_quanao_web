import "./globals.scss";

import { Suspense } from 'react'
import { baseOpenGraph } from "@/app/(home)/shared-metadata";
import NextTopLoader from "nextjs-toploader";
import { Metadata } from "next";
import { Mulish } from "next/font/google";
import Navbar from "@/components/Layout/Navbar";
import { CartProvider } from '@/components/cart/CartProvider';
import { Toaster } from 'react-hot-toast';
import Footer from "@/components/Layout/Footer/Footer";
const mulish = Mulish({
  subsets: ["latin"], // Ngôn ngữ hỗ trợ
  weight: ["400", "600", "700"], // Các độ đậm bạn muốn sử dụng
});
export const metadata: Metadata = {
  title: "Trang-chủ",
  description: "Được tạo bởi ",
  openGraph: baseOpenGraph,
};
export default function RootLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  return (
    <html lang="en">
      <body className={mulish.className}>
      <Toaster />
      <Suspense>
        <div>
          <NextTopLoader color="#008000" />
          <CartProvider>
            <Navbar />
            <div
              className=""
              style={{ background: "#ffffff" }}
            >
              {children}
            </div>
          </CartProvider>
          <Footer />
        </div>
        </Suspense>
      </body>
    </html>
  );
}
