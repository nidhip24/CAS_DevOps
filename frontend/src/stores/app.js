// Utilities
import { defineStore } from 'pinia'
import axios from "axios"
import qs from 'qs'
import { useRouter } from 'vue-router';

const router = useRouter();

const API_URL = "http://backend-alb-223667824.us-east-1.elb.amazonaws.com:8080/v1"

export const useAppStore = defineStore('app', {
  state: () => ({
    internal: true,
    apps: []
  }),
  mutations: {
    setApps(state, apps) {
      state.apps = apps;
    }
  },
  actions: {
    async fetchUsers() {
      try {
        const data = await axios.get('https://jsonplaceholder.typicode.com/users')
        // this.users = data.data
        console.log(data.data);
        
      } catch (error) {
        alert(error)
        console.log(error)
      }
    },
    async saveApp(payload) {
      let config = {
        method: 'post',
        maxBodyLength: Infinity,
        url: `${API_URL}/api/app/create`,
        headers: { 
          'accept': 'application/json', 
          'Authorization': localStorage.getItem('access_token'),
          'Content-Type': 'application/json'
        },
        data : JSON.stringify(payload)
      };

      try {
        const response = await axios.request(config);
        return response
      } catch (error) {
        console.log(error)
        return error.response
      }
    },
    async fetchApps() {
      try {
        let config = {
          method: 'get',
          maxBodyLength: Infinity,
          url: `${API_URL}/api/app/list`,
          headers: { 
            'accept': 'application/json', 
            'Authorization': localStorage.getItem('access_token')
          }
        };
        const data = await axios.request(config)
        // this.users = data.data
        console.log(data.data)
        // commit('setApps', data.data.apps);
        this.apps = data.data.apps
        console.log(this.apps);
        
        
      } catch (error) {
        console.log(error)
        // if (error.response.status == 401) {
        //   router.push('/');
        // }
        return error.response
      }
    },
    async login(username, password) {
      try {

        let data = qs.stringify({
          'grant_type': 'password',
          'username': username,
          'password': password
        });
        
        let config = {
          method: 'post',
          maxBodyLength: Infinity,
          url: `${API_URL}/api/user/login`,
          headers: { 
            'accept': 'application/json', 
            'Content-Type': 'application/x-www-form-urlencoded'
          },
          data : data
        };

        const response = await axios.request(config);
        return response
      } catch (error) {
        console.log(error)
        return error.response
      }
    },
    async createUser(username, password) {
      try {

        let data = JSON.stringify({
          'username': username,
          'password': password
        });
        
        let config = {
          method: 'post',
          maxBodyLength: Infinity,
          url: `${API_URL}/api/user/register`,
          headers: { 
            'Content-Type': 'application/json'
          },
          data : data
        };

        const response = await axios.request(config);
        return response
      } catch (error) {
        console.log(error)
        return error.response
      }
    }
  },
})
