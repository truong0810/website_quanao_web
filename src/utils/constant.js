export const StatusCharge = {
  DONE: "Thanh toán",
  UNPAID: "Chưa thanh toán",
  OPTION: [
    { value: "DONE", label: "Thanh toán" },
    { value: "UNPAID", label: "Chưa thanh toán" },
  ],
};
export const DocumentType = {
  Payment: "PAYMENT",
  Report: "REPORT",
  OPTION: [
    { value: "PAYMENT", label: "Thanh toán" },
    { value: "REPORT", label: "Báo cáo" },
  ],
};

export const DeviceStatus = {
  ACTIVE: 1,
  LOCKED: 0,
  OPTION: [
    { value: 1, label: "Kích hoạt" },
    { value: 0, label: "Khóa" },
  ],
};
export const SimStatus = {
  ACTIVE: true,
  LOCKED: false,
  OPTION: [
    { value: true, label: "Kích hoạt" },
    { value: false, label: "Khóa" },
  ],
};


export const STORAGE_KEY = {
  USER: "USER",
  TOKEN: "TOKEN",
  VEHICLES: "VEHICLES",
  PERMISSION: "PERMISSION",
  REFRESH_TOKEN: "REFRESH_TOKEN",
  POINTS: "POINTS",
};

export const PAGINATION = {
  page: 1,
  limit: 6,
  total: 0,
};
export const PAGINATIONMAX = {
  page: 1,
  limit: 99,
  total: 0,
};
export const FILE_EXTENSION = {
  WORD: [".doc", ".docm", ".docx", ".dot", ".dotm", ".dotx"],
  EXCEL: [
    ".xlsx",
    ".xlsm",
    ".xlsb",
    ".xltx",
    ".xltm",
    ".xls",
    ".xlt",
    ".xls",
    ".xlam",
    ".xla",
    ".xlw",
    ".xlr",
  ],
  XML: [".xml"],
  TEXT: [".txt"],
  PDF: [".pdf"],
  IMAGE: [".jpg", ".jpeg", ".png", ".gif"],
  FOLDER: "FOLDER",
};
