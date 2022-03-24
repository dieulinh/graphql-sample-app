import axios from 'axios';

const signIn = async (email, password) => {
  const res = await axios.post(`/api/login`, {email, password});
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
const getUserRoles = () => {
  const user = getCurrentUser();
  return user&&user.roles
}
const logOut = () => {
  localStorage.removeItem("user");
}
const User = {
  signIn,
  getCurrentUser,
  getUserRoles,
  getUserToken,
  logOut
}
export default User;