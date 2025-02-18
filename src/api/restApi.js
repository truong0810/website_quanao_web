import { STORAGE_KEY } from "../utils/constant";
// import * as _authApi from "./authApi";
import axios from "axios";
import { base_api } from "./config";
const keyUser = process.env.REACT_APP_KEY_LOCAL_USER;


const getToken = () => {
  let token = null;
if (typeof window !== "undefined" && typeof localStorage !== "undefined") {
    token = localStorage.getItem("token");
}
  if (!token) return null;
  return "Bearer " + token;
};
// const key_message = `open_message_api`;
const headerDefault = {
  Accept: "application/json, text/plain, */*",
  "Content-Type": "application/json",
};

const parseParams = (url, params) => {
  const qs = Object.keys(params)
    .map(
      (key) => `${encodeURIComponent(key)}=${encodeURIComponent(params[key])}`
    )
    .join("&");
  return url + "?" + qs;
};

function get(route, params = {}, signal, access_token = getToken()) {
  const headers = {
    authorization: access_token,
    ...headerDefault,
  };
  const url = parseParams(route, params);
  const options = { headers };
  if (signal) options.signal = signal;

  return axios({ url: url, ...options })
    .then((res) => res.data)
    .catch(catchError);
}

async function post(
  route,
  payload = {},
  params,
  signal,
  access_token = getToken()
) {
  let res = await postData2(route, payload, params, signal, access_token);
  return res;
}

const postData = async (_url, _body,) => {
  const formData = new FormData();
  Object.keys(_body).forEach((key) => {
    formData.append(key, _body[key]);
  });
  const requestOptions = {
    method: "POST",
    headers: {
      Authorization: `bearer ${token}`,
    },
    body: formData,
  };
  return fetch(_url, requestOptions)
    .then((res) => res.json())
    .then((data) => data);
};

async function postData2(
  route,
  payload = {},
  params = {},
  signal,
  access_token,
) {
  const headers = {
    authorization: access_token,
    ...headerDefault,
  };
  var url = route;
  if (params) {

    url = parseParams(route, params);
  }
  const options = { headers };
  if (signal) options.signal = signal;

  return axios({
    url: url,
    method: "POST",
    ...options,
    data: payload,
  })
    .then((res) => res.data)
    .catch(catchError);
}

function postDownload(
  route,
  payload,
  filename,
  signal,
  access_token = getToken()
) {
  const headers = {
    authorization: access_token,
    ...headerDefault,
  };
  const url = parseParams(route, "");
  const options = { headers };
  if (signal) options.signal = signal;

  return axios({
    url,
    method: "POST",
    ...options,
    data: JSON.stringify(payload),
    responseType: "blob",
  })
    .then((response) => {
      const url = window.URL.createObjectURL(response.data);
      const link = document.createElement("a");
      link.href = url;
      link.setAttribute("download", filename); //or any other extension
      document.body.appendChild(link);
      link.click();
    })
    .catch(catchError);
}
function put(route, payload, params = null, access_token = getToken()) {
  const headers = {
    authorization: access_token,
    ...headerDefault,
  };
  let url = route;
  if (params) {
    url = parseParams(route, params);
  }
  return axios({ url, method: "PUT", headers, data: payload })
    .then((res) => res.data)
    .catch(catchError);
}

function deleteRequest(route, params = {}, access_token = getToken()) {
  const headers = {
    authorization: access_token,
    ...headerDefault,
  };
  const url = parseParams(route, params);

  return axios({ url: url, method: "DELETE", headers })
    .then((res) => res.data)
    .catch(catchError);
}

function getWithoutAuth(route, params = {}) {
  const url = parseParams(route, params);
  return axios(url, { headers: { ...headerDefault } })
    .then((res) => res.data)
    .catch(catchError);
}

function postWithoutAuth(route, payload) {
  return axios({
    url: route,
    method: "POST",
    data: payload,
    headers: { ...headerDefault },
  })
    .then((res) => res.data)
    .catch(catchError);
}

function catchError(err) {
  console.log(err);
  // if (err.response.status === 401) {
  // let refreshToken = localStorage.getItem(STORAGE_KEY.REFRESH_TOKEN);
  // let resRefresh = await _authApi.refreshToken({
  //   refreshToken: refreshToken,
  // });
  // if (resRefresh && resRefresh.code == 1) {
  //   localStorage.setItem(STORAGE_KEY.TOKEN, resRefresh.token);
  //   callback();
  // } else {
  // localStorage.removeItem(keyUser);
  // localStorage.clear();
  // window.location.href = "/login";
  // }
  // }
  if (err.name === "AbortError") {
    console.log("Request aborted");
  } else {
    throw err;
  }
}
// axios.interceptors.request.use(
//   async (config) => {
//     const token = getToken();
//     if (!config.headers["Authorization"]) {

//       config.headers["Authorization"] = ` ${token}`;
//     }
//     return config;
//   },
//   (error) => {
//     return Promise.reject(error);
//   }
// );
let isRefreshing = false;
let failedQueue = [];

const processQueue = (error, token = null) => {
  failedQueue.forEach((prom) => {
    if (error) {
      prom.reject(error);
    } else {
      prom.resolve(token);
    }
  });

  failedQueue = [];
};
axios.interceptors.response.use(
  (response) => {
    return response;
  },
  async function (error) {
    const originalRequest = error.config;
    if (error?.response?.status === 401 && !originalRequest._retry) {
      if (isRefreshing) {
        return new Promise(function (resolve, reject) {
          failedQueue.push({ resolve, reject });
        })
          .then((token) => {
            originalRequest.headers["Authorization"] = "Bearer " + token;
            return axios(originalRequest);
          })
          .catch((err) => {
            return Promise.reject(err);
          });
      }
      originalRequest._retry = true;
      isRefreshing = true;

      const reToken = localStorage.getItem(STORAGE_KEY.REFRESH_TOKEN);
      return new Promise(function (resolve, reject) {
        axios
          .post(
            `${base_api}auth/refresh-token`,
            { refreshToken: reToken },
            { headers: { authorization: getToken(), ...headerDefault } }
          )
          .then(({ data }) => {
            if (data && data.code == 1) {
              localStorage.setItem(STORAGE_KEY.TOKEN, data.token);
               localStorage.setItem(STORAGE_KEY.REFRESH_TOKEN, data.refreshToken);
              axios.defaults.headers.common["Authorization"] =
                "Bearer " + data.token;
              originalRequest.headers["Authorization"] = "Bearer " + data.token;
              processQueue(null, data.token);
              resolve(axios(originalRequest));
            } else {
              localStorage.removeItem(keyUser);
              localStorage.clear();
              window.location.href = "/login";
            }
          })
          .catch((err) => {
            processQueue(err, null);
            reject(err);
          })
          .finally(() => {
            isRefreshing = false;
          });
      });
    }
    return Promise.reject(error);
  }
);
export {
  get,
  post,
  put,
  deleteRequest,
  getWithoutAuth,
  postWithoutAuth,
  postDownload,
  postData
};
