import axios from "axios";
import User from './User';
const server = axios.create({
  baseURL: process.env.API_SERVER_URL
})
server.interceptors.request.use((config) => {
  const token = User.getUserToken();
})