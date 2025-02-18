export const formatPrice = (price) => {
  return (price * 1000).toLocaleString('vi-VN', { style: 'currency', currency: 'VND' });
};
