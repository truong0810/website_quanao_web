import ProductImageCarousel from '../../components/product/ProductImageCarousel'
import ProductTab from '../../components/product/ProductTab'
import ListProductComponent from "../../components/product/ListProductComponent";
import AddToCartComponent from '../../components/product/AddToCartComponent'
import Link from 'next/link';
export default function ProductDetail({ product, images, relatedProducts }) {
  return (
    <div className="space-y-10 mb-10 margin-main mt-[30px]" style={{ fontFamily: "'Muli', sans-serif" }}>
      <div className="grid grid-cols-1 md:grid-cols-3 gap-10">
        {/* Carousel Section */}
        <div className="w-full flex justify-center items-center flex-col" >
          <ProductImageCarousel images={images} />
        </div>

        {/* Product Details Section */}
        <div className="w-full p-1 flex justify-center md:justify-start">
          <div className="space-y-4 max-w-4xl w-[600px]">
            <h1 className="text-3xl md:text-4xl font-semibold mb-2" style={{ fontSize: "40px" }}>
              {product?.name}
            </h1>
            <div className="text-2xl font-semibold text-green-700">
              {new Intl.NumberFormat('vi-VN', { style: 'currency', currency: 'VND' }).format(product?.pricePrecent || 0)}
            </div>
            <AddToCartComponent product={product} />
            <hr className="w-[100px] mb-2 border-t-2 border-gray-300" />

            <div className="text-sm text-gray-600 space-y-2">
              <div>Mã: {product?.code}</div>
              <div>Danh mục: <Link href={{
                pathname: "/products",
                query: { categoryId: product?.categoryId }
              }}>{product?.nameCategory}</Link> </div>
              <div>Thương hiệu: <Link href={{
                pathname: "/products",
                query: { brandId: product?.brandId }
              }}>{product?.nameBrand}</Link>
              </div>
            </div>
          </div>
        </div>
      </div>

      {/* Tabs Section */}
      <ProductTab product={product} />

      {/* Related Products Section */}
      <div className="mt-10">
        <div className="text-center text-2xl font-semibold mb-6">
          SẢN PHẨM LIÊN QUAN
        </div>
        <ListProductComponent products={relatedProducts} />
      </div>
    </div>

  );
}
