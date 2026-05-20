<template>
  <div class="register-container">
    <div class="register-box">
      <div class="logo">
        <span class="logo-icon">💬</span>
        <h1>注册</h1>
      </div>
      
      <el-form ref="registerForm" :model="form" label-width="0px" class="register-form">
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
          <el-input 
            v-model="form.nickname" 
            placeholder="昵称" 
            prefix-icon="el-icon-user"
          />
        </el-form-item>
        
        <el-form-item>
          <el-button type="primary" @click="register" class="register-btn">
            注册
          </el-button>
        </el-form-item>
        
        <div class="login-link">
          <span>已有账号？</span>
          <a @click="goToLogin">立即登录</a>
        </div>
      </el-form>
    </div>
  </div>
</template>

<script setup>
import { ref } from 'vue'
import { useRouter } from 'vue-router'
import axios from 'axios'

const router = useRouter()

const form = ref({
  phone: '',
  password: '',
  nickname: ''
})

const registerForm = ref(null)

const register = async () => {
  try {
    const response = await axios.post('/api/auth/register', {
      phone: form.value.phone,
      password: form.value.password,
      nickname: form.value.nickname
    })
    
    if (response.data.success) {
      alert('注册成功，请登录')
      router.push('/login')
    } else {
      alert(response.data.message)
    }
  } catch (error) {
    alert(error.response?.data?.message || '注册失败')
  }
}

const goToLogin = () => {
  router.push('/login')
}
</script>

<style scoped>
.register-container {
  min-height: 100vh;
  display: flex;
  justify-content: center;
  align-items: center;
  background: linear-gradient(135deg, #07C160 0%, #10B981 100%);
}

.register-box {
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

.register-form {
  width: 100%;
}

.register-form .el-input {
  height: 48px;
  margin-bottom: 20px;
}

.register-btn {
  width: 100%;
  height: 48px;
  font-size: 16px;
  background: linear-gradient(135deg, #07C160 0%, #10B981 100%);
  border: none;
}

.login-link {
  text-align: center;
  margin-top: 20px;
  color: #999;
}

.login-link a {
  color: #07C160;
  margin-left: 5px;
  cursor: pointer;
}
</style>