import { Metadata } from 'next';
// import ImageHeader from '../../image/contactUs3.jpg';
// import Image from 'next/image';

export const metadata :Metadata = {
  title: 'Liên hệ',
  description: 'Liên hệ',
};

export default function RootLayout({ children }) {
  return (
    <div>
      {/* <div className="mb-5 overflow-hidden text-center">
        <Image
          src={ImageHeader}
          alt="Contact Us Header"
          className="w-full h-auto"
        />
      </div> */}
      {children}
      <div id="box2" className="flex flex-col gap-5 p-5 bg-gray-100 rounded-lg shadow-lg">
        <div>
          <h3 className="text-xl font-semibold">Trụ sở chính:</h3>
          <p className="text-gray-700"> 92 A P. Lê Thanh Nghị, Bách Khoa, Hai Bà Trưng, Hà Nội</p>
        </div>
        <div>
          
          <iframe
             src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3724.7378276286568!2d105.84505327503064!3d21.003143880639765!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3135ac741bff22f3%3A0x3be1db0ed897b596!2zOTJhIFAuIEzDqiBUaGFuaCBOZ2jhu4ssIELDoWNoIEtob2EsIEhhaSBCw6AgVHLGsG5nLCBIw6AgTuG7mWksIFZp4buHdCBOYW0!5e0!3m2!1svi!2s!4v1737015505583!5m2!1svi!2s"
            width="100%"
            height="450"
            style={{ border: 0 }}
            loading="lazy"
            className="rounded-lg"
          ></iframe>
        </div>
      </div>
    </div>
  );
}
