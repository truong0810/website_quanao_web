import ProductDetail from "@/module/product/ProductDetail";
import * as _unitOfNetwork from '../../../api'
import type { Metadata } from "next";
type Props = {
    params: Promise<{ productId: string }>;
}
async function fetchData(id: string) {
    const res = await _unitOfNetwork.getProductById({ id: id })
    if (res && res.code == 1) {
        return { product: res.product, images: res.images ,relatedProducts: res.relatedProducts}
    }
}
export async function generateMetadata(
    { params }: Props
): Promise<Metadata> {
    const id = (await params).productId
    const res = await _unitOfNetwork.getProductById({ id: id })
    return {
        title: res.product?.name,
        openGraph: {
            title: res.product?.name,
            images : [_unitOfNetwork.getLinkImage(res.images[0].fileName)]
        }
    }
}
export default async function Product({ params }: Props) {
    const resolvedParams = await params;
    const { productId } = resolvedParams;
    const { product, images,relatedProducts} = await fetchData(productId);
    return <div>
        <ProductDetail relatedProducts={relatedProducts} product={product} images={images} />
    </div>
}