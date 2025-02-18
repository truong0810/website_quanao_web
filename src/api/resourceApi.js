import { postDownload, postData } from "./restApi";
import { base_api} from "./config";

export const uploadFileResource = (_body) => {
  return postData(`${base_api}Resource/upload`, _body);
};
export const deleteFile = (_body, _filename) => {
  return postDownload(`${base_api}Resource/delete`, _body, _filename);
};
export const downloadFile = (_body, _filename) => {
  return postDownload(`${base_api}Resource/download-file`, _body, _filename);
};
export const getLinkImageResource = (_id) => {
  return `${base_api}Resource/get-link-image/` + _id;
};
