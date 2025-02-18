import { Metadata } from "next";
import HomeSider from "@/module/home/HomeHeader/HomeSider";
// import { Carousel, CarouselContent } from "@/components/ui/carousel";
import ProductComponent from "../../components/product/ProductComponent";
import * as _unitOfNetwork from "../../api";
import { HomeBlog } from "@/module/home/HomeHeader/HomeBlog";
import { PAGINATIONMAX } from "@/utils/constant";
import Link from "next/link";
import "./home.scss";
import {
  CarOutlined,
  CustomerServiceOutlined,
  DoubleRightOutlined,
  ReloadOutlined,
} from "@ant-design/icons";
import HomeElementer from "@/module/home/HomeHeader/HomeElementer";
import Image from "next/image";
import banner1 from "../../image/banner_danh_muc-01.png";
import flashSalse from "../../image/flash_sale_het_-01__1_.png";

async function fetchData() {
  const pagination = { ...PAGINATIONMAX };
  const res = await _unitOfNetwork.getTrendingProducts();
  const res1 = await _unitOfNetwork.getNewProducts();
  const res3 = await _unitOfNetwork.getListBlog({ pagination: pagination });
  const res4 = await _unitOfNetwork.getAllPartner();
  const res5 = await _unitOfNetwork.getListBanner({ pagination: pagination });
  if (
    res1 &&
    res &&
    res3 &&
    res4 &&
    res5 &&
    res.code == 1 &&
    res1.code == 1 &&
    res3.code == 1 &&
    res4.code == 1 &&
    res5.code == 1
  ) {
    return {
      trendingProducts: res.products,
      newProducts: res1.products,
      blogs: res3.blogs,
      partners: res4.partners,
      banners: res5.banners,
    };
  }
}
export const metadata: Metadata = {
  title: "Shop quần áo",
  description: "",
};
export default async function Home() {
  const { banners, trendingProducts, newProducts, blogs, partners } = await fetchData();
  const items = [
    {
      title: "Miễn phí vận chuyển",
      desc: "Vận chuyển , giao hàng miễn phí cho các đơn trong nội thành Hà Nội.",
      icon: <CarOutlined className="text-blue-500 text-3xl" />,
    },
    {
      title: "Hỗ trợ 24/7",
      desc: "Chúng tôi hỗ trợ bạn mọi lúc, mọi nơi.",
      icon: <CustomerServiceOutlined className="text-green-500 text-3xl" />,
    },
    {
      title: "Dễ dàng đổi trả",
      desc: "Đổi trả thoải mái trong vòng 30 ngày.",
      icon: <ReloadOutlined className="text-red-500 text-3xl" />,
    },
  ];
  return (
    <>
      <div className="home-container" style={{ background: "#ffffff" }}>
        <section className="">
          <HomeSider banners={banners} />
          <div className="mb-[6vh] md:mb-[8vh] margin-main">
            <div className=" text-xl md:text-2xl font-bold text-center capitalize mt-[6vh] md:mt-[8vh] mb-[20px] ">
              <Image
                src={banner1}
                alt="banner.alt"
                layout="responsive"
                width={300}
                height={300}
                className=""
              />
            </div>

            <div className="grid grid-cols-2 gap-6 md:grid-cols-4">
              {trendingProducts &&
                trendingProducts
                  ?.slice(0, 12)
                  .map((item) => (
                    <ProductComponent
                      key={"trendingProduct" + item.id}
                      item={item}
                    />
                  ))}
            </div>
            <div className="text-center">
              <button className="bt-read-more">
                <Link href="/shop" className="text-end ">
                  <p className="text-sm md:text-base  runcate ">
                    Xem thêm <DoubleRightOutlined />
                  </p>
                </Link>
              </button>
            </div>
          </div>
          
          <div className="mb-[6vh] md:mb-[8vh] margin-main">
            <div className=" text-xl md:text-2xl font-bold text-center capitalize mt-[6vh] md:mt-[8vh] mb-[20px] ">
            <Image
                src={flashSalse}
                alt="flastSale.alt"
                layout="responsive"
                width={300}
                height={300}
                className=""
              />
            </div>

            <div className="grid grid-cols-2 gap-6 md:grid-cols-4">
              {newProducts &&
                newProducts
                  ?.slice(0, 12)
                  .map((item) => (
                    <ProductComponent
                      key={"newProduct" + item.id}
                      item={item}
                    />
                  ))}
            </div>
            <div className="text-center">
              <button className="bt-read-more">
                <Link href="/shop" className="text-end ">
                  <p className="text-sm md:text-base  runcate ">
                    Xem thêm <DoubleRightOutlined />
                  </p>
                </Link>
              </button>
            </div>
            <section className=" bg-white">
              <div className="grid grid-cols-1 md:grid-cols-3 gap-8 my-10">
                {items.map((item, index) => (
                  <div
                    key={index}
                    className="p-6 bg-gray-100 rounded-lg shadow hover:shadow-lg transition flex items-center gap-4"
                  >
                    <div className="flex-shrink-0">{item.icon}</div>
                    <div>
                      <h3 className="text-lg font-semibold">{item.title}</h3>
                      <p className="hidden text-gray-600 md:block">
                        {item.desc}
                      </p>
                    </div>
                  </div>
                ))}
              </div>
            </section>
          </div>
          <HomeBlog blogs={blogs} />
          <HomeElementer partners={partners} />
        </section>
      </div>
    </>
  );
}
