import type { NextConfig } from "next";

const nextConfig: NextConfig = {
  images: {
    domains: ['localhost'], // Thêm hostname của API hoặc domain bạn sử dụng
  },
};

export default nextConfig;

module.exports = {
  images: {
    domains: ['localhost'], // Thêm domain của ảnh
    remotePatterns: [
  
    {
      protocol: 'http',
      hostname: 'localhost', // Thêm các domain khác
      pathname: '/**', // Mọi đường dẫn từ domain này
    },
    {
      protocol: 'https',
      hostname: 'raw.githubusercontent.com', // Thêm các domain khác
      pathname: '/**', // Mọi đường dẫn từ domain này
    },
  ]
  },
  typescript: {
    // !! WARN !!
    // Dangerously allow production builds to successfully complete even if
    // your project has type errors.
    // !! WARN !!
    ignoreBuildErrors: true,
  },
};
