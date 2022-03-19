import axios from "axios";
import User from './User';
const server = axios.create({

})
server.interceptors.request.use((config) => {
  const token = User.getUserToken();
  config.headers['Authorization'] = token;
  return config;
}, (err) => {
  Promise.reject(err);
});
export default server;