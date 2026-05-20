<template>
  <div class="login-container">
    <div class="login-box">
      <div class="logo">
        <span class="logo-icon">💬</span>
        <h1>微信</h1>
      </div>
      
      <el-form ref="loginForm" :model="form" label-width="0px" class="login-form">
        <el-form-item>
          <el-input 
            v-model="form.phone" 
            placeholder="手机号" 
            prefix-icon="el-icon-phone"
            type="tel"
          />
        </el-form-item>
        
        <el-form-item>
          <el-input 
            v-model="form.password" 
            placeholder="密码" 
            prefix-icon="el-icon-lock"
            type="password"
          />
        </el-form-item>
        
        <el-form-item>
          <el-button type="primary" @click="login" class="login-btn">
            登录
          </el-button>
        </el-form-item>
        
        <div class="register-link">
          <span>还没有账号？</span>
          <a @click="goToRegister">立即注册</a>
        </div>
      </el-form>
    </div>
  </div>
</template>

<script setup>
import { ref } from 'vue'
import { useRouter } from 'vue-router'
import { useUserStore } from '../stores/user'
import axios from 'axios'

const router = useRouter()
const userStore = useUserStore()

const form = ref({
  phone: '',
  password: ''
})

const loginForm = ref(null)

const login = async () => {
  try {
    const response = await axios.post('/api/auth/login', {
      phone: form.value.phone,
      password: form.value.password
    })
    
    if (response.data.success) {
      userStore.setToken(response.data.data.token)
      router.push('/')
    } else {
      alert(response.data.message)
    }
  } catch (error) {
    alert(error.response?.data?.message || '登录失败')
  }
}

const goToRegister = () => {
  router.push('/register')
}
</script>

<style scoped>
.login-container {
  min-height: 100vh;
  display: flex;
  justify-content: center;
  align-items: center;
  background: linear-gradient(135deg, #07C160 0%, #10B981 100%);
}

.login-box {
  width: 400px;
  padding: 40px;
  background: white;
  border-radius: 16px;
  box-shadow: 0 10px 40px rgba(0, 0, 0, 0.1);
}

.logo {
  text-align: center;
  margin-bottom: 30px;
}

.logo-icon {
  font-size: 64px;
  display: block;
  margin-bottom: 10px;
}

.logo h1 {
  font-size: 28px;
  color: #07C160;
  font-weight: 600;
}

.login-form {
  width: 100%;
}

.login-form .el-input {
  height: 48px;
  margin-bottom: 20px;
}

.login-btn {
  width: 100%;
  height: 48px;
  font-size: 16px;
  background: linear-gradient(135deg, #07C160 0%, #10B981 100%);
  border: none;
}

.register-link {
  text-align: center;
  margin-top: 20px;
  color: #999;
}

.register-link a {
  color: #07C160;
  margin-left: 5px;
  cursor: pointer;
}
</style>