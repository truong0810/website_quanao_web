import Image from "next/image";
import HumanImage from "../../image/human.png";
import {
  CarOutlined,
  CustomerServiceOutlined,
  ReloadOutlined,
} from "@ant-design/icons";
export default function Page() {
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
    <div className="margin-main">
      {/* Section 1: Short Story */}
      <section className="py-5 px-2 md:px-6 flex flex-col md:flex-row items-center gap-10 ">
        <div className="w-full md:w-1/4">
          <Image
            src={HumanImage}
            alt="Short Story"
            width={500}
            height={500}
            className="rounded-lg w-full h-auto"
          />
        </div>
        <div className="w-full md:w-3/4 space-y-4 text-center md:text-left">
          <h2 className="text-3xl font-semibold">Giới thiệu về chúng tôi</h2>
          <p className="text-gray-700 leading-relaxed">
            Shop Thời Trang Dịu Hiền với phương châm là “ Sẽ luôn luôn là người
            bạn đồng hành cùng với phong cách thời trang của bạn”. Dịu hiền sẽ
            là một trong những shop đồ thời trang uy tín và chất lượng nhất tại
            Tp.HCM chúng tôi luôn mang đến cho khách hàng những sản phẩm mới
            nhất và chất lượng, giá thành hợp lý nhất tại cửa hàng Thời Trang
            Dịu Hiền dưới đây là đối nét giới thiệu cơ bản về Shop Thời Trang Nữ
            Cao Cấp Dịu Hiền.
          </p>
          <p className="text-gray-700 leading-relaxed">
            Cách Mà Thời Trang Dịu Hiền Tạo Dựng Thương Hiệu? Nhằm đáp ứng được
            nhu cầu của người tiêu dùng nên có rất nhiều shop thời trang hàng
            loạt được ra đời nhưng trong một khoảng thời gian ngắn rồi họ cũng
            lặng lẽ đóng cửa. Chắc có lẽ bạn cũng rất ngạc nhiên khi ai đó nói
            với bạn rằng chắc có một cửa hàng nhỏ lẻ, không thương hiệu mà lại
            tồn tại nhiều năm nay. Nhờ rút kinh nghiệm từ những shop cửa hàng
            nhỏ lẻ khác. Chính vì vậy mà Dịu Hiền một trong những cửa hàng shop
            thời trang nhỏ nhắn xinh xắn nằm trên tuyến đường Nguyễn Văn Lượng (
            Quận Gò Vấp, TP. Hồ Chí Minh ) nhờ được sự tin tưởng của khách hàng
            với hơn 800.000 lượt theo dõi nên Shop Thời Trang Nữ Cao Cấp Dịu
            Hiền đã đi được hơn 10 năm chặng đường kinh doanh trong lĩnh vực
            thời trang đã trở thành một trong những địa điểm bán thời trang uy
            tín nhất cho khách hàng lựa chọn.
          </p>
          <p className="text-gray-700 leading-relaxed">
            Khỏi nguồn từ niềm yêu thích của bạn thân Giới thiệu cơ bản về Thời
            Trang Dịu Hiền được ra đời dựa vào tình yêu mãnh liệt mà chị chủ đã
            dành hết cả tuổi thanh xuân để dành cho thời trang luôn mang đến cho
            khách những sản phẩm chất lượng tốt nhất đến cho bạn. Mặc dù shop
            dịu hiền không phải là một cửa hàng rất lớn nhưng ngay từ lúc ban
            đầu, Chị hiền đã xác định mục tiêu của mình làm gì và những khách
            hàng mà shop hướng tới là đối tượng nào. Tuy nhiên bên cạnh đó shop
            cũng đồng thời tìm ra những nét riêng cho shop mà cứ thế mà Shop
            Thời Trang Công Sở Dịu Hiền có được chỗ vững chắc trên thị trường
            Việt Nam hiện nay. Shop dịu hiền nhờ chọn được vị địa lý thuận lợi
            có rất nhiều dân văn phòng nên Dịu Hiền Shop hướng tới những khách
            hàng trẻ tuổi đặc biệt là những khách hàng có thu nhập tầm trung chủ
            yếu là nhân viên văn phòng…
          </p>
          <p className="text-gray-700 leading-relaxed">
            Đối với cộng đồng, chúng tôi luôn mong muốn đem lại những giá trị
            tốt đẹp nhất, đóng góp cho sự phát triển của xã hội và người tiêu dùng.
          </p>
          <p className="font-semibold text-base text-blue-500">CNT04</p>
        </div>
      </section>
      {/* Section 2: Features */}
      <section className="py-16 px-6 md:px-6 bg-white">
        <h2 className="text-center text-2xl font-semibold mb-8">
          Tại sao nên sử dụng sản phẩm của chúng tôi.
        </h2>
        <div className="grid grid-cols-1 md:grid-cols-3 gap-8 my-10">
          {items.map((item, index) => (
            <div
              key={index}
              className="p-6 bg-gray-100 rounded-lg shadow hover:shadow-lg transition flex items-center gap-4"
            >
              <div className="flex-shrink-0">{item.icon}</div>
              <div>
                <h3 className="text-lg font-semibold">{item.title}</h3>
                <p className="hidden text-gray-600 md:block">{item.desc}</p>
              </div>
            </div>
          ))}
        </div>
      </section>
    </div>
  );
}
