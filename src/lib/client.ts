import axios from "axios";

export const PaperClient = axios.create({
  baseURL: "https://api.papermc.io",
  timeout: 8000,
  headers: {
    Accept: "application/json",
  },
});
