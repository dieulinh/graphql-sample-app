import axios from 'axios';
const ROOT_API_URL = process.env.API_SERVER_URL;

const signIn = async (email, password) => {
  console.log(ROOT_API_URL);
  const res = await axios.post(`${ROOT_API_URL}/api/login`, {email, password});
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