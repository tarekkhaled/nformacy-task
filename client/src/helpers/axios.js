import axios from "axios";

const nformacy_axios = axios.create({
  baseURL: "http://localhost:3001",
});

export default nformacy_axios;
