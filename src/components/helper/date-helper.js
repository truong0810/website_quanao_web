import dayjs from "dayjs";
import "dayjs/locale/vi";
dayjs.locale("vi");
export const parseFullDatetime = (date) => {
  try {
    if (!date) return "";
    const formatDate = new Date(date);
    let dd = addZero(formatDate.getDate());
    let mm = addZero(formatDate.getMonth() + 1); //January is 0!

    let yy = formatDate.getFullYear();
    return dd + " Tháng " + mm + " Năm " + yy;
  } catch (error) {
    console.log(error);
  }
};
function addZero(i) {
  if (i < 10) {
    i = "0" + i;
  }
  return i;
}

export const addHours = (date, h) => {
  date.setTime(date.getTime() + h * 60 * 60 * 1000);
  return date;
};
