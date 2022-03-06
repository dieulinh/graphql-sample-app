import axios from 'axios';
const ROOT_API_URL = process.env.ROOT_API_URL;
const signIn = async (email, password) => {
  const res = await axios.post(`${ROOT_API_URL}/api/login`);
  if (res.data.token) {
    localStorage.setItem('user', JSON.stringify(res.data));
  }
  return res.data;
}
const getCurrentUser = () => {
  return JSON.parse(localStorage.getItem('user'))
}
const getUserToken = () => {
  const user = getCurrentUser();
  return user&&user.token;
}
const logOut = () => {
  localStorage.removeItem("user");
}
const User = {
  signIn,
  getCurrentUser,
  getUserToken,
  logOut
}
export default User;