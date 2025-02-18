import Image from "next/image";
import banner from "../../../image/contactUs3.jpg";
// eslint-disable-next-line @typescript-eslint/no-unused-vars
import styles from "./HomeHeader.module.scss";
import { RightCircleFilled, WechatOutlined } from "@ant-design/icons";
export function HomeBannder() {
  return (
    <div
      className="relative overflow-hidden rounded-md p-4"
      style={{
        width: "100%",
        height: "500px",
        marginBottom: "20px",
      }}
    >
      <Image
        src={banner}
        alt="Image"
        className="object-cover"
        layout="fill" // Hình ảnh tự động phù hợp với khung chứa
        objectFit="cover" // Đảm bảo ảnh không bị méo và không tràn ra ngoài
      />
      {/* ảnh trên chữ */}
      <div className="absolute top-0 left-0 text-overlay">
        <h3 className="text-title">Grade A Safety Masks For Sale. Hurry Up!</h3>
        <p className="text-sm mb-[20px]">
          Ut ultricies imperdiet sodales. Aliquam fringilla aliquam exs it amet
          elementum. Proin bibendum feugiat simplifies.
        </p>
        <div><WechatOutlined /> Express Delivery</div>
        <button className={"text-button"}>
          DISCOVER MORE <RightCircleFilled className="text-button-icon" />
        </button>
      </div>
    </div>
  );
}
